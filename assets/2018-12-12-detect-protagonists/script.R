##################################
# this is only necessary once per system
#install.packages("devtools") 
# Install newest stable version
#install_github("quadrama/DramaAnalysis", build_vignettes = TRUE)
#installData(dataSource = "gdc")
#installCollectionData()

#install.packages(c("igraph", "data.table", "tibble", 
#                 "slam", "topicmodels", "caret",
#                 "ggplot2", "iml", "tools"))
##################################

# Used libraries
library(devtools)           # Install from GitHub
library(DramaAnalysis)      # Main package
library(igraph)             # For calculating centrality measures
library(data.table)         # Powerful library extending the
                            # functionality of the build-in
                            # data.frame type
library(tibble)             # Yet another data.frame implementation
library(slam)               # Sparse lightweight arrays and matrices
library(topicmodels)        # For training custom topic models
library(caret)              # Machine learning power house
library(ggplot2)            # Advanced plotting
library(iml)                # Interpretable machine learning
library(tools)              # For title case

# Remove the corpus prefix from text IDs
removeCorpusPrefix <- function(str, prefix = "tg") {
  sapply(strsplit(str, paste0(prefix,":"), fixed = T),
         function(x) (if (is.na(x[2])) {x} else {x[2]}))
}

# The iml package does not make it easy to round the feature
# values for plotting. This function takes the strings of feature
# values coming from iml, transforms them into numbers, rounds them
# and returns the strings with the rounded values.
roundFeatures <- function(featureVector, n_digits = 2) {
  features <- lapply(strsplit(featureVector, "="),
                     function(x) x[1])
  values <- round(as.numeric(lapply(strsplit(featureVector, "="),
                                    function(x) x[2])),
                  digits = n_digits)
  paste0(features, "=", values)
}

# Load text IDs based on their genre
ids.corpora <- list(sd=as.character(loadSet("sturm_und_drang")),
                    bt=as.character(loadSet(
                      "buergerliches_trauerspiel")),
                    wk=as.character(loadSet("weimarer_klassik")),
                    pop=as.character(loadSet("populaere_stuecke")),
                    nat=as.character(loadSet("naturalismus")),
                    wm=as.character(loadSet("wiener_moderne")),
                    rom=as.character(loadSet("romantik")),
                    auf=as.character(loadSet("aufklaerung")),
                    vm=as.character(loadSet("vormaerz"))
)
ids.corpora <- lapply(ids.corpora, 
                      function(x) (gsub("tg", "gdc", x, fixed = TRUE)))
ids.all <- unique(Reduce(c, ids.corpora))
ids.all <- removeCorpusPrefix(ids.all)

# Load the texts
texts <- loadSegmentedText(ids.all, defaultCollection = "gdc")
# Remove rows with unknown speakers
texts <- texts[!is.na(texts$Speaker.figure_surface)]
# Save texts for later use
save(texts, file="data/texts.RData")

heroes <- data.table(read.csv("data/titlefigures.csv",
                              header = FALSE))
heroes <- melt(heroes, id.vars = "V1", na.rm = TRUE)
heroes$variable <- NULL
heroes <- heroes[value!="",]
colnames(heroes) <- c("drama", "figure")

ldaModels <- list()
ft <- as.simple_triplet_matrix(as.matrix(frequencytable(texts,
                                                        normalize = FALSE)))
ldaModels$lda_5 <- LDA(ft, k = 5, method = "Gibbs")
ldaModels$lda_10 <- LDA(ft, k = 10, method = "Gibbs")
save(ldaModels, file = "data/ldaModels.RData")

# Load the texts in case they are not in memory anymore
#load("data/texts.RData")
# Load the topic models if necessary
#load("data/ldaModels.RData")

ids <- ids.all[ids.all %in% unique(heroes$drama)]

