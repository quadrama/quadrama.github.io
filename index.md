---
layout: default
title: QuaDramA - Quantitative Drama Analytics
lang: de
ref: index
---

QuaDramA -- Quantitative Drama Analytics -- ist ein Forschungsprojekt, das [wir]({{ site.baseurl }}/people.de) an den Universitäten [Stuttgart](http://www.uni-stuttgart.de/) und [Heidelberg](http://www.uni-heidelberg.de/) durchführen. In der ersten Projektphase (2017-2020) stand die Entwicklung neuer Methoden zur Analyse dramatischer Texte und die Untersuchung dramenhistorischer Entwicklungen auf Basis dieser Methoden im Erkenntnisinteresse. In der zweiten Projektphase (2020-2023, Q:Track) widmen wir uns darüber hinaus dem Figurenwissen über soziale Relationen innerhalb der dramatischen Welt, wobei die automatisierte Idenifikation und formale Modelierung dieses Wissens im Fokus steht. Kern des Gesamtprojektes ist die Komplementierung von strukturellen Informationen in Dramen (Einteilung in Akte, Szenen etc.) und deren Nutzbarmachung für die Analyse der Figurenrede. 

Neueste Beiträge sind direkt unten verlinkt, oder über die Sidebar zu finden.

------
{% assign posts=site.posts | where:"index", true %}

{% if posts.size > 0 %}
## Neuigkeiten

<ul class="posts">
{% for post in posts offset: 0 limit: 3 %}
    {% assign germanVersion = site.posts | where:"ref", post.ref | where:"lang", "de" %}
	{% if post.lang=="en" %}
		{% if germanVersion == empty %}
			{% if post.update %}
				{% include date.html date=post.update lang=post.lang %}
			{% else %}
				{% include date.html date=post.date lang=post.lang %}
			{% endif %}
			{% include teaser.html post=post %}
		{% endif %}
	{% else %}
		{% include date.html date=post.date lang=post.lang %}
		{% include teaser.html post=post %}
	{% endif %}
  {% endfor %}
</ul>

<div style="clear:both;"></div>

{% endif %}

{% if false %}

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

{% endif %}

