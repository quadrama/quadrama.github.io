---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: de
ref: index
---



Neueste Beiträge sind direkt unten verlinkt, oder über die Sidebar zu finden.

## News: Vortrag

<ul class="posts">
  {% for post in site.categories.Vortrag offset: 0 limit: 1 %}
    {% include date.html date=post.date lang=post.lang %}
    {% include teaser.html post=post %}
  {% endfor %}
</ul>

<div style="clear:both;"></div>

## Neues aus dem Maschinenraum

<ul class="posts">
  {% for post in site.categories.Technology offset: 0 limit: 1 %}
  {% include date.html date=post.date lang=post.lang %}
  {% include teaser.html post=post %}
{% endfor %}
</ul>
