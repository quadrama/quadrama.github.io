---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: de
---

# Hi there

Intro-Absatz

---

## Neue Posts

<ul class="posts">
  {% for post in site.posts offset: 0 limit: 2 %}
    {% include date.html date=post.date lang=post.lang %}
    {% include teaser.html post=post %}
  {% endfor %}
</ul>
