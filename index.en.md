---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: en
ref: index
---

# New Posts

<ul class="posts">
  {% for post in site.categories.Vortrag offset: 0 limit: 1 %}
    {% include date.html date=post.date lang=post.lang %}
    {% include teaser.html post=post %}
  {% endfor %}
  {% for post in site.categories.Technology offset: 0 limit: 2 %}
  {% include date.html date=post.date lang=post.lang %}
  {% include teaser.html post=post %}
{% endfor %}
</ul>
