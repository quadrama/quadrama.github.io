---
title: "Ein explorativer Zugang zu Gesundheit in literarischen Texten"
authors: 
- Nils Reiter
layout: post
ref: drama-und-gesundheit
index: true
lang: de
date: 2019-04-30
categories:
- Vorträge
---




Am 30.04.2019 hat [Nils Reiter](https://nilsreiter.de) im Rahmen der [Ringvorlesung "Gesundheit verstehen – Digital Humanities im Dialog"](https://www.herma.uni-hamburg.de/news/events/2019-ringvorlesung.html) einen Vortrag zur quantitativen Dramenanalyse gehalten, mit Fokus auf das Thema Gesundheit. Der Vortrag hatte zwei Hauptteile, einen inhaltlichen und einen methodischen. Der methodische Teil basiert auf einem Artikel, der "demnächst" erscheinen sollte. Den inhaltlichen Teil gebe ich hier kurz wieder, zusammen mit dem Code um die Analysen zu reproduzieren und nachzuvollziehen. Da es sich um eine Exploration handelt, werden die Ergebnisse hier lediglich dargestellt. Eine Interpretation und Reflektion würde sich nun anschließen, war aber nicht Teil des Vortrages.

R-Code: Die Beschreibung unten enthält ebenfalls den R-Code der benutzt wurde um die Grafiken zu erstellen. Der Code ist weitgehend unkommentiert (Programmierer sagen dazu: selbsterklärend 😎). Wer die Analysen nachbauen möchte, kann sich gerne per [E-Mail](mailto:nils.reiter@ims.uni-stuttgart.de) melden.


{% highlight r %}
ids.all <- loadAllInstalledIds()

meta.all <- loadMeta(ids.all)

ids.gdc <- ids.all[startsWith(ids.all,"gdc")]

mtext <- loadSegmentedText(c("gdc:rksp.0","gdc:rjmw.0"))
mtext$Speaker.figure_surface <- factor(tools::toTitleCase(tolower(  as.character(mtext$Speaker.figure_surface))))
{% endhighlight %}


## Gesundheit in Dramen



{% highlight r %}
wf_names <- list.files("wordfields/")
wf <- lapply(wf_names, function(x) {
  tolower(readLines(paste("wordfields",x,sep="/")))
})
names(wf) <- substring(wf_names, 6)
names(wf) <- lapply(strsplit(substring(wf_names, 6), ".", fixed=TRUE), `[[`, 1)
{% endhighlight %}


### Wortfeldanalyse

Methodische Grundlage sind Wortfelder, also Sammlungen thematisch zusammenhängender Wörter (nicht: Wörter mit gleicher Bedeutung). Die Wortfelder hier basieren auf der achten, erweiterten Auflage des "Dornseiff", einer Einteilung des deutschen Wortschatzes nach Sachgruppen (Dornseiff et al., 2010). Für uns interessant sind zunächst drei Sachgruppen: Gesundheit (2.23, 102 Wörter), Krankheit (2.33, 451 Wörter) und Behandlung (2.35, 378 Wörter). Zum Einblick hier 20 zufällig ausgewählte Wörter aus den drei Sachgruppen:



{% highlight r %}
set.seed(1)



knitr::kable(data.frame(Gesundheit = paste(sample(wf$Gesundheit, size=20), collapse=", "),
                        Krankheit  = paste(sample(wf$Krankheit,  size=20), collapse=", "),
                        Behandlung = paste(sample(wf$Behandlung, size=20), collapse=", ")), 
             format="html", booktabs=TRUE, caption = "Zufällige 20 Wörter je Wortfeld")
{% endhighlight %}

<table>
<caption>Zufällige 20 Wörter je Wortfeld</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Gesundheit </th>
   <th style="text-align:left;"> Krankheit </th>
   <th style="text-align:left;"> Behandlung </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> gesundheitsamt, impfausweis, rüstig, strotzen, gesundheitsschutz, blühen, auf dem damm sein, wohlgemut, stabil, schaffenskraft, zustand, untersuchungsergebnis, wohlauf, gesundheitszentrum, nichts zugestoßen, gesundheitsexperte, ertüchtigen, gesundheitsgefährdend, gesundheitspolitik, unversehrt </td>
   <td style="text-align:left;"> übertragbar, feuermal, weicher schanker, krankheit des bewegungsapparates, glatze, schluckauf, anfall, lungentuberkulose, heruntergekommen, blutarmut, kröpf, melancholie, diabetes, hexenschuss, pflegebedürftiger, tripper, aidskranker, ast, grippe, kotzen </td>
   <td style="text-align:left;"> schmerzstillend, betriebsarzt, krankenpfleger, seebad, militärhospital, wieder wohlauf sein, heilmethode, poliklinik, orthopäde, heilpraktiker, krankenhaus, unschädlich, rezeptblock, physiotherapie, hygiene, blutsenkung, medizin, universitätsklinik, anästhesist, ärztehaus </td>
  </tr>
</tbody>
</table>

#### Berechnung eines Scores


Die folgenden Wortfeldanalysen basieren darauf, dass wir die Häufigkeit von Wörtern aus bestimmten Wortfeldern in Textabschnitten messen. Dazu sind alle Texte zunächst automatisch lemmatisiert worden. Die absolute Häufigkeit der Wörter wird dann doppelt normalisiert: a) an der Länge des Textabschnittes und b) an der Größe des Wortfeldes. Wenn $*$*die Menge der Wörter im Wortfeld beschreibt und $*w*die Sequenz der Wörter in einem Textabschnitt, dann ergibt sich der Score aus der folgenden Formel:

$$s(t,w) = |t \cap w|\times\frac{1}{|w|}\times\frac{1}{|t|}$$

Diese Art der Ermittlung hat zwei offensichtliche Schwachstellen: Mehrwortausdrücke (die in den Dornseiff-Listen enthalten sind, etwa "auf dem Damm sein") werden so nicht gefunden und ambige Wörter werden nicht unterschieden (das Wort "Bank" etwa, würde sowohl dem Wortfeld "Finanzen" als auch dem Wortfeld "Möbel" zugeordnet). Zudem finden sich schon der obigen Liste Wörter, die mit ziemlicher Sicherheit nicht in Dramen des 18. und 19. Jahrhunderts vorkommen (wie z.B. Rezeptblock oder Gesundheitsamt).


#### Verteilungen bei Emilia Galotti und Miss Sara Sampson


{% highlight r %}
dstat <- dictionaryStatistics(mtext, byFigure = FALSE, fields=wf[3:5], normalizeByFigure = TRUE, normalizeByField = TRUE)

