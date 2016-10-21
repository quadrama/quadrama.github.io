---
layout: post
title: Analysing Dramatic Texts with R
lang: en
ref: guide
categories: Technology
authors: Nils Reiter
---

This post describes how to analyse dramatic figure speech with R, using our linguistic preprocessing tools. It is written as a step-by-step guide and uses the (German) dramatic texts [*Romeo und Julia*](https://textgridrep.org/browse/-/browse/vndf_0) and [*Emilia Galotti*](https://textgridrep.org/browse/-/browse/rksp_0) as examples.

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

## Downloads

<div class="table">
<table>
<thead>
<tr><th>URL</th><th>Target</th><th>Content</th></tr>
</thead>
<tbody>
<tr>
<td><a href="https://textgridlab.org/1.0/tgcrud-public/rest/textgrid:vndf.0/data">textgrid:vndf.0/data</a></td>
<td><code>tei/vndf.0.xml</code></td>
<td>The TEI file containing <i>Romeo und Julia</i></td>
</tr>
<tr>
<td><a href="https://textgridlab.org/1.0/tgcrud-public/rest/textgrid:rksp.0/data">textgrid:rksp.0/data</a></td>
<td><code>tei/rksp.0.xml</code></td>
<td>The TEI file containing <i>Emilia Galotti</i></td>
</tr>
<tr>
<td><a href="https://github.com/quadrama/Main/releases/download/v1.0.2/drama.Main-1.0.2.jar">drama.Main-1.0.2.jar</a></td>
<td><code>code/drama.Main.jar</code></td>
<td>Java code for doing NLP on dramatic texts</td>
</tr>
<tr>
<td><a href="https://github.com/quadrama/DramaAnalysis/releases/download/v0.2.3/DramaAnalysis_0.2.3.tar.gz">DramaAnalysis_0.2.3.tar.gz</a></td>
<td><code>code/DramaAnalysis_0.2.3.tar.gz</code></td>
<td>R functions that support drama analysis</td>
</tr>
</tbody>
</table>
<p class="caption">Downloads and where to put them. All targets are relative to <code>QD_DIR</code>, i.e., subdirectories. </p>
</div>

There are several things you need to download. <span class="ref-table"/> shows the URLs. Please download the respective files into the given directories, and rename the files if necessary. Next, you need to create a directory called `xmi` as a subdirectory of `QD_DIR`.

## Preprocessing
The first step will parse the TEI files, apply several NLP components to them and write the results as XMI files. XMI is an XML-based file format used to store textual data with stand-off annotations. It is used in the [Apache UIMA](http://uima.apache.org) project. While you can inspect the files, they are not made to be read by humans.

Open a terminal, and enter on a single line:

```
java -cp code/drama.Main.jar de.unistuttgart.ims.drama.Main.TEI2XMI --input QD_DIR/tei --output QD_DIR/xmi
```
{:.os_unix}

```
java -cp code\drama.Main.jar de.unistuttgart.ims.drama.Main.TEI2XMI --input QD_DIR\tei --output QD_DIR\xmi
```
{:.os_win}

If everything goes well, you will find the files `rksp.0.xmi` and `vndf.0.xmi` in the directory `xmi`.
