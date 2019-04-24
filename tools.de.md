---
layout: page
title: Tools
lang: de
ref: tools
editor: pagel
---

Hier findet sich eine Übersicht der Tools, die im Rahmen von QuaDramA entwickelt werden.

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

<p>CorefAnnotator ist ein Tool zum annotieren von Koreferenz-Ketten. Es wurde entwickelt um lange Texte mit vielen unterschiedlichen Ketten zu verarbeiten. Die Grundidee ist, dass nicht binäre Relationen zwischen Mentions (z.B. Kataphorizität) annotiert werden, sondern dass alle Mentions als einer Equivalenzklasse zugehörig aufgefasst werden. Dem folgend präsentiert das Tool eine Liste aller Entitäten auf der rechten Seite und ermöglicht so eine freie Zuordnung von Textabschnitten zu diesen Entitäten.</p>

<p><a href="https://github.com/nilsreiter/CorefAnnotator">https://github.com/nilsreiter/CorefAnnotator</a></p>

<b>Referenz</b>

<div>Nils Reiter. <a href="{{site.baseurl}}/publications/Reiter2018ag"><b>CorefAnnotator - A New Annotation Tool for Entity References</b></a>. In <hi>Abstracts of EADH: Data in the Digital Humanities</hi>, December 2018.</div>

## DramaAnalysis

<div class="badges">
<a href="https://doi.org/10.5281/zenodo.1252783"><img src="https://img.shields.io/badge/doi-10.5281/zenodo.1252783-blue.svg?longCache=true&style=flat-square" alt="DOI"/></a>
<a href="https://github.com/quadrama/DramaAnalysis/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-Apache%202-blue.svg?longCache=true&style=flat-square" alt="License"/></a>
<a href="https://github.com/quadrama/DramaAnalysis/releases/latest"><img src="https://img.shields.io/github/release-pre/quadrama/DramaAnalysis.svg?style=flat-square" alt="Latest release"/></a>
<img src="https://img.shields.io/badge/language-r-blue.svg?longCache=true&style=flat-square" alt="Language"/>
<img src="https://img.shields.io/badge/platform-library-blue.svg?longCache=true&style=flat-square" alt="Platform"/>
</div>

<p>DramaAnalysis ist ein R-Paket, das eine Sammlung von häufig genutzten Funktionen für die Analyse von dramatischen Texten enthält. Der Input ist ein CSV-Format, das von <a href="https://github.com/quadrama/DramaNLP">DramaNLP</a> vorgegeben wird. DramaAnalysis-Funktionen können leicht kombiniert und ihr Output mit einer von Rs Plotting-Möglichkeiten graphisch dargestellt werden. </p>

<p><a href="https://github.com/quadrama/DramaAnalysis">https://github.com/quadrama/DramaAnalysis</a></p>

## DramaNLP

<div class="badges">
<a href="https://doi.org/10.5281/zenodo.2635476"><img src="https://img.shields.io/badge/doi-10.5281/zenodo.2635476-blue.svg?longCache=true&style=flat-square" alt="DOI"/></a>
<a href="https://github.com/quadrama/DramaNLP/blob/master/LICENSE"><img src="https://img.shields.io/badge/license-Apache%202-blue.svg?longCache=true&style=flat-square" alt="License"/></a>
<a href="https://github.com/quadrama/DramaNLP/releases/latest"><img src="https://img.shields.io/github/release-pre/quadrama/DramaNLP.svg?style=flat-square" alt="Latest release"/></a>
<img src="https://img.shields.io/badge/language-java-blue.svg?longCache=true&style=flat-square" alt="Language"/>
<img src="https://img.shields.io/badge/platform-library-blue.svg?longCache=true&style=flat-square" alt="Platform"/>
</div>

<p>DramaNLP ist eine NLP-Pipeline, basierend auf <a href="https://uima.apache.org/">Apache UIMA</a> Komponenten und kann dramatische Texte verarbeiten. DramaNLP ist in der Lage, verschiedene <a href="https://tei-c.org/">TEI</a> Dialekte zu importieren und mittels <a href="https://dkpro.github.io/">DKPro</a> Komponenten zu verarbeiten. Der Output ist eine Vielzahl von Formaten wie etwa <a href="https://www.omg.org/spec/XMI/">XMI</a>, <a href="http://www.signll.org/conll/">CoNLL</a> Varianten sowie ein eigenes CSV-Format. Diese Formate enthalten Metainformationen aus den TEI-Dateien, wie etwa Author und Titel, sowie NLP-Output, wie zum Beispiel der tokenisierte Text, Wortarten- und Sprecher-Informationen.</p>

<p><a href="https://github.com/quadrama/DramaNLP">https://github.com/quadrama/DramaNLP</a></p>
