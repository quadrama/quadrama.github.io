---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: en
ref: index
---



QuaDramA -- Quantitative Drama Analytics -- is a research project [we](https://quadrama.github.io/about.en) currently conduct at [Stuttgart University](http://www.uni-stuttgart.de/). The aim of the project is the development of new methods to analyse dramatic texts and the investigation of drama-historic developments using these new methods. The core idea of QuaDramA is the complementation of analysing structural information (e.g., acts and scenes) with an NLP-supported analysis of the figure speech.

You can find newest posts below and older ones via the sidebar.<br> 
 
<br>

## Newest Talk

<ul class="posts">
  {% for post in site.categories.Vortrag offset: 0 limit: 1 %}
    {% include date.html date=post.date lang=post.lang %}
    {% include teaser.html post=post %}
  {% endfor %}
</ul>

<div style="clear:left;">&nbsp;</div>

## Newest Tech post


<ul class="posts">
  {% for post in site.categories.Technology offset: 0 limit: 1 %}
    {% include date.html date=post.date lang=post.lang %}
    {% include teaser.html post=post %}
  {% endfor %}
</ul>
