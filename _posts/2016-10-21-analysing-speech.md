---
layout: post
title: Analysing Dramatic Figure Speech with R
lang: en
ref: guide
categories: Technology
authors: Nils Reiter
---

This guide describes how to analyse dramatic figure speech with R, using our linguistic preprocessing tools. It is written as a step-by-step guide and uses the (German) dramatic texts [*Romeo und Julia*](https://textgridrep.org/browse/-/browse/vndf_0) and [*Emilia Galotti*](https://textgridrep.org/browse/-/browse/rksp_0) as examples.

<!--more-->
## Inhaltsverzeichnis
{:.no_toc}

* ToC
{:toc}

## Before you start

<ul class="itab">
<li class="os_unix"><a href="#">Linux</a></li>
<li class="os_unix"><a href="#">Unix</a></li>
<li class="os_unix"><a href="#">Mac OS X</a></li>
<li class="os_win"><a href="#">Windows</a></li>
</ul>
<script>
$(".itab > li > a").click(function(ev) {
  ev.preventDefault();
  var p = $(this).parent();
  $("div.os_unix").hide();
  $("div.os_win").hide();
  p.siblings().removeClass("active");
  p.addClass("active");
  if (p.hasClass("os_unix")) {
    $("div.os_unix").show();
  }
  if (p.hasClass("os_win")) {
    $("div.os_win").show();
  }
});
$(document).ready(function () {
  $(".itab > li:first-child > a").click();
});
</script>

This guide offers information tailored to different operating systems. Please select the appropriate one for you in the bar above.

Some basics: Both texts will be identified by their textgrid id throughout this guide and when they are loaded in the R environment. The id of  *Romeo und Julia* is`vndf.0`, the id of *Emilia Galotti* is `rksp.0`.

This guide assumes that you have installed several things on your computer:
- Java
- RStudio

Please check that both are present and reasonably new.

You will also need a directory to store both downloaded code and data. Please create one now. You can name it as you like, we will use `QD_DIR` to refer to this directory. You will need to create several subdirectories later.

And, finally, some steps involve using a command line interface. You can launch the command line interface by searching for a program called `Terminal`. On Mac OS X, this is installed in `/Applications/Utilities/Terminal.app`. On Windows 10, it can be launched via the start menu: All Apps > Windows System > Command prompt.

## Downloads

<div class="table">
<table>
<thead>
<tr><th>URL</th><th>Target</th><th>Content</th></tr>
</thead>
<tbody>
<tr>
<td><a href="https://textgridlab.org/1.0/tgcrud-public/rest/textgrid:vndf.0/data">textgrid:vndf.0/data</a></td>
<td>
  <div class="os_unix"><code>tei/vndf.0.xml</code></div>
  <div class="os_win"><code>tei\vndf.0.xml</code></div>
</td>
<td>The TEI file containing <i>Romeo und Julia</i></td>
</tr>
<tr>
<td><a href="https://textgridlab.org/1.0/tgcrud-public/rest/textgrid:rksp.0/data">textgrid:rksp.0/data</a></td>
<td>
  <div class="os_unix"><code>tei/rksp.0.xml</code></div>
  <div class="os_win"><code>tei\rksp.0.xml</code></div>
</td>
<td>The TEI file containing <i>Emilia Galotti</i></td>
</tr>
<tr>
<td><a href="https://github.com/quadrama/Main/releases/download/v1.0.2/drama.Main-1.0.2.jar">drama.Main-1.0.2.jar</a></td>
<td>
  <div class="os_unix"><code>code/drama.Main.jar</code></div>
  <div class="os_win"><code>code\drama.Main.jar</code></div>
</td>
<td>Java code for doing NLP on dramatic texts</td>
</tr>
</tbody>
</table>
<p class="caption">Downloads and where to put them. All targets are relative to <code>QD_DIR</code>, i.e., subdirectories. </p>
</div>

There are several things you need to download. <span class="ref-table"/> shows the URLs. Please download the respective files into the given directories, and rename the files if necessary. Next, you need to create a directory called `xmi` as a subdirectory of `QD_DIR`.

## Preprocessing
The first step will parse the TEI files, apply several NLP components to them and write the results as XMI files. XMI is an XML-based file format used to store textual data with stand-off annotations. It is used in the [Apache UIMA](http://uima.apache.org) project. While you can inspect the files, they are not made to be read by humans.

Enter the terminal, and navigate to your directory `QD_DIR`. Then enter the following command on a single line:

```
java -cp code/drama.Main.jar de.unistuttgart.ims.drama.Main.TEI2XMI --input tei --output xmi
```
{:.os_unix}

```
java -cp code\drama.Main.jar de.unistuttgart.ims.drama.Main.TEI2XMI --input tei --output xmi
```
{:.os_win}

This should not take longer than 2 minutes, and you will see a lot of output during processing. If everything goes well, you will find the files `rksp.0.xmi` and `vndf.0.xmi` in the directory `xmi` (as well as a file called `typesystem.xml`).

You have now converted the TEI files into XMI, and also added a lot of linguistic and non-linguistic annotation. The next step will be exporting some of the information in the XMI files into *comma-separated values*-format that can be read easily with R.

## Export in CSV
Again, go into the directory `QD_DIR` (if you have left in the meantime).
Then, execute the following command (again, enter it on a single line and press Enter on the keyboard):

```
java -cp code/drama.Main.jar de.unistuttgart.ims.drama.Main.XMI2UtteranceCSV --input xmi --output utterances.csv
```
{:.os_unix}

```
java -cp code\drama.Main.jar de.unistuttgart.ims.drama.Main.XMI2UtteranceCSV --input xmi --output utterances.csv
```
{:.os_win}

You should see much less output than before. More importantly, there should be a file called `utterances.csv` in your `QD_DIR` directory. The file represents a table containing every (spoken) token in both dramatic texts along with annotations and additional information.


<div class="table">
<table>
<thead>
<tr>
<th>drama</th>
<th>length</th>
<th>begin</th><th>end</th><th>Speaker/figure_surface</th><th>Speaker/figure_id</th><th>Token/surface</th><th>Token/pos</th><th>Token/lemma</th>
</tr>
</thead>
<tbody>
<tr>
<td>vndf.0</td><td>29145</td><td>1083</td><td>1157</td><td>Simson</td><td>12</td><td>Auf</td><td>APPR</td><td>auf</td>
</tr>
<tr>
<td>vndf.0</td><td>29145</td><td>1083</td><td>1157</td><td>Simson</td><td>12</td><td>mein</td><td>PPOSAT</td><td>mein</td>
</tr>
</tbody>
</table>
<p class="caption">Header and the first two rows of <code>utterances.csv</code></p>
</div>

### Utterances.csv

The following list gives a definition of each column of the file `utterances.csv`.
You can skip this part if you are not interested in these details.

drama
: The drama id used in the textgrid Repository

length
: The length of the dramatic text, measured in spoken tokens. We are not counting stage directions.

begin
: The first *character* of the utterance this token (the one represented by this row) is in.

end
: The last *character* of the utterance

Speaker/figure_surface
: The name of the figure that utters this utterance. Ideally, we give the name that is introduced in the dramatic personae table at the beginning. If the name is in all upper case letters, it was not automatically mapped onto an entry in the dramatis personae table.

Speaker/figure_id
: A numeric identifier for the figure uttering this utterance

Token/surface
: The surface form of the token

Token/pos
: The automatically assigned part-of-speech tag for this token, using the [STTS-Tagset](http://www.ims.uni-stuttgart.de/forschung/ressourcen/lexika/TagSets/stts-table.html)

Token/lemma
: The automatically assigned lemma for this token.


## Figure Speech Analysis with R
Launch R or RStudio and set the working directory to `QD_DIR`.

Run the following commands in the R console:
```R
# This allows us to install directly from github
> install.packages("devtools")
# Load the package devtools
> library(devtools)

# Install the QuaDramA R package in version 0.2.3.
# This guide has been written for 0.2.3, but if
# newer versions are available, you can try them by
# replacing the version number.
> install_github("quadrama/DramaAnalysis", ref="v0.2.3")
# Load the package DramaAnalysis
> library(DramaAnalysis)

# Now we are ready to load the dramatic texts.
# Note: this only works if you're in the right
# directory and have run the previous steps
# (successfully).
> t <- read.csv("utterances.csv")
```

### Overall Distribution
This part generates a (static) plot such as Figure 2 in [this post]({{site.url}}/blog/2016/10/07/ottokar-capulet) (the stacked columns).

```R
# We remove all figures except the 10 most
# frequently speaking
t <- limit.figures.by.rank(t)

# We calculate statistics for each figure,
# using names as identifiers
fstat <- figure.statistics(t, names=TRUE)

# we create a matrix containing the raw
# token numbers by figure rank
mat <- matrix(data=c(fstat[,3]),ncol=2)
colnames(mat) <- c(
      "Romeo und Julia (Ü: Schlegel)",
      "Emilia Galotti")
mat <- apply(mat, 2,
    function(x) {sort(x, decreasing=TRUE)})

# generate the plot
barplot(mat, beside=FALSE, col=qd.colors, border=NA, ylab = "Tokens")

# add labels to some figures
text(x=c(0.7,0.7,1.9),
    y=c(mat[1,1]/2, sum(mat[1,1]+mat[2,1]/2),
        sum(mat[1:4,2])+mat[5,2]/2),
    labels=c("Romeo", "Julia", "Emilia"),
    col=c("white"))
```

<div class="figure">
<img src="{{site.url}}/assets/2016-10-21-analysing-speech/plot1.png" />
<p class="caption">Figure Speech Distribution Plot</p>
</div>


### Variation
In this part, we generate a box plot to show the variation of utterance length.
We will restrict this analysis to the top-10 figures within one drama, `vndf.0`.


```R
# make a subset of tokens to only contain vndf.0
> t_vndf.0 <- t[t$drama=="vndf.0",]

# only the top 10 figures
> t_vndf.0 <- limit.figures.by.rank(t_vndf.0, maxRank = 10)

# Calculate utterance statistics for all figures
> ustat <- utterance_statistics(t_vndf.0, num.figures = F)

# Make a Boxplot
> boxplot(ustat$utterance_length ~ ustat$figure,
          col=qd.colors, las=2, frame=F,
          main=paste("Figure Speech Variation"))
```

<div class="figure">
<img src="{{site.url}}/assets/2016-10-21-analysing-speech/plot2.png" />
<p class="caption">Box plot generated with R</p>
</div>
