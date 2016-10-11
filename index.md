---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: de
---

# Hi there

Intro-Absatz

---

## Neuigkeiten
{% assign post = site.posts.first %}
{% include date.html date=post.date %}

<div lang="{{ post.lang }}">
<span>{{ day }}{{ sup }} {{ month }} {{ year }}</span>: <span style="font-weight:bold;">{{ post.title }}</span>
<p>{{ post.excerpt }}<a href="{{ post.url }}">Weiterlesen ...</a></p>
</div>
