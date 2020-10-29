---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: en
order: 0
ref: index
---



QuaDramA -- Quantitative Drama Analytics -- is a research project that [we](https://quadrama.github.io/people.en) currently conduct at the Universities of [Stuttgart](http://www.uni-stuttgart.de/) and [Heidelberg](http://www.uni-heidelberg.de/). In the first phase of our project (2017-2020) we developed new methods to analyse dramatic texts and investigated drama-historic developments using these new methods. In the second phase (2020-2023, Q:TRACK) we dedicate ourselves to track character knowledge about social relations within the dramatic world, focusing the automatic identification and formal modeling of this knowledge.
The core idea of QuaDramA is the complementation of analysing structural information (e.g., acts and scenes) with an NLP-supported analysis of the character speech.


-----

{% assign posts=site.posts | where:"lang", page.lang | where: "index", true %}

{% if posts.size > 0 %}

## News



<ul class="posts">
  {% for post in posts offset: 0 limit: 3 %}
	{% if post.update %}
		{% include date.html date=post.update lang=post.lang %}
	{% else %}
		{% include date.html date=post.date lang=post.lang %}
	{% endif %}
    {% include teaser.html post=post %}
  {% endfor %}
</ul>

<div style="clear:left;">&nbsp;</div>

{% endif %}

{% if false %}


## Newest Articles

<ul class="posts">
  {% for post in site.categories.Artikel offset: 0 limit: 1 %}
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

{% endif %}
