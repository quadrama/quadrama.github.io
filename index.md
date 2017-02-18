---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: de
ref: index
---

QuaDramA -- Quantitative Drama Analytics -- ist ein Forschungsprojekt, das [wir]({{ site.baseurl }}/about.de) derzeit an der [Universität Stuttgart](http://www.uni-stuttgart.de/) durchführen. Ziel des Projektes ist zum einen die Entwicklung neuer Methoden zur Analyse dramatischer Texte und zum anderen die Untersuchung dramenhistorischer Entwicklungen. Kern ist dabei die Komplementierung von strukturellen Informationen in Dramen (Einteilung in Akte, Szenen etc.) mit einer computerlinguistisch unterstützten Analyse der Figurenrede(n).

Neueste Beiträge sind direkt unten verlinkt, oder über die Sidebar zu finden.

------
{% assign posts=site.categories.QuaDramA | where:"lang", page.lang %}

{% if posts.size > 0 %}
## Neuigkeiten zu QuaDramA

<ul class="posts">
  {% for post in posts offset: 0 limit: 2 %}
    {% include date.html date=post.date lang=post.lang %}
    {% include teaser.html post=post %}
  {% endfor %}
</ul>

<div style="clear:both;"></div>

{% endif %}


## Letzter Artikel

<ul class="posts">
  {% for post in site.categories.Artikel offset: 0 limit: 1 %}
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
<div style="clear:both;"></div>
