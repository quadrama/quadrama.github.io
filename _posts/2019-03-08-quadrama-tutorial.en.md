---
title: "QuaDramA Tutorial"
authors:
- Nils Reiter
layout: post
categories:
- Conferences
lang: en
logo: /assets/conference-logos/uniheidelberg.png
ref: 2019-07-15-tutorial
update: 2019-07-15
index: true
---

We are happy to announce that we will give a tutorial on quantitative drama analysis as part of the [2nd Heidelberg Computational Humanities Summer School](https://hch19.cl.uni-heidelberg.de). The tutorial will take place on Monday afternoon (July 15) and is held by the entire QuaDramA team. We will give a brief introduction into R and RStudio, but the main part will be a hands-on session using  tools we develop(ed) within our project. <br/>*This post will be updated with material, slides etc.*

## Abstract

In the tutorial, we will investigate dramatic texts using tools developed within the QuaDramA project. One of the core properties of dramatic texts is their structured nature which allows for straightforward structural analysis (if TEI-encoded corpora, such as [theatre classique](http://theatre-classique.fr) or [GerDraCor](https://github.com/dracor-org/gerdracor) are available). In addition to structural analysis (for instance, in the form of character networks), we will cover NLP-based text analysis for the character speech, and combine both types to enrich each other.

Practically, the tutorial covers three aspects: a) a basic introduction into the programming language R and the development environment RStudio, b) a hands-on introduction into the R package [DramaAnalysis](https://github.com/quadrama/DramaAnalysis), used for testing hypotheses derived from drama history, and c) a guide for the operationalization of drama-related research questions, and the subsequent interpretation of quantitative results.

## Structure and Material

The workshop is split into two parts, conveniently separated by a coffee break:

### Part 1: Theory and overview

- Introduction (Marcus Willand)
- Operationalisation: A key challenge in Computational Literary Studies (Benjamin Krautter)
- Use cases in quantitative drama analysis
    - Utterance and character analysis (Janis Pagel)
    - Semantics of character speech (Benjamin Krautter)     
    - Character presence and network analysis (Nils Reiter)

#### Material

- [Slides]({{site.baseurl}}/assets/2019-03-08-quadrama-tutorial/slides_introduction.pdf)

### Part 2: Practice and lab session

- Introduction (Nils Reiter)
- Lab session (Everyone)
- Wrap-Up (Nils Reiter)
  
#### Material and links

- [Handout]({{site.baseurl}}/assets/2019-03-08-quadrama-tutorial/handout.pdf)
- [Slides]({{site.baseurl}}/assets/2019-03-08-quadrama-tutorial/slides_lab_session.pdf)
- [Written tutorial](https://quadrama.github.io/DramaAnalysis/tutorial/3/)
- [R package documentation](https://quadrama.github.io/DramaAnalysis/3.0.0/)
- Data sources
   - Shakespeare plays: [TEI](https://github.com/dracor-org/shakedracor),  [CSV](https://github.com/quadrama/data_shakedracor)
   - German plays: [TEI](https://github.com/quadrama/Corpus),  [CSV](https://github.com/quadrama/data_qd)