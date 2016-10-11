---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: de
---

# Hi there

Intro-Absatz

---

## Neue Posts

{% assign post = site.posts.first %}
{% include date.html date=post.date lang=post.lang %}
<ul class="posts">
  {% include teaser.html post=post %}
</ul>
