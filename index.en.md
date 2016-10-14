---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: en
ref: index
---

# Hi there

Intro-Absatz

---

## New Posts

<ul class="posts">
  {% for post in site.posts offset: 0 limit: 2 %}
    {% include date.html date=post.date lang=post.lang %}
    {% include teaser.html post=post %}
  {% endfor %}
</ul>
