---
layout: post
title: Analysing Dramatic Figure Speech with R, Part 2
lang: en
ref: analysing-speech-2
logo: /assets/2017-04-28-analysing-speech-2/logo.png
categories: Technology
authors: Nils Reiter
---

So far, we loaded dramatic texts into R with the help of a web service that converted from UIMA XMI files into CoNLL-like CSV files. Now that we have released version [0.4.1](https://github.com/quadrama/DramaAnalysis/releases/tag/v0.4.1) of our [DramaAnalysis R package](https://github.com/quadrama/DramaAnalysis), this is no longer necessary. Instead, we have integrated the needed Java code directly into the R package. This makes, we hope, using the R package much easier.

We also started collecting guides and tutorials for various things in the package. So far, we're covering [extraction of figure statistics](https://github.com/quadrama/DramaAnalysis/wiki/Figure-Statistics), [Creation and use of configuration matrices](https://github.com/quadrama/DramaAnalysis/wiki/Configuration-Matrices) and [doing word field analyses](https://github.com/quadrama/DramaAnalysis/wiki/Word-Field-Analysis). 

All guides will be posted to [the DramaAnalysis Wiki](https://github.com/quadrama/DramaAnalysis/wiki).