p <- Reduce(rbind, lapply(ids, function(x) {
  # Get a single text
  text <- texts[drama==x]
  # Create a table with the characters
  char <- unique(texts[which(texts$drama==x),
    c("corpus",
      "drama", 
      "Speaker.figure_surface", 
      "Speaker.figure_id")])
  # Get the overall number of characters
  nfig <- nrow(char)
  # Create a presence matrix
  pres <- presence(text, passiveOnlyWhenNotActive = TRUE)
  # Get the number of tokens a character utters
  fstat <- figureStatistics(text)
  ft <- frequencytable(text, names = FALSE,
                       column = "Token.lemma", normalize = FALSE,
                       byFigure = TRUE)
  # Create a co-presence matrix
  conf <- configuration(text,by="Scene",onlyPresence = TRUE,
                        useCharacterId = TRUE)
  copr <- conf$matrix %*% t(conf$matrix)
  rownames(copr) <- conf$figure
  colnames(copr) <- conf$figure
  # Find out if a character appeared in the last act
  confAct <- configuration(text, by="Act", onlyPresence = TRUE,
                           useCharacterId = TRUE)
  lastAct <- cbind(confAct$drama, figure = confAct$figure,
                   lastAct = as.numeric(confAct$matrix[,
                                                       ncol(confAct$matrix)]))
  # Get a co-presence graph based on the co-presence matrix
  g <- graph_from_adjacency_matrix(copr, mode = "upper",
                                   diag = FALSE, weighted = TRUE)
  # Calculate different centrality measures
  dg <- degree(g, normalized = TRUE)
  wdg <- strength(g)
  bt <- betweenness(g, normalized = TRUE)
  cn <- closeness(g, normalized = TRUE)
  ev <- eigen_centrality(g)
  # Get the posterior probability for a character to be part
  # of a certain topic, based on their uttered tokens
  post <- posterior(ldaModels$lda_10, ft)$topics
  post.df <- data.frame(figure = substr(rownames(post), 
                                        8, 
                                        100), 
                        post)
  # Merge all features into a feature table with each character
  # as a row
  pres <- merge(pres, char, 
                by.x = c("corpus", "drama", "figure"),
                by.y = c("corpus", "drama", "Speaker.figure_id"))
  pres$nfig <- rep(nfig, nrow(pres))
  pres <- merge(pres, lastAct)
  pres <- merge(pres, fstat)
  pres <- merge(pres, post.df, by = c("figure"))
  pres <- merge(pres, data.frame(degree = dg, figure = names(dg)))
  pres <- merge(pres, data.frame(wdegree = wdg, figure = names(wdg)))
  pres <- merge(pres, data.frame(between = bt, figure = names(bt)))
  pres <- merge(pres, data.frame(close = cn, figure = names(cn)))
  pres <- merge(pres, data.frame(eigen = ev$vector,
                                 figure = names(ev$vector)))
  # Return the feature table
  pres
}))

p$drama <- factor(p$drama)
names(p) <- gsub("X", "T", names(p), fixed = TRUE)

p$SD <- as.integer(paste(p$corpus, p$drama, sep = ":")
                   %in% ids.corpora$sd)
p$BT <- as.integer(paste(p$corpus, p$drama, sep = ":")
                   %in% ids.corpora$bt)
p$WK <- as.integer(paste(p$corpus, p$drama, sep = ":")
                   %in% ids.corpora$wk)
p$POP <- as.integer(paste(p$corpus, p$drama, sep = ":")
                    %in% ids.corpora$pop)
p$NAT <- as.integer(paste(p$corpus, p$drama, sep = ":")
                    %in% ids.corpora$nat)
p$WM <- as.integer(paste(p$corpus, p$drama, sep = ":")
                   %in% ids.corpora$wm)
p$ROM <- as.integer(paste(p$corpus, p$drama, sep = ":")
                    %in% ids.corpora$rom)
p$AUF <- as.integer(paste(p$corpus, p$drama, sep = ":")
                    %in% ids.corpora$auf)
p$VM <- as.integer(paste(p$corpus, p$drama, sep = ":")
                   %in% ids.corpora$vm)

p$class <- ifelse(apply(p, 1, function(x) (if (any(x["drama"] ==
                                                   heroes$drama & x["figure"] == heroes$figure)) 
{TRUE} else {FALSE})),
"TF",
"NTF")
p$class <- factor(p$class)

save(p, file = "data/p.RData")

prepareData <- function(p) {
  p[is.na(p)] <- 0
  p <- na.omit(p)
  
  p$actives <- p$actives/p$scenes
  p$passives <- p$passives/p$scenes
  p$tokens <- p$tokens/p$length
  p$presence <- NULL
  p$Speaker.figure_surface <- toTitleCase(tolower(
    as.character(
      p$Speaker.figure_surface)))
  orig <- p
  p$corpus <- NULL
  p$figure <- NULL
  p$length <- NULL
  p$scenes <- NULL
  p$Speaker.figure_surface <- NULL
  p$drama <- as.integer(p$drama)
  list(p = p, orig = orig)
}

pTF <- prepareData(p)

# Define which classifier to use
caretMethod <- "rf"
# Define the number of sampling repeats
repeatsVariable <- 10
# Set seed for the random number generator
seed <- 42
set.seed(seed)

