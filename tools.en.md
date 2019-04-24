---
layout: page
title: Tools
lang: en
ref: tools
editor: pagel
---

<style>
.badges img {
	display: inline-block;
}
</style>

This is a list of the tools that are being developed in QuaDramA.

* ToC
{:toc}

## CorefAnnotator

<div class="badges">
<a href="https://doi.org/10.5281/zenodo.1228105"><img src="https://img.shields.io/badge/doi-10.5281/zenodo.1228105-blue.svg?longCache=true&style=flat-square" alt="DOI"/></a>
<a href="https://github.com/nilsreiter/CorefAnnotator/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-Apache%202-blue.svg?longCache=true&style=flat-square" alt="License"/></a>
<a href="https://github.com/nilsreiter/CorefAnnotator/releases/latest"><img src="https://img.shields.io/github/release-pre/nilsreiter/CorefAnnotator.svg?style=flat-square" alt="Latest release"/></a>
<img src="https://img.shields.io/badge/language-java-blue.svg?longCache=true&style=flat-square" alt="Language"/>
<img src="https://img.shields.io/badge/platform-desktop-blue.svg?longCache=true&style=flat-square" alt="Platform"/>
</div>

<p>CorefAnnotator is a tool for annotating coreference in texts. It has been developed to be able to cope with long texts with many different chains. The core idea is not to annotate binary relations between mentions (e.g., cataphoric), but to consider all mentions that co-refer to form an equivalence set. Consequently, the tool displays a list of entities on the right and allows free assignment of text spans to these entities.</p>

<p><a href="https://github.com/nilsreiter/CorefAnnotator">https://github.com/nilsreiter/CorefAnnotator</a></p>

<b>Citation</b>

<div>Nils Reiter. <a href="{{site.baseurl}}/publications/Reiter2018ag"><b>CorefAnnotator - A New Annotation Tool for Entity References</b></a>. In <hi>Abstracts of EADH: Data in the Digital Humanities</hi>, December 2018.</div>

## DramaAnalysis

<div class="badges">
<a href="https://doi.org/10.5281/zenodo.1252783"><img src="https://img.shields.io/badge/doi-10.5281/zenodo.1252783-blue.svg?longCache=true&style=flat-square" alt="DOI"/></a>
<a href="https://github.com/quadrama/DramaAnalysis/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-Apache%202-blue.svg?longCache=true&style=flat-square" alt="License"/></a>
<a href="https://github.com/quadrama/DramaAnalysis/releases/latest"><img src="https://img.shields.io/github/release-pre/quadrama/DramaAnalysis.svg?style=flat-square" alt="Latest release"/></a>
<img src="https://img.shields.io/badge/language-r-blue.svg?longCache=true&style=flat-square" alt="Language"/>
<img src="https://img.shields.io/badge/platform-library-blue.svg?longCache=true&style=flat-square" alt="Platform"/>
</div>

<p>DramaAnalysis is an R package that contains a collection of frequently used functions for analyzing dramatic texts. The input is a CSV-format coming from <a href="https://github.com/quadrama/DramaNLP">DramaNLP</a>. DramaAnalysis functions can be combined easily and their output can be plotted straightforwardly with one of R's plotting devices.
</p>

<p><a href="https://github.com/quadrama/DramaAnalysis">https://github.com/quadrama/DramaAnalysis</a></p>

## DramaNLP

<div class="badges">
<a href="https://doi.org/10.5281/zenodo.2635476"><img src="https://img.shields.io/badge/doi-10.5281/zenodo.2635476-blue.svg?longCache=true&style=flat-square" alt="DOI"/></a>
<a href="https://github.com/quadrama/DramaNLP/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-Apache%202-blue.svg?longCache=true&style=flat-square" alt="License"/></a>
<a href="https://github.com/quadrama/DramaNLP/releases/latest"><img src="https://img.shields.io/github/release-pre/quadrama/DramaNLP.svg?style=flat-square" alt="Latest release"/></a>
<img src="https://img.shields.io/badge/language-java-blue.svg?longCache=true&style=flat-square" alt="Language"/>
<img src="https://img.shields.io/badge/platform-library-blue.svg?longCache=true&style=flat-square" alt="Platform"/>
</div>

<p>DramaNLP is a NLP-pipeline based on <a href="https://uima.apache.org/">Apache UIMA</a> components that processes dramatic texts. DramaNLP can import various <a href="https://tei-c.org/">TEI</a> dialects and process them using <a href="https://dkpro.github.io/">DKPro</a> components. The output is a variety of formats such as <a href="https://www.omg.org/spec/XMI/">XMI</a>, <a href="http://www.signll.org/conll/">CoNLL</a> formats and a custom CSV format. These formats contain extracted metadata from the TEI files, such as author or title and NLP output such as the tokenized text, part-of-speech and speaker information.</p>
<p><a href="https://github.com/quadrama/DramaNLP">https://github.com/quadrama/DramaNLP</a></p>
