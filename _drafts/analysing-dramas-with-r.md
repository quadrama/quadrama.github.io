---
layout: post
title: Analysing Dramatic Texts with R
lang: en
ref: guide
categories: Technology
authors: Nils Reiter
---

This post describes how you can analyse dramatic figure speech with R, using our linguistic preprocessing tools before. It is written as a step-by-step guide and uses the (German) dramatic texts [*Romeo und Julia*](https://textgridrep.org/browse/-/browse/vndf_0) and [*Emilia Galotti*](https://textgridrep.org/browse/-/browse/rksp_0) as examples.

<!--more-->
## Inhaltsverzeichnis
{:.no_toc}

* ToC
{:toc}

## Before you start
Some basics: Both texts will be identified by their textgrid id, throughout this guide. The id of  *Romeo und Julia* is`vndf.0`, the id of *Emilia Galotti* is `rksp.0`.


This guide assumes that you have installed several things on your computer:
- Java
- R

Please check that both are present and reasonably new.

You will also need a directory to store programs and data. Please create one now. You can name it as you like, we will use the variable `QD_DIR` to refer to this directory. You will need to create several sub directories later.

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
<td><a href="https://github.com/quadrama/Main/releases/download/v1.0.0/drama.Main-1.0.0-jar-with-dependencies.jar">drama.Main-1.0.0-jar-with-dependencies.jar</a></td>
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
<p class="caption">Downloads and where to put them. All targets are relative to <code>QD_DIR</code>, i.e., sub directories. </p>
</div>

There are several things you need to download. <span class="ref-table"/> shows the URLs. Please download the resp. data sets into the given directories.

Next, you need to create a directory called `xmi`, also as a sub directory of `QD_DIR`.

## Preprocessing
Open a terminal, and enter

```bash
$ java -cp code/drama.Main.jar  
```