testFeatureSet <- function(features, p, orig, sampling, seed = 42) {
  set.seed(seed)
  fv <- as.matrix(subset(p, select = -c(class)))
  x <- fv[, features, drop = FALSE]
  x <- as.data.frame(x)
  control <- trainControl(method = "repeatedcv", 
                          number = 10,
                          repeats = repeatsVariable, 
                          savePredictions = "all",
                          sampling = sampling,
                          classProbs = TRUE)
  model <- train(x = x,
                 y = p$class,
                 method = caretMethod,
                 trControl = control, 
                 preProc = c("center", "scale"))
  if (length(features) > 1) {
    varI <- varImp(model, scale = FALSE)
  } else {
    varI <- data.frame()
  }
  predictions <- predict(model, x)
  cm  <- list(TF = confusionMatrix(predictions,
                                   p$class,
                                   mode = "everything",
                                   positive = "TF"),
              NTF = confusionMatrix(predictions,
                                    p$class,
                                    mode = "everything",
                                    positive = "NTF"))
  pred <- data.frame(orig[,c("corpus", "drama", "figure", "BT",
                             "WK", "SD", "POP", "NAT",
                             "WM", "ROM", "AUF", "VM")],
                     pred = predictions, ref = orig[, "class"])
  falsePredictions <- pred[pred$pred != pred$class, ]
  correctPredictions <- pred[pred$pred == pred$class, ]
  list(model = model, x = x, y = p$class, imp = varI, cm = cm,
       pred = pred, correct = correctPredictions,
       mistakes = falsePredictions)
}

features <- c(c("BT" ,"WK", "SD", "POP", "NAT", "WM", "ROM",
                "AUF", "VM"),
              "tokens",
              c("degree", "wdegree", "close", "eigen", "between"),
              c("actives", "passives"),
              paste0("T",1:10),
              "nfig",
              "lastAct")
featuresWithoutTokens <- c(c("BT" ,"WK", "SD", "POP", "NAT",
                             "WM", "ROM", "AUF", "VM"),
                           c("degree", "wdegree", "close",
                             "eigen", "between"),
                           c("actives", "passives"),
                           paste0("T",1:10),
                           "nfig",
                           "lastAct")

results <- list()

results$TokensBL <- testFeatureSet("tokens",
                                   pTF$p,
                                   pTF$orig,
                                   sampling = "smote",
                                   seed)
results$woTokens <- testFeatureSet(featuresWithoutTokens,
                                   pTF$p,
                                   pTF$orig,
                                   sampling = "smote",
                                   seed)
results$All <- testFeatureSet(features,
                              pTF$p,
                              pTF$orig,
                              sampling = "smote",
                              seed)

save(results, file = "data/results.RData")

cm <- results$All$cm$TF$table

dfTF <- data.frame(lapply(results, function(x) {x$cm$TF$byClass}))
dfNTF <- data.frame(lapply(results, function(x) {x$cm$NTF$byClass}))
dfO <- data.frame(lapply(results, function(x) {x$cm$NTF$overall}))

dfEval <- rbind(dfTF, dfNTF, dfO)
dfEval <- dfEval[c("Precision", "Recall", "F1", "Accuracy"),]

imp <- results$All$imp$importance %>%
  as.data.frame() %>%
  rownames_to_column() %>%
  ggplot(aes(x = reorder(rowname, Overall), y = Overall)) +
  geom_bar(stat = "identity", alpha = 0.8) +
  coord_flip() +
  labs(x = "Feature", y = "Importance")

chars <- c("emilia", "marinelli")
predChar <- results$All$pred[results$All$pred$figure %in% chars &
                               results$All$pred$drama == "rksp.0", ][, c("corpus", "drama", "figure", "class", "pred")]

x <- results$All$x
y <- results$All$y
predictor <- Predictor$new(results$All$model, data = x, y = y)

charID <- rownames(results$All$pred[
  results$All$pred$figure == "emilia"
  & results$All$pred$drama == "rksp.0", ])
shapley <- Shapley$new(predictor, x.interest = x[charID, ])
# Round the feature values so that they don't clutter the plot
shapley$results$feature.value <-
  roundFeatures(shapley$results$feature.value)
shapley_emilia <- shapley$results[
  which(shapley$results$class == "TF"), ] %>% 
  ggplot(aes(x = reorder(feature.value, -phi),
             y = phi)) +
  geom_bar(stat = "identity", alpha = 0.8) +
  coord_flip() +
  labs(x = "Feature", y = "phi")

charID <- rownames(results$All$pred[
  results$All$pred$figure == "marinelli"
  & results$All$pred$drama == "rksp.0", ])
shapley$explain(x.interest = x[charID, ])
shapley$results$feature.value <-
  roundFeatures(shapley$results$feature.value)
shapley_marinelli <- shapley$results[
  which(shapley$results$class == "TF"), ] %>% 
  ggplot(aes(x = reorder(feature.value, -phi),
             y = phi)) +
  geom_bar(stat = "identity", alpha = 0.8) +
  coord_flip() +
  labs(x = "Feature", y = "phi")
