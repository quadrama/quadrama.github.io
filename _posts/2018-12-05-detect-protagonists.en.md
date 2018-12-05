---
title: "Detecting Protagonists and Title Figures in Plays"
authors:
- Janis Pagel
layout: post
categories:
- Article
- Technology
lang: en
ref: detect-protagonists
index: true
---

In a recent [paper]() (text in German), we investigated, how protagonists and title figures
can be detected in German plays and which features are important for a
machine learning model in order to conduct this classification. This
post can be seen as a supplement to the paper and will enable you to
conduct your own expriments on your own data.

<!--more-->
## Table of contents
{:.no_toc}

* ToC
{:toc}

## Basic setup

In order to run the following experiments, we need to set up some tools
and prepare the data. If you just want to test out the code, we provide
the data that we used in our experiments. First of all, we need the
data of the plays we want to analyse. We will use the GerDraCor data
from
[https://github.com/quadrama/data_gdc](https://github.com/quadrama/data_gdc).
This is data in table format, extracted from a
[GerDraCor Fork](https://github.com/quadrama/gerdracor) that we
created, using the [DramaNLP Pipeline](https://github.com/quadrama/DramaNLP).
If you would like to use your own data, you should bring it into the
same format as in
[https://github.com/quadrama/data_gdc](https://github.com/quadrama/data_gdc).

We now can load this data into [R](https://www.r-project.org/), which is the scripting language
that we will use. Basic knowledge of R is recommended in order to
follow this article. For reading in the data, we will use the
[DramaAnalysis](https://github.com/quadrama/DramaAnalysis) package.
Install the package as given on the website. Currently this is achieved by
running the following commands:

```R
# this is only necessary once per system
install.packages("devtools") 
library(devtools)

# Install newest stable version
install_github("quadrama/DramaAnalysis", build_vignettes = TRUE) 
```

We also need additional packages for the further course of this
article, as listed below.

```R
# Used libraries
library(DramaAnalysis)      # Retrieving and processing of the data
library(igraph)             # For calculating centrality measures
library(data.table)         # Powerful library extending the
                            # functionality of the build-in
                            # data.frame type
library(topicmodels)        # For training custom topic models
library(caret)              # Machine learning power house
```

In order to install all these package at once, issue the following
command:

```R
install.packages("igraph", "data.table", "topicmodels", "caret")
```

## Helper functions

We will implement certain functions that will automate processes we
will repeatedly use in the code below.

```R
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
```

## Reading in the data

**ToWrite**

```R
setup(collectionDirectory = "gdc")

# Load text IDs based on their genre
ids.corpora <- list(sd1=as.character(
                    scan("data/collections/sturm_und_drang",
                            what = "",
                            quiet = T)),
                    bt1=as.character(
                    scan("data/collections/buergerliches_trauerspiel",
                            what = "",
                            quiet = T)),
                    wk=as.character(
                    scan("data/collections/weimarer_klassik",
                            what = "",
                            quiet = T)),
                    pop=as.character(
                    scan("data/collections/populaere_stuecke",
                            what = "",
                            quiet = T)),
                    nat=as.character(
                    scan("data/collections/naturalismus",
                            what = "",
                            quiet = T)),
                    wm=as.character(
                    scan("data/collections/wiener_moderne",
                            what = "",
                            quiet = T)),
                    rom=as.character(
                    scan("data/collections/romantik",
                            what = "",
                            quiet = T)),
                    auf=as.character(
                    scan("data/collections/aufklaerung",
                            what = "",
                            quiet = T)),
                    vm=as.character(
                    scan("data/collections/vormaerz",
                            what = "",
                            quiet = T))
                    )
ids <- unique(Reduce(c, ids.corpora))

# Removed because no protagonists
negatives <- c()
ids <- setdiff(ids, negatives)

# Load the texts
texts <- loadSegmentedText(ids, defaultCollection = "gdc")
# Remove rows with unknown speakers
texts <- texts[!is.na(texts$Speaker.figure_surface)]
# Save texts for later use
save(texts, file="data/texts.RData")
```

In the above mentioned paper, we investigated both detecting
protagonists and title figures. From a technical point of view, the
classification of figures into protagonists or title figures follows
the same steps. We further proceed with using annotations that name
figures which are title figures, but you could as well replace it with
an annotation of protagonists or any other class of figures that might
be classified by the used features. We read in the annotations from a
file called `titlefigures.csv`. The format of that file follows the
structure

```csv
Drama1,Titlefigure1,
Drama2,Titlefigure2,Titlefigure3
Drama3,Titlefigure4,
.
.
.
```

i.e. the first column contains the drama ID, and all following columns
contain the ID of the title figure(s), depending on the number of title
figures for that play. In our data, there were never more than two
title figures for a play, but you might want to extend or reduce the number of
columns depending on your own data. Just make sure that the number of
commas for each row matches up to the maximal number of columns.
Given this kind of file, reading in the information is easy:

```R
heroes <- data.table(read.csv("data/titlefigures.csv",
                              header = FALSE))
heroes <- melt(heroes, id.vars = "V1", na.rm = TRUE)
heroes$variable <- NULL
heroes <- heroes[value!="",]
colnames(heroes) <- c("drama", "figure")
```

We additionally coerce the data table into a format that lists each
title figure on a separate row, together with the respective drama ID,
and rename the columns for more verbosity.

## Training of a topic model

We noticed that training a topic model on the data you want to classify
let to slightly better results than using a pre-trained model. If you
also would like to train a topic model on your own data, you might
proceed as follows:

```R
ldaModels <- list()
ft <- as.simple_triplet_matrix(as.matrix(frequencytable(texts,
                               normalize = FALSE)))
ldaModels$lda_5 <- LDA(ft, k=5, method="Gibbs")
ldaModels$lda_10 <- LDA(ft, k=10, method="Gibbs")
save(ldaModels, file = "data/ldaModels.RData")
```

The `texts` variable contains the texts we want to train the topic
model on and which we already read in in the section above. We use the
`frequencytable` function from the `DramaAnalysis` package in order to
create a frequency table containing word frequencies per drama and store it in `ft`. We then train
the topic models using the `topicmodels` package. You can experiment
with different models; we opted to use *Latent Dirichlet Allocation* in combination with
*Gibbs sampling* and train two models with 5 and 10 clusters
respectively. We then store the models for later use.

## Extraction of the features

It is time to extract all features we want to use to later train a
machine learning model. To that end, we load the previously loaded
texts and the topic model we wish to use. Furthermore, we extract all
IDs of the dramas we have annotations for. This way, we reduce the data
size and do not compute features for unnecessary texts.

```R
# Load the texts in case they are not in memory anymore
load("data/texts.RData")
# Load the topic models
load("data/ldaModels.RData")

ids.all <- Reduce(c, ids.corpora)
ids.all <- ids.all[ids.all %in% unique(paste0("gdc:",heroes$drama))]
```

We then iterate over all texts and store all figures of each play into a
giant `data.frame`, called `p`. This `data.frame` contains a list of all figures per
row and stores their ID, as well as the ID of the respective drama in
its columns. Additional columns store any kind of feature we wish to
use. In our case, this will be:

- Number of figures for a play
- Degree Centrality
- Weighted Degree Centrality
- Betweenness Centrality
- Closeness Centrality
- Eigenvector Centrality
- Posterior probability for each cluster of the topic model
- Presence in the last act
- Number of active scenes
- Number of passive scenes
- Number of uttered tokens
- Affiliation of a drama to a specific genre

There are also other types of information, such as the number of
utterances a figure makes or when the figure speaks firstly and lastly
and meta data, such as the number of scenes in a play or the overall number of
tokens in a play.
This information comes from functions located in the `DramaAnalysis`
package and gets automatically
merged into the final `data.frame`. We will not use this information in
the following experiments, but some of it might be useful for future
experiments and, of course, additional features can be added freely.
Now, have a look at the concrete code:

```R
p <- Reduce(rbind, lapply(setdiff(ids.all,negatives), function(x) {
  # Get a single text
  text <- texts[drama==removeCorpusPrefix(x, prefix = "gdc")]
  # Create a table with the characters
  char <- unique(texts[which(texts$drama==removeCorpusPrefix(x, prefix = "gdc")),c("corpus","drama", "Speaker.figure_surface", "Speaker.figure_id")])
  # Get the overall number of characters
  nfig <- nrow(char)
  # Create a presence matrix
  pres <- presence(text, passiveOnlyWhenNotActive = TRUE)
  # Get the number of tokens a character utters
  fstat <- figureStatistics(text)
  ft <- frequencytable(text, names=FALSE,
                       column="Token.lemma",normalize = FALSE,
                       byFigure=TRUE)
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
                   lastAct = as.numeric(confAct$matrix[,ncol(confAct$matrix)]))
  # Get a co-presence graph based on the co-presence matrix
  g <- graph_from_adjacency_matrix(copr, mode="upper",
                                   diag=FALSE, weighted = TRUE)
  # Calculate different centrality measures
  dg <- degree(g, normalized = TRUE)
  wdg <- strength(g)
  bt <- betweenness(g, normalized = TRUE)
  cn <- closeness(g, normalized = TRUE)
  ev <- eigen_centrality(g)
  # Get the posterior probability for a character to be part
  # of a certain topic, based on their uttered tokens
  post <- posterior(ldaModels$lda_10, ft)$topics
  post.df <- data.frame(figure=substr(rownames(post),8,100),post)
  # Merge all features into a feature table with each character
  # as a row
  pres <- merge(pres, char, 
                by.x=c("corpus","drama","figure"),
                by.y=c("corpus","drama","Speaker.figure_id"))
  pres$nfig <- rep(nfig, nrow(pres))
  pres <- merge(pres, lastAct)
  pres <- merge(pres, fstat)
  pres <- merge(pres, post.df, by=c("figure"))
  pres <- merge(pres, data.frame(degree=dg,figure=names(dg)))
  pres <- merge(pres, data.frame(wdegree=wdg,figure=names(wdg)))
  pres <- merge(pres, data.frame(between=bt,figure=names(bt)))
  pres <- merge(pres, data.frame(close=cn,figure=names(cn)))
  pres <- merge(pres, data.frame(eigen=ev$vector,
                                 figure=names(ev$vector)))
  # Return the feature table
  pres
}))
```

After `p` got created, we make some adjustments. The `drama` column
should be converted into factors. For better readability, we also
rename the columns which got automatically created by the topic model
and replace the generated `X` with `T` (for *topic*). The information
about
which drama belongs into which genre is independent of the figure and
can be added now. Lastly, we need to determine, wether a figure was
actually a title figure or not, based on our annotations. To achieve
this, we
use the previously created `heroes` `data.table` and store the classes
into a column `class`. If the figure belongs to the title figure class,
we store `1`, otherwise `0`. The labels are arbitrary though. Optionally, we might
also want to store the `data.frame` for later use.

```R
p$drama <- factor(p$drama)
names(p) <- gsub("X", "T", names(p), fixed = TRUE)

p$SD <- as.integer(paste(p$corpus, p$drama,sep=":")
                   %in% ids.corpora$sd1)
p$BT <- as.integer(paste(p$corpus, p$drama,sep=":")
                   %in% ids.corpora$bt1)
p$WK <- as.integer(paste(p$corpus, p$drama,sep=":")
                   %in% ids.corpora$wk)
p$POP <- as.integer(paste(p$corpus, p$drama,sep=":")
                   %in% ids.corpora$pop)
p$NAT <- as.integer(paste(p$corpus, p$drama,sep=":")
                   %in% ids.corpora$nat)
p$WM <- as.integer(paste(p$corpus, p$drama,sep=":")
                   %in% ids.corpora$wm)
p$ROM <- as.integer(paste(p$corpus, p$drama,sep=":")
                   %in% ids.corpora$rom)
p$AUF <- as.integer(paste(p$corpus, p$drama,sep=":")
                   %in% ids.corpora$auf)
p$VM <- as.integer(paste(p$corpus, p$drama,sep=":")
                   %in% ids.corpora$vm)

p$class <- ifelse(apply(p, 1, function(x) (if (any(x["drama"] == heroes$drama & x["figure"] == heroes$figure)) {TRUE} else {FALSE})),"1","0")
p$class <- factor(p$class)

save(p, file="data/p_titlefigures.RData")
```

## Prepare the data for classification

We now make some last adjustments before training a model on the
extracted feautres. We normalize the actives, passives and tokens
features by the overall length of the play. For plotting purposes, we
also bring the character surface string into a nice, title case format.
We then backup this original table and remove all information that the
machine learning should not have any access to. We save both the
original dataset and the training dataset into the variable `pTF`.

```R
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
  list(p=p,orig=orig)
}

pTF <- prepareData(p)
```

## Classification

First, we define the machine learing method we want to use. We will use
a random forest classifier in conjunction with the
[caret](https://cran.r-project.org/web/packages/caret/index.html) package, but other
classifiers are also viable. The function `testFeatureSet` is a
convenience method. It allows us to make sure that every time we call a
caret classification, the same seed will be set. We can also give in
the sampling method we wish to use. Furthermore, we can
experiment with different sets of features. The output of that function
is a list that contains the trained model, the input and output data of
that model, the variable importance for the features, a confusion
matrix of the result, the concrete prediction as well as the correct
and the incorrect predictions for later error analysis. We can also
already define different combinations of features we wish to try out.
The feature names are simply the column names of `pTF`.

```R
# Define which classifier to use
caretMethod <- "rf"
# Define the number of sampling repeats
repeatsVariable <- 10
# Set seed for the random number generator
seed <- 42
set.seed(seed)

testFeatureSet <- function(features, p, orig, sampling, seed=42) {
  set.seed(seed)
  fv <- as.matrix(subset(p, select=-c(class)))
  x <- fv[, features, drop=FALSE]
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
  cm  <- list(P = confusionMatrix(predictions,
                                  p$class,
                                  mode = "everything",
                                  positive = "1"),
              C = confusionMatrix(predictions,
                                  p$class,
                                  mode = "everything",
                                  positive = "0"))
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
```

We now simply call `testFeatureSet` with different features and the
desired sampling method. For example, as a simple baseline,
we could only use the `tokens` feature.
We also train two models, one with all features and one with all features minus the
tokens feature, respectively. As the sampling method, we make use of
`smote`. Afterwards, we save the models on disk for later use and
evaluation.

```R
results <- list()

results$TFTokensBL <- testFeatureSet("tokens",
                                     pTF$p,
                                     pTF$orig,
                                     sampling = "smote",
                                     seed)
results$TFoTokens <- testFeatureSet(featuresWithoutTokens,
                                    pTF$p,
                                    pTF$orig,
                                    sampling = "smote",
                                    seed)
results$TF <- testFeatureSet(features,
                             pTF$p,
                             pTF$orig,
                             sampling = "smote",
                             seed)

save(results, file = "data/results.RData")
```

## Evaluating the results

**ToDo**