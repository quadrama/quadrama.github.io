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
  <li lang="{{ post.lang }}">
    <p class="right">{{ day }}{{ sup }} {{ month }} {{ year }}</p>
    {% if post.logo %}
      <div style="float:left;height:100%"><a href="{{ post.url }}"><img src="{{ post.logo }}" /></a></div>
    {% endif %}
    <p><a href="{{ post.url }}" title="{{ post.title }}">{{ post.title }}</a></p>
    <p> {{ post.excerpt }} </p>
  </li>
</ul>
