---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: en
ref: index
---



You can find newest posts below and older ones via the sidebar.

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