barplot(t(as.matrix(dstat[,3:5])),beside=TRUE,col = qd.colors[c(1,4,7)], names.arg = c("Miss Sara Sampson", "Emilia Galotti"), legend.text = colnames(dstat[,3:5]),las=1)
{% endhighlight %}

![Globalsicht]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-4-1.png)




{% highlight r %}
mtext.rksp.0 <- mtext[drama=="rksp.0",]
mtext.rksp.0$Speaker.figure_surface <-   factor(tools::toTitleCase(tolower(  as.character(mtext.rksp.0$Speaker.figure_surface))))

dstat <- dictionaryStatistics(mtext.rksp.0, fields=wf[3:5], column="Token.lemma", normalizeByFigure = TRUE, names=TRUE, normalizeByField = TRUE)


barplot(t(as.matrix(dstat[,4:6])),                   # what to plot
        las=1,                     # turn axis labels
        names.arg=dstat$figure,
        legend.text = colnames(dstat[,4:6]),
        cex.names=0.6,             # smaller font on x axis
        beside=TRUE,
        main="Emilia Galotti",
        col=qd.colors[c(1,4,7)]              # colors
        
      )
{% endhighlight %}

![Emilia Galotti]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-5-1.png)



{% highlight r %}
mtext.rksp.0 <- mtext[drama=="rjmw.0",]
mtext.rksp.0$Speaker.figure_surface <-   factor(as.character(mtext.rksp.0$Speaker.figure_surface))

dstat <- dictionaryStatistics(mtext.rksp.0, fields=wf[3:5], column="Token.lemma", normalizeByFigure = TRUE, names=TRUE, normalizeByField = TRUE)


barplot(t(as.matrix(dstat[,4:6])),                   # what to plot
        las=1,                     # turn axis labels
        names.arg=dstat$figure,
        legend.text = colnames(dstat[,4:6]),
        cex.names=0.6,             # smaller font on x axis
        beside=TRUE,
        main="Miss Sara Sampson",
        col=qd.colors[c(1,4,7)]              # colors
        
      )
{% endhighlight %}

![Miss Sara Sampson]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-6-1.png)



{% highlight r %}
dstat <- dictionaryStatistics(mtext, fields=wf[3:5], column="Token.lemma", normalizeByFigure = TRUE, names=TRUE, normalizeByField = TRUE)

selection <- c(22, 37, 17, 35, 23, 43)
d2 <- dstat[selection,3:6]
rownames(d2) <- d2$figure
d2 <- subset(d2, select=c(2:4))
rownames(d2) <- dstat$figure[selection]

barplot(t(as.matrix(d2)), beside = TRUE, names.arg = dstat$figure[selection], las=1, col = qd.colors[c(1,4,7)], legend.text = colnames(dstat)[4:6],ylim=c(0,6e-06), main="Figurentypen im Vergleich")
{% endhighlight %}

![Figurentypen im Vergleich]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-7-1.png)

#### Welche Wörter?

Der direkte Vergleich basierend auf Häufigkeiten von Wortfeldern kann leicht zu Fehlinterpretationen kommen. Es ist daher sinnvoll anzuschauen welche Wörter es eigentlich sind, die von den Figuren gesprochen werden.

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Typ </th>
   <th style="text-align:left;"> Wortfeld </th>
   <th style="text-align:left;"> Emilia Galotti </th>
   <th style="text-align:left;"> Miss Sara Sampson </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Töchter </td>
   <td style="text-align:left;"> Behandlung </td>
   <td style="text-align:left;width: 12em; "> pflegen, bessern </td>
   <td style="text-align:left;width: 12em; "> betäuben, heilen, beruhigen, betäubung, helfen, pflegen, bessern, gesund </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Verführer </td>
   <td style="text-align:left;"> Krankheit </td>
   <td style="text-align:left;width: 12em; "> schwermut, liegen, elend, leiden, liegen, liegen, elend </td>
   <td style="text-align:left;width: 12em; "> elend, schwach, elend, elend, gefährlich, ansteckend, gefährlich, fall, elend, liegen, fall, ernst, übel, übel, schmerz, schmerz, ohnmacht, erbrechen, ohnmacht, schmerz </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Väter </td>
   <td style="text-align:left;"> Krankheit </td>
   <td style="text-align:left;width: 12em; "> tödlich, schmerz, fall, fall, liegen </td>
   <td style="text-align:left;width: 12em; "> elend, gefährlich, schwach, schwach </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Väter </td>
   <td style="text-align:left;"> Gesundheit </td>
   <td style="text-align:left;width: 12em; ">  </td>
   <td style="text-align:left;width: 12em; "> kräftig </td>
  </tr>
</tbody>
</table>

