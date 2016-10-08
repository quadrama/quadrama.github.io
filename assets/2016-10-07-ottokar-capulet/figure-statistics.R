library(DramaAnalysis)
library(jsonlite)

t <- load.text(c("vndf.0", "r0px.0", "rksp.0"), tokens = TRUE)
t <- limit.figures.by.rank(t)

fstat <- figure.statistics(t, names=TRUE)

mat <- matrix(data=c(fstat[,3]),ncol=3)
colnames(mat) <- c("Romeo und Julia (Ü: Schlegel)", "Die Familie Schroffenstein", "Emilia Galotti")
mat <- apply(mat, 2, function(x) {sort(x, decreasing=TRUE)})

pdf("Plots/speech-distribution-vndf.0-r0px.0.pdf")
barplot(mat, beside=F, col=qd.colors, border=NA,ylab = "Tokens")
text(x=c(0.7,0.7,1.9,1.9,3.1),
     y=c(mat[1,1]/2, sum(mat[1,1]+mat[2,1]/2), mat[1,2]/2, sum(mat[1:2,2])+mat[3,2]/2, sum(mat[1:4,3])+mat[5,3]/2),
     labels=c("Romeo", "Julia", "Ottokar", "Agnes", "Emilia"), col=c("white"))
dev.off()

png("Plots/speech-distribution-vndf.0-r0px.0.png", width=700, height=500, bg = "transparent")
barplot(mat, beside=F, col=qd.colors, border=NA,ylab = "Tokens")
text(x=c(0.7,0.7,1.9,1.9,3.1),
     y=c(mat[1,1]/2, sum(mat[1,1]+mat[2,1]/2), mat[1,2]/2, sum(mat[1:2,2])+mat[3,2]/2, sum(mat[1:4,3])+mat[5,3]/2),
     labels=c("Romeo", "Julia", "Ottokar", "Agnes", "Emilia"), col=c("white"))
dev.off()

# json export
ranks <- tapply(fstat$tokens, INDEX=fstat$drama, FUN = rank)
for (i in seq(1:10)) {print(toJSON(fstat[fstat$rank==i,1:3]))}
# and copy paste