Eine Erkenntis hier ist, dass Gesundheitswörter vor allem metaphorisch gebraucht werden (`Liebeskrank').

## Zooming out





Neben der Einzeltextanalyse habe ich ebenfalls versucht eine etwas globalere Sicht auf das Thema Gesundheit im Drama zu erhalten. Die folgenden Analysen wurden auf einem Korpus bestehend aus 76 Tragödien und 81 Komödien erstellt. Die  Tabelle am Ende der Seite zeigt die Metadaten der Dramen.



{% highlight r %}
dstat.comedy <- dictionaryStatistics(mtext.comedy, byFigure = FALSE, fields=wf, normalizeByFigure = TRUE)
dstat.tragedy <- dictionaryStatistics(mtext.tragedy, byFigure = FALSE, fields=wf, normalizeByFigure = TRUE)
{% endhighlight %}


{% highlight r %}
dstat.tragedy$genre <- "Tragödie"
dstat.comedy$genre <- "Komödie"

dstat.both <- rbind(dstat.tragedy, dstat.comedy)

boxplot(Gesundheit ~genre, data=dstat.both, xlim=c(0,9), ylim=c(0,0.006), las=1, col=qd.colors[1], cex.axis=0.5)
boxplot(Krankheit ~genre, data=dstat.both,  add=TRUE, yaxt = "n", at=4:5, col=qd.colors[4], cex.axis=0.5)
boxplot(Behandlung ~genre, data=dstat.both, add=TRUE, yaxt = "n", at=7:8, col=qd.colors[7], cex.axis=0.5)
text(x=c(1.5, 4.5, 7.5), y=0.005, labels=c("Gesundheit", "Krankheit", "Behandlung"))
{% endhighlight %}

![plot of chunk unnamed-chunk-11]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-11-1.png)

Die Boxplots zeigen keine großen Unterschiede zwischen Komödien und Tragödien, allerdings weisen Komödien in allen Wortfeldern eine größere Streuung auf, was als Zeichen dafür gelesen werden kann, dass Komödien die weniger reglementierte Gattung ist.

Auch hier stellt sich die Frage, welche Wörter eigentlich verwendet wurden. Aus Gründen der Lesbarkeit befinden sich diese Tabellen ebenfalls im Anhang.

### Diachrone Entwicklung

Untersuchungen der Diachronie, also des zeitlichen Verlaufs sind ebenfalls von Interesse. Die nachfolgenden Abbildungen zeigen die relative Häufigkeit der jeweiligen Wortfelder im Gesamttext und bilden diese auf einem Zeitstrahl ab.


{% highlight r %}
diac.comedy <- merge(meta.comedy, dstat.comedy, by.x=c("drama"), by.y="figure")
diac.tragedy <- merge(meta.tragedy, dstat.tragedy, by.x=c("drama"), by.y="figure")

diac.comedy <- diac.comedy[diac.comedy$Date.Printed!=0,]
diac.tragedy <- diac.tragedy[diac.tragedy$Date.Printed!=0,]

diac.comedy <- diac.comedy[order(Date.Printed),]
diac.tragedy <- diac.tragedy[order(Date.Printed),]
{% endhighlight %}


{% highlight r %}
wfname <- "Gesundheit"

plot(x=diac.comedy$Date.Printed, 
     y=diac.comedy[[wfname]], type="p", pch=20, main=wfname, 
     ylab="Relative Häufigkeit", 
     xlab="Jahr",
     col=qd.colors[2])
lines(loess.smooth(x=diac.comedy$Date.Printed, 
                   y=diac.comedy[[wfname]]), 
      lty="dashed",
      col=qd.colors[2])
points(x=diac.tragedy$Date.Printed, 
       y=diac.tragedy[[wfname]], 
       pch=4,col=qd.colors[10])
lines(loess.smooth(x=diac.tragedy$Date.Printed, 
                   y=diac.tragedy[[wfname]]),
      lty="dotdash",
      col=qd.colors[10])
legend(x="topright", 
       legend = c("Komödie", "Tragödie"), 
       pch=c(20,4), 
       lty=c("dashed","dotdash"),
       col=qd.colors[c(2,10)])
{% endhighlight %}

![plot of chunk unnamed-chunk-13]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-13-1.png)


{% highlight r %}
wfname <- "Krankheit"

plot(x=diac.comedy$Date.Printed, 
     y=diac.comedy[[wfname]], type="p", pch=20, main=wfname, 
     ylab="Relative Häufigkeit", 
     xlab="Jahr",
     col=qd.colors[2])
lines(loess.smooth(x=diac.comedy$Date.Printed, 
                   y=diac.comedy[[wfname]]), 
      lty="dashed",
      col=qd.colors[2])
points(x=diac.tragedy$Date.Printed, 
       y=diac.tragedy[[wfname]], 
       pch=4, col=qd.colors[10])
lines(loess.smooth(x=diac.tragedy$Date.Printed, 
                   y=diac.tragedy[[wfname]]), 
      lty="dotdash",
      col=qd.colors[10])
legend(x="topright", 
       legend = c("Komödie", "Tragödie"), 
       pch=c(20,4), 
       lty=c("dashed","dotdash"),
       col=qd.colors[c(2,10)])
{% endhighlight %}

![plot of chunk unnamed-chunk-14]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-14-1.png)


{% highlight r %}
wfname <- "Behandlung"

plot(x=diac.comedy$Date.Printed, 
     y=diac.comedy[[wfname]], 
     type="p", pch=20, main=wfname, 
     ylab="Relative Häufigkeit", 
     xlab="Jahr", col=qd.colors[2])
lines(loess.smooth(x=diac.comedy$Date.Printed, 
                   y=diac.comedy[[wfname]]),
      lty="dashed", col=qd.colors[2])

points(x=diac.tragedy$Date.Printed, 
       y=diac.tragedy[[wfname]], 
       pch=4,col=qd.colors[10])
lines(loess.smooth(x=diac.tragedy$Date.Printed, 
                   y=diac.tragedy[[wfname]]), 
      lty="dotdash",col=qd.colors[10])

legend(x="topright", 
       legend = c("Komödie", "Tragödie"), 
       pch=c(20,4), 
       lty=c("dashed","dotdash"),col=qd.colors[c(2,10)])
{% endhighlight %}

![plot of chunk unnamed-chunk-15]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-15-1.png)




### Wo im Drama?




{% highlight r %}
dstat.comedy <- lapply(unique(mtext.comedy$drama), function(dr) {
  dstat <- dictionaryStatistics(mtext.comedy[drama==dr,], byFigure = FALSE, fields=wf, normalizeByFigure = TRUE, segment="Act")
  dstat$figure <- 1:nrow(dstat)
  dstat
})

dstat.tragedy <- lapply(unique(mtext.tragedy$drama), function(dr) {
  dstat <- dictionaryStatistics(mtext.tragedy[drama==dr,], byFigure = FALSE, fields=wf, normalizeByFigure = TRUE, segment="Act")
  dstat$figure <- 1:nrow(dstat)
  dstat
})

dstat.comedy <- Reduce(rbind, dstat.comedy)
dstat.tragedy <- Reduce(rbind, dstat.tragedy)

acts.comedy <- dstat.comedy[,.N,.(drama)]
acts.tragedy <- dstat.tragedy[,.N,.(drama)]

dstat.comedy.acts <- list(
  three=dstat.comedy[dstat.comedy$drama %in% acts.comedy[acts.comedy$N==3,]$drama,],
  five=dstat.comedy[dstat.comedy$drama %in% acts.comedy[acts.comedy$N==5,]$drama,]
  )

dstat.tragedy.acts <- list(
  three=dstat.tragedy[dstat.tragedy$drama %in% acts.tragedy[acts.tragedy$N==3,]$drama,],
  five=dstat.tragedy[dstat.tragedy$drama %in% acts.tragedy[acts.tragedy$N==5,]$drama,]
)
{% endhighlight %}

Letztlich betrachten wir, in welchen Abschnitten innerhalb der Dramen die Wörter aus den drei Bereichen erwähnt werden. Aus Gründen der Vergleichbarkeit wurden dabei ausschließlich **Fünfakter** (24 Komödien und 55 Tragödien) untersucht. Gezeigt wird die *durchschnittliche* relative Häufigkeit von Wörtern aus dem Wortfeld je Akt.


{% highlight r %}
df <- data.frame(Komoedie=dstat.comedy.acts$five[,mean(Gesundheit),.(figure)]$V1,
                 Tragoedie=dstat.tragedy.acts$five[,mean(Gesundheit),.(figure)]$V1)

barplot(t(df),beside=TRUE,col=qd.colors[c(2,10)],legend.text = c("Komödie","Tragödie"),names.arg = as.roman(1:5),las=1,main="Gesundheit", args.legend = list(x="bottomleft",bg="white"))
{% endhighlight %}

![plot of chunk unnamed-chunk-17]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-17-1.png)





{% highlight r %}
df <- data.frame(Komoedie=dstat.comedy.acts$five[,mean(Krankheit),.(figure)]$V1,
                 Tragoedie=dstat.tragedy.acts$five[,mean(Krankheit),.(figure)]$V1)

barplot(t(df),beside=TRUE,col=qd.colors[c(2,10)],legend.text = c("Komödie","Tragödie"),names.arg = as.roman(1:5),las=1,main="Krankheit", args.legend = list(x="bottomleft",bg="white"))
{% endhighlight %}

![plot of chunk unnamed-chunk-18]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-18-1.png)



{% highlight r %}
df <- data.frame(Komoedie=dstat.comedy.acts$five[,mean(Behandlung),.(figure)]$V1,
                 Tragoedie=dstat.tragedy.acts$five[,mean(Behandlung),.(figure)]$V1)

barplot(t(df),beside=TRUE,col=qd.colors[c(2,10)],legend.text = c("Komödie","Tragödie"),names.arg = as.roman(1:5),las=1,main="Behandlung", args.legend = list(x="bottomleft",bg="white"))
{% endhighlight %}

![plot of chunk unnamed-chunk-19]({{ site.baseurl }}/assets/2019-04-30-drama-und-gesundheit/unnamed-chunk-19-1.png)

# Ressourcen

- [Vortragsfolien vom 30.04.](/assets/2019-04-30-drama-und-gesundheit/slides.pdf)

# Bibliographie

Dornseiff, Franz, Uwe Quasthoff, Herbert Ernst Wiegand, et al. 2010. *Der deutsche Wortschatz nach Sachgruppen. Mit einer lexikographisch-historischen Einführung und einer ausführlichen Bibliographie zur Lexikographie und Onomasiologie*. Berlin, Boston: De Gruyter.

# Anhang

## Korpus

<table>
 <thead>
  <tr>
   <th style="text-align:left;"> Autor_in </th>
   <th style="text-align:left;"> Titel </th>
   <th style="text-align:right;"> Druckdaten </th>
   <th style="text-align:left;"> Gattung </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Goethe, Johann Wolfgang </td>
   <td style="text-align:left;"> Der Bürgergeneral </td>
   <td style="text-align:right;"> 1793 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Goethe, Johann Wolfgang </td>
   <td style="text-align:left;"> Der Großkophta </td>
   <td style="text-align:right;"> 1792 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Goethe, Johann Wolfgang </td>
   <td style="text-align:left;"> Die Mitschuldigen </td>
   <td style="text-align:right;"> 1909 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Auenbrugger, Johann Leopold von </td>
   <td style="text-align:left;"> Der Rauchfangkehrer </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ayrenhoff, Cornelius Hermann von </td>
   <td style="text-align:left;"> Der Postzug oder die noblen Passionen </td>
   <td style="text-align:right;"> 1769 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bauernfeld, Eduard von </td>
   <td style="text-align:left;"> Industrie und Herz </td>
   <td style="text-align:right;"> 1847 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bauernfeld, Eduard von </td>
   <td style="text-align:left;"> Großjährig </td>
   <td style="text-align:right;"> 1846 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bauernfeld, Eduard von </td>
   <td style="text-align:left;"> Bürgerlich und Romantisch </td>
   <td style="text-align:right;"> 1837 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Benedix, Julius Roderich </td>
   <td style="text-align:left;"> Die Lügnerin </td>
   <td style="text-align:right;"> 1862 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Benedix, Julius Roderich </td>
   <td style="text-align:left;"> Die Hochzeitsreise </td>
   <td style="text-align:right;"> 1862 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Blumenthal, Oskar </td>
   <td style="text-align:left;"> Im weißen Rößl </td>
   <td style="text-align:right;"> 1898 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Borkenstein, Hinrich </td>
   <td style="text-align:left;"> Der Bookesbeutel </td>
   <td style="text-align:right;"> 1742 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Büchner, Georg </td>
   <td style="text-align:left;"> Leonce und Lena </td>
   <td style="text-align:right;"> 1838 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Cronegk, Johann Friedrich von </td>
   <td style="text-align:left;"> Der Mißtrauische </td>
   <td style="text-align:right;"> 1760 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Devrient, Philipp Eduard </td>
   <td style="text-align:left;"> Die Gunst des Augenblicks </td>
   <td style="text-align:right;"> 1836 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Eichendorff, Joseph von </td>
   <td style="text-align:left;"> Die Freier </td>
   <td style="text-align:right;"> 1833 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Essig, Hermann </td>
   <td style="text-align:left;"> Der Frauenmut </td>
   <td style="text-align:right;"> 1912 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Freytag, Gustav </td>
   <td style="text-align:left;"> Die Journalisten </td>
   <td style="text-align:right;"> 1854 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gellert, Christian Fürchtegott </td>
   <td style="text-align:left;"> Die zärtlichen Schwestern </td>
   <td style="text-align:right;"> 1747 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gellert, Christian Fürchtegott </td>
   <td style="text-align:left;"> Die Betschwester </td>
   <td style="text-align:right;"> 1745 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gottsched, Luise Adelgunde Victorie </td>
   <td style="text-align:left;"> Das Testament </td>
   <td style="text-align:right;"> 1745 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gutzkow, Karl </td>
   <td style="text-align:left;"> Das Urbild des Tartüffe </td>
   <td style="text-align:right;"> 1847 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hafner, Philipp </td>
   <td style="text-align:left;"> Der Furchtsame </td>
   <td style="text-align:right;"> 1764 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hebbel, Friedrich </td>
   <td style="text-align:left;"> Der Rubin </td>
   <td style="text-align:right;"> 1851 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hippel, Theodor Gottlieb von </td>
   <td style="text-align:left;"> Der Mann nach der Uhr, oder der ordentliche Mann </td>
   <td style="text-align:right;"> 1765 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hofmannsthal, Hugo von </td>
   <td style="text-align:left;"> Der Unbestechliche </td>
   <td style="text-align:right;"> 1929 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hofmannsthal, Hugo von </td>
   <td style="text-align:left;"> Der Schwierige </td>
   <td style="text-align:right;"> 1917 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Iffland, August Wilhelm </td>
   <td style="text-align:left;"> Figaro in Deutschland </td>
   <td style="text-align:right;"> 1790 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kleist, Heinrich von </td>
   <td style="text-align:left;"> Amphitryon </td>
   <td style="text-align:right;"> 1807 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kleist, Heinrich von </td>
   <td style="text-align:left;"> Penthesilea </td>
   <td style="text-align:right;"> 1808 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kleist, Heinrich von </td>
   <td style="text-align:left;"> Der zerbrochene Krug </td>
   <td style="text-align:right;"> 1811 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kotzebue, August von </td>
   <td style="text-align:left;"> Die deutschen Kleinstädter </td>
   <td style="text-align:right;"> 1803 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kotzebue, August von </td>
   <td style="text-align:left;"> Die Indianer in England </td>
   <td style="text-align:right;"> 1790 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kotzebue, August von </td>
   <td style="text-align:left;"> Die beiden Klingsberg </td>
   <td style="text-align:right;"> 1801 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Krüger, Johann Christian </td>
   <td style="text-align:left;"> Die Candidaten oder Die Mittel zu einem Amte zu gelangen </td>
   <td style="text-align:right;"> 1748 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Krüger, Johann Christian </td>
   <td style="text-align:left;"> Die Geistlichen auf dem Lande </td>
   <td style="text-align:right;"> 1743 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Laube, Heinrich </td>
   <td style="text-align:left;"> Gottsched und Gellert </td>
   <td style="text-align:right;"> 1846 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Die alte Jungfer </td>
   <td style="text-align:right;"> 1749 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Der Freigeist </td>
   <td style="text-align:right;"> 1755 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Minna von Barnhelm, oder das Soldatenglück </td>
   <td style="text-align:right;"> 1767 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Der junge Gelehrte </td>
   <td style="text-align:right;"> 1754 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Der Misogyn </td>
   <td style="text-align:right;"> 1755 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Die Juden </td>
   <td style="text-align:right;"> 1754 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Der Schatz </td>
   <td style="text-align:right;"> 1755 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Damon, oder die wahre Freundschaft </td>
   <td style="text-align:right;"> 1747 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Malß, Karl </td>
   <td style="text-align:left;"> Der alte Bürger-Capitain </td>
   <td style="text-align:right;"> 1820 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Mylius, Christlob </td>
   <td style="text-align:left;"> Die Schäferinsel </td>
   <td style="text-align:right;"> 1749 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Neuber, Friederike Caroline </td>
   <td style="text-align:left;"> Das Schäferfest oder Die Herbstfreude </td>
   <td style="text-align:right;"> 1754 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Platen, August von </td>
   <td style="text-align:left;"> Die verhängnisvolle Gabel </td>
   <td style="text-align:right;"> 1826 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Platen, August von </td>
   <td style="text-align:left;"> Der romantische Ödipus </td>
   <td style="text-align:right;"> 1829 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Quistorp, Theodor Johann </td>
   <td style="text-align:left;"> Der Hypochondrist </td>
   <td style="text-align:right;"> 1745 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Raupach, Ernst </td>
   <td style="text-align:left;"> Kritik und Antikritik </td>
   <td style="text-align:right;"> 1827 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schlegel, Johann Elias </td>
   <td style="text-align:left;"> Die stumme Schönheit </td>
   <td style="text-align:right;"> 1747 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schlegel, Johann Elias </td>
   <td style="text-align:left;"> Der geschäftige Müßiggänger </td>
   <td style="text-align:right;"> 1743 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schlegel, Johann Elias </td>
   <td style="text-align:left;"> Der Triumph der guten Frauen </td>
   <td style="text-align:right;"> 1748 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Weißenthurn, Johanna von </td>
   <td style="text-align:left;"> Das Manuscript </td>
   <td style="text-align:right;"> 1817 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Weißenthurn, Johanna von </td>
   <td style="text-align:left;"> Welcher ist der Bräutigam </td>
   <td style="text-align:right;"> 1821 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Scheerbart, Paul </td>
   <td style="text-align:left;"> Okurirasûna </td>
   <td style="text-align:right;"> 1904 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Boßdorf, Hermann </td>
   <td style="text-align:left;"> De rode Ünnerrock </td>
   <td style="text-align:right;"> 1923 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Dulk, Albert </td>
   <td style="text-align:left;"> Die Wände </td>
   <td style="text-align:right;"> 1848 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ruederer, Josef </td>
   <td style="text-align:left;"> Die Fahnenweihe </td>
   <td style="text-align:right;"> 1895 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Anzengruber, Ludwig </td>
   <td style="text-align:left;"> Der Gwissenswurm </td>
   <td style="text-align:right;"> 1874 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Anzengruber, Ludwig </td>
   <td style="text-align:left;"> Heimg'funden </td>
   <td style="text-align:right;"> 1885 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hartleben, Otto Erich </td>
   <td style="text-align:left;"> Hanna Jagert </td>
   <td style="text-align:right;"> 1893 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hauptmann, Carl </td>
   <td style="text-align:left;"> Der Antiquar </td>
   <td style="text-align:right;"> 1909 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hebbel, Friedrich </td>
   <td style="text-align:left;"> Der Diamant </td>
   <td style="text-align:right;"> 1847 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hofmannsthal, Hugo von </td>
   <td style="text-align:left;"> Der Rosenkavalier </td>
   <td style="text-align:right;"> 1911 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lautensack, Heinrich </td>
   <td style="text-align:left;"> Hahnenkampf </td>
   <td style="text-align:right;"> 1908 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lautensack, Heinrich </td>
   <td style="text-align:left;"> Die Pfarrhauskomödie </td>
   <td style="text-align:right;"> 1912 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lenz, Jakob Michael Reinhold </td>
   <td style="text-align:left;"> Die Freunde machen den Philosophen </td>
   <td style="text-align:right;"> 1775 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lenz, Jakob Michael Reinhold </td>
   <td style="text-align:left;"> Der Hofmeister oder Vorteile der Privaterziehung </td>
   <td style="text-align:right;"> 1774 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lenz, Jakob Michael Reinhold </td>
   <td style="text-align:left;"> Der neue Menoza </td>
   <td style="text-align:right;"> 1774 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Prutz, Robert Eduard </td>
   <td style="text-align:left;"> Die politische Wochenstube </td>
   <td style="text-align:right;"> 1845 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Rosenow, Emil </td>
   <td style="text-align:left;"> Kater Lampe </td>
   <td style="text-align:right;"> 1906 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Scheerbart, Paul </td>
   <td style="text-align:left;"> Das Gift </td>
   <td style="text-align:right;"> 1904 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Scheerbart, Paul </td>
   <td style="text-align:left;"> Der Herr vom Jenseits </td>
   <td style="text-align:right;"> 1904 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schnitzler, Arthur </td>
   <td style="text-align:left;"> Komtesse Mizzi oder Der Familientag </td>
   <td style="text-align:right;"> 1909 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schnitzler, Arthur </td>
   <td style="text-align:left;"> III. Zum grossen Wurstel </td>
   <td style="text-align:right;"> 1906 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Thoma, Ludwig </td>
   <td style="text-align:left;"> Die Lokalbahn </td>
   <td style="text-align:right;"> 1902 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Thoma, Ludwig </td>
   <td style="text-align:left;"> Die Medaille </td>
   <td style="text-align:right;"> 1901 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schnitzler, Arthur </td>
   <td style="text-align:left;"> Professor Bernhardi </td>
   <td style="text-align:right;"> 1914 </td>
   <td style="text-align:left;"> Komödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Goethe, Johann Wolfgang </td>
   <td style="text-align:left;"> Clavigo </td>
   <td style="text-align:right;"> 1774 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Goethe, Johann Wolfgang </td>
   <td style="text-align:left;"> Die natürliche Tochter </td>
   <td style="text-align:right;"> 1804 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Goethe, Johann Wolfgang </td>
   <td style="text-align:left;"> Egmont </td>
   <td style="text-align:right;"> 1788 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Beer, Michael </td>
   <td style="text-align:left;"> Der Paria </td>
   <td style="text-align:right;"> 1826 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Brawe, Joachim Wilhelm von </td>
   <td style="text-align:left;"> Der Freigeist </td>
   <td style="text-align:right;"> 1758 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Eichendorff, Joseph von </td>
   <td style="text-align:left;"> Der letzte Held von Marienburg </td>
   <td style="text-align:right;"> 1830 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Engel, Johann Jakob </td>
   <td style="text-align:left;"> Eid und Pflicht </td>
   <td style="text-align:right;"> 1803 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gottsched, Johann Christoph </td>
   <td style="text-align:left;"> Der sterbende Cato </td>
   <td style="text-align:right;"> 1732 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Grillparzer, Franz </td>
   <td style="text-align:left;"> Des Meeres und der Liebe Wellen </td>
   <td style="text-align:right;"> 1840 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Grillparzer, Franz </td>
   <td style="text-align:left;"> Die Jüdin von Toledo </td>
   <td style="text-align:right;"> 1872 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Grillparzer, Franz </td>
   <td style="text-align:left;"> Ein Bruderzwist in Habsburg </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Grillparzer, Franz </td>
   <td style="text-align:left;"> Die Ahnfrau </td>
   <td style="text-align:right;"> 1817 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Grillparzer, Franz </td>
   <td style="text-align:left;"> König Ottokars Glück und Ende </td>
   <td style="text-align:right;"> 1825 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Grillparzer, Franz </td>
   <td style="text-align:left;"> Ein treuer Diener seines Herrn </td>
   <td style="text-align:right;"> 1830 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hebbel, Friedrich </td>
   <td style="text-align:left;"> Kriemhilds Rache </td>
   <td style="text-align:right;"> 1862 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Heyse, Paul </td>
   <td style="text-align:left;"> Don Juan's Ende </td>
   <td style="text-align:right;"> 1883 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hofmannsthal, Hugo von </td>
   <td style="text-align:left;"> Der Turm </td>
   <td style="text-align:right;"> 1924 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hofmannsthal, Hugo von </td>
   <td style="text-align:left;"> Alkestis </td>
   <td style="text-align:right;"> 1909 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Immermann, Karl </td>
   <td style="text-align:left;"> Andreas Hofer, der Sandwirt von Passeyer </td>
   <td style="text-align:right;"> 1865 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kleist, Heinrich von </td>
   <td style="text-align:left;"> Die Familie Schroffenstein </td>
   <td style="text-align:right;"> 1803 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Klingemann, August </td>
   <td style="text-align:left;"> Faust. Ein Trauerspiel in fünf Acten </td>
   <td style="text-align:right;"> 1815 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Klinger, Friedrich Maximilian </td>
   <td style="text-align:left;"> Die Zwillinge </td>
   <td style="text-align:right;"> 1776 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Klopstock, Friedrich Gottlieb </td>
   <td style="text-align:left;"> Der Tod Adams </td>
   <td style="text-align:right;"> 1757 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Leisewitz, Johann Anton </td>
   <td style="text-align:left;"> Julius von Tarent </td>
   <td style="text-align:right;"> 1776 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Miß Sara Sampson </td>
   <td style="text-align:right;"> 1755 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lessing, Gotthold Ephraim </td>
   <td style="text-align:left;"> Emilia Galotti </td>
   <td style="text-align:right;"> 1772 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ludwig, Otto </td>
   <td style="text-align:left;"> Die Makkabäer </td>
   <td style="text-align:right;"> 1854 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Ludwig, Otto </td>
   <td style="text-align:left;"> Der Erbförster </td>
   <td style="text-align:right;"> 1853 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Müllner, Adolph </td>
   <td style="text-align:left;"> König Yngurd </td>
   <td style="text-align:right;"> 1817 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Müllner, Adolph </td>
   <td style="text-align:left;"> Die Schuld </td>
   <td style="text-align:right;"> 1816 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schiller, Friedrich </td>
   <td style="text-align:left;"> Die Verschwörung des Fiesco zu Genua </td>
   <td style="text-align:right;"> 1783 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schlegel, Friedrich </td>
   <td style="text-align:left;"> Alarkos </td>
   <td style="text-align:right;"> 1802 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schlegel, Johann Elias </td>
   <td style="text-align:left;"> Canut </td>
   <td style="text-align:right;"> 1746 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sturz, Helfrich Peter </td>
   <td style="text-align:left;"> Julie </td>
   <td style="text-align:right;"> 1767 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Uhland, Ludwig </td>
   <td style="text-align:left;"> Ernst Herzog von Schwaben </td>
   <td style="text-align:right;"> 1818 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Voß, Julius von </td>
   <td style="text-align:left;"> Faust. Trauerspiel mit Gesang und Tanz </td>
   <td style="text-align:right;"> 1823 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wagner, Heinrich Leopold </td>
   <td style="text-align:left;"> Die Kindermörderin </td>
   <td style="text-align:right;"> 1776 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Weiße, Christian Felix </td>
   <td style="text-align:left;"> Atreus und Thyest </td>
   <td style="text-align:right;"> 1766 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wieland, Christoph Martin </td>
   <td style="text-align:left;"> Lady Johanna Gray </td>
   <td style="text-align:right;"> 1758 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wilbrandt, Adolf von </td>
   <td style="text-align:left;"> Gracchus der Volkstribun </td>
   <td style="text-align:right;"> 1872 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wildenbruch, Ernst von </td>
   <td style="text-align:left;"> Die Karolinger </td>
   <td style="text-align:right;"> 1881 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wildgans, Anton </td>
   <td style="text-align:left;"> Armut </td>
   <td style="text-align:right;"> 1919 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Goethe, Johann Wolfgang </td>
   <td style="text-align:left;"> Faust. Der Tragödie zweiter Teil </td>
   <td style="text-align:right;"> 1832 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Bleibtreu, Karl </td>
   <td style="text-align:left;"> Ein Faust der That </td>
   <td style="text-align:right;"> 1889 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Braun von Braunthal, Karl Johann </td>
   <td style="text-align:left;"> Faust </td>
   <td style="text-align:right;"> 1835 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gerhäuser, Emil </td>
   <td style="text-align:left;"> Der Moloch </td>
   <td style="text-align:right;"> 0 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Grabbe, Christian Dietrich </td>
   <td style="text-align:left;"> Don Juan und Faust </td>
   <td style="text-align:right;"> 1829 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Grabbe, Christian Dietrich </td>
   <td style="text-align:left;"> Herzog Theodor von Gothland </td>
   <td style="text-align:right;"> 1827 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hauptmann, Carl </td>
   <td style="text-align:left;"> Frau Nadja Bielew </td>
   <td style="text-align:right;"> 1909 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hebbel, Friedrich </td>
   <td style="text-align:left;"> Herodes und Mariamne </td>
   <td style="text-align:right;"> 1850 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hebbel, Friedrich </td>
   <td style="text-align:left;"> Gyges und sein Ring </td>
   <td style="text-align:right;"> 1856 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hebbel, Friedrich </td>
   <td style="text-align:left;"> Genoveva </td>
   <td style="text-align:right;"> 1843 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hebbel, Friedrich </td>
   <td style="text-align:left;"> Judith </td>
   <td style="text-align:right;"> 1841 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Heine, Heinrich </td>
   <td style="text-align:left;"> Almansor </td>
   <td style="text-align:right;"> 1821 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Heiseler, Henry von </td>
   <td style="text-align:left;"> Die Kinder Godunófs </td>
   <td style="text-align:right;"> 1929 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hofmannsthal, Hugo von </td>
   <td style="text-align:left;"> Elektra </td>
   <td style="text-align:right;"> 1904 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Holz, Arno </td>
   <td style="text-align:left;"> Ignorabimus </td>
   <td style="text-align:right;"> 1914 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Immermann, Karl </td>
   <td style="text-align:left;"> Das Gericht von St. Petersburg </td>
   <td style="text-align:right;"> 1832 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Kaltneker, Hans </td>
   <td style="text-align:left;"> Die Opferung </td>
   <td style="text-align:right;"> 1925 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schäfer, Wilhelm </td>
   <td style="text-align:left;"> Faustine, der weibliche Faust </td>
   <td style="text-align:right;"> 1898 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Scheerbart, Paul </td>
   <td style="text-align:left;"> Es lebe Europa! </td>
   <td style="text-align:right;"> 1904 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Scheerbart, Paul </td>
   <td style="text-align:left;"> Der Schornsteinfeger </td>
   <td style="text-align:right;"> 1904 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Scheerbart, Paul </td>
   <td style="text-align:left;"> Herr Kammerdiener Kneetschke </td>
   <td style="text-align:right;"> 1904 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schiller, Friedrich </td>
   <td style="text-align:left;"> Die Jungfrau von Orleans </td>
   <td style="text-align:right;"> 1801 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Sudermann, Hermann </td>
   <td style="text-align:left;"> Der Bettler von Syrakus </td>
   <td style="text-align:right;"> 1911 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Vischer, Friedrich Theodor </td>
   <td style="text-align:left;"> Faust III </td>
   <td style="text-align:right;"> 1862 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wedekind, Frank </td>
   <td style="text-align:left;"> Frühlings Erwachen </td>
   <td style="text-align:right;"> 1891 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wedekind, Frank </td>
   <td style="text-align:left;"> Die Büchse der Pandora </td>
   <td style="text-align:right;"> 1902 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wedekind, Frank </td>
   <td style="text-align:left;"> Erdgeist </td>
   <td style="text-align:right;"> 1895 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Werner, Zacharias </td>
   <td style="text-align:left;"> Der vierundzwanzigste Februar </td>
   <td style="text-align:right;"> 1815 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Wildgans, Anton </td>
   <td style="text-align:left;"> Dies irae </td>
   <td style="text-align:right;"> 1918 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Gerstenberg, Heinrich Wilhelm von </td>
   <td style="text-align:left;"> Ugolino </td>
   <td style="text-align:right;"> 1768 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schiller, Friedrich </td>
   <td style="text-align:left;"> Kabale und Liebe </td>
   <td style="text-align:right;"> 1784 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Schiller, Friedrich </td>
   <td style="text-align:left;"> Maria Stuart </td>
   <td style="text-align:right;"> 1801 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Hartleben, Otto Erich </td>
   <td style="text-align:left;"> Rosenmontag </td>
   <td style="text-align:right;"> 1898 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Lassalle, Ferdinand </td>
   <td style="text-align:left;"> Franz von Sickingen </td>
   <td style="text-align:right;"> 1859 </td>
   <td style="text-align:left;"> Tragödie </td>
  </tr>
</tbody>
</table>

## Verwendete Wörter 




<table>
<caption>Benutzte Wörter aus dem Wortfeld 'Gesundheit'</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Komödie </th>
   <th style="text-align:left;"> Tragödie </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;width: 20em; "> frisch, gesund, gesundheit, munter, zustand, heil, kräftig, blühen, derb, verhüten, vorbeugen, wohlsein, gedeihen, fidel, unversehrt, wohlauf, rüstig, verfassung, strotzen, unverwüstlich, wohlergehen, stählen, unbeschädigt, zäh, abgehärtet, abhärten, habitus, robust, stabil, wohlbefinden, wohlbehalten </td>
   <td style="text-align:left;width: 20em; "> heil, frisch, gesund, blühen, kräftig, zustand, gesundheit, munter, verhüten, gedeihen, derb, stählen, rüstig, verfassung, wohlgemut, wohlsein, zäh, unversehrt, vorbeugen, fidel, konstitution, strotzen, wohlergehen, befund, wohlbehalten, habitus, wohlauf, abhärten, gesundheitszustand, kerngesund, unbeschädigt, untersuchungsergebnis, unverwüstlich, wohlbefinden </td>
  </tr>
</tbody>
</table>


<table>
<caption>Benutzte Wörter aus dem Wortfeld 'Krankheit'</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Komödie </th>
   <th style="text-align:left;"> Tragödie </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;width: 20em; "> liegen, mal, übel, ernst, fall, leiden, schmerz, krank, gefährlich, krankheit, elend, schwach, schwäche, ohnmacht, bedenklich, schädlich, buckel, pest, anfall, floh, patient, kopfweh, schwindel, zucker, gebrechen, erbrechen, fieber, schwindsucht, anstecken, husten, lahm, krüppel, matt, melancholie, reizung, giftig, schwermut, leidend, schielen, begleiterscheinung, krampf, kränklich, sepsis, siech, tödlich, unheilbar, ausschlag, erblich, hinken, lahmen, schwächlich, verderblich, verstopfung, aufstoßen, bruch, gebrechlich, notfall, schlucken, schmarotzer, blindheit, kraftlos, kranker, krebs, krisis, migräne, schleichend, störung, ungesund, ansteckend, erkranken, gicht, hypochonder, kränkeln, laus, rheumatismus, schnupfen, star, tumor, würmer, ast, bettlägerig, bösartig, cholera, hinfällig, höcker, kahlkopf, klumpfuß, kotzen, krächzen, muttermal, platte, tränen, übelkeit, affektion, angegriffen, bandwurm, delirium, erkältung, erkrankung, gelbsucht, geschwulst, geschwür, glatze, heruntergekommen, hornhaut, hüsteln, laborieren, magendrücken, malade, nervosität, neuralgie, rekonvaleszent, rückfall, scharlach, schwiele, silberblick, sonnenbrand, symptom, syphilis, taubheit, unrettbar, unwohl, verseuchen, warze, wasserkopf </td>
   <td style="text-align:left;width: 20em; "> liegen, mal, schmerz, ernst, leiden, elend, fall, schwach, krank, übel, gefährlich, fieber, krankheit, ohnmacht, schwäche, pest, matt, tödlich, bedenklich, giftig, floh, schwindel, verderblich, gebrechen, anfall, leidend, erbrechen, melancholie, anstecken, störung, hinken, karzinom, krebs, schleichend, buckel, kraftlos, krampf, lahm, schielen, ast, blindheit, krächzen, krüppel, schlucken, bruch, erkranken, schädlich, erblich, scharlach, unheilbar, bösartig, gebrechlich, geschwür, glatze, schwermut, ansteckend, ausschlag, blinder, cholera, notfall, patient, rückfall, schwächlich, seuche, symptom, zucker, aussatz, fiebern, kopfweh, kranker, lahmen, siechtum, ungesund, gicht, heruntergekommen, hinfällig, husten, laus, nervosität, platte, schmarotzer, unwohl, asthma, eiter, erkrankung, gelbsucht, knochenbruch, kränklich, reizung, rekonvaleszent, schlapp, star, taubheit, verseuchen, warze, würmer, delirium, durchfall, epidemie, fistel, frostbeule, hinfälligkeit, hühnerauge, influenza, kahlkopf, karies, klumpfuß, kotzen, kränkeln, krisis, laborieren, leistenbruch, magenverstimmung, rheumatismus, schüttelfrost, schwachsinn, schwachsinnig, schwindsucht, silberblick, sonnenbrand, syphilis, tränen, typhus, verbrennung, verstopft </td>
  </tr>
</tbody>
</table>


<table>
<caption>Benutzte Wörter aus dem Wortfeld 'Behandlung'</caption>
 <thead>
  <tr>
   <th style="text-align:left;"> Komödie </th>
   <th style="text-align:left;"> Tragödie </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;width: 20em; "> schwester, helfen, doktor, gesund, pflegen, arzt, bessern, behandeln, beruhigen, bedienen, untersuchung, heilen, kurieren, eingeben, harmlos, rezept, verschreiben, kur, medizin, anschlagen, behandlung, vorbeugen, ärztlich, erleichtern, stützen, krankenhaus, wohltätig, betäuben, eingriff, mediziner, pflaster, beschwichtigen, diät, genesung, heilsam, operation, operieren, praktizieren, spital, klinik, pflege, diagnose, förderlich, mildern, verjüngen, verordnen, attest, binde, chirurg, einschläfern, hospital, unschädlich, aufleben, badeort, bestrahlen, dermatologie, genesen, hygiene, quacksalber, sanatorium, schröpfen, seeluft, zuträglich, augenarzt, badekur, betäubung, chirurgie, dermatologe, einlauf, geburtshilfe, hebamme, internist, krankenschwester, kurort, lazarett, meditation, pfleger, physiologe, quarantäne, röntgen, schmerzstillend, therapie, watte, wickel, wiederherstellen </td>
   <td style="text-align:left;width: 20em; "> schwester, helfen, doktor, arzt, pflegen, heilen, gesund, beruhigen, bessern, stützen, behandeln, betäuben, untersuchung, bedienen, betäubung, verjüngen, heilsam, erleichtern, eingeben, mildern, binde, genesung, pflege, kur, wohltätig, genesen, harmlos, pflaster, verschreiben, krankenhaus, medizin, verordnen, ärztlich, eingriff, kräftigen, vorbeugen, anschlagen, behandlung, pfleger, unschädlich, beschwichtigen, spital, assistenzarzt, attest, aufleben, befund, diagnose, förderlich, rezept, wickel, wiederherstellen, zuträglich, diät, einschläfern, injektion, lazarett, sanatorium, schröpfen, seebad, aufbauend, bestrahlen, betreuen, erstarken, geburtshelfer, gynäkologe, hausarzt, hebamme, heilkunst, impfen, internist, krankenschwester, küren, kurieren, massage, mediziner, obduktion, operation, physiologe, psychiater, quacksalber, seeluft, tierarzt, untersuchungsergebnis, watte </td>
  </tr>
</tbody>
</table>
