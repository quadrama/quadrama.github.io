---
layout: page
title: Tools
lang: de
ref: tools
editor: pagel
---

Hier findet sich eine Übersicht der Tools, die im Rahmen von QuaDramA entwickelt werden.

* ToC
{:toc}

{% for tool in site.data.tools %}

## {{ tool.title }}

<div class="badges">

{% if tool.doi %}
<a href="https://doi.org/{{tool.doi}}"><img src="https://img.shields.io/badge/doi-{{tool.doi}}-blue.svg" /></a>
{% endif %}

{% if tool.license %}
{% assign lic = site.data.licenses[tool.license] %}
<a href="{{lic.link}}"><img src="https://img.shields.io/badge/license-{{lic.title}}-blue.svg" /></a>
{% endif %}

{% for b in tool.badges %}
{% if b.link %}<a href="{{b.link}}">{% endif %}
<img src="https://img.shields.io/badge/{{b.label}}-{{b.value}}-blue.svg" />
{% if b.link %}</a>{% endif %}
{% endfor %}

{% if tool.github %}
<a href="{{tool.link}}/releases/latest"><img src="https://img.shields.io/github/release-pre/{{tool.github}}.svg?style=flat-square" /></a>
{% endif %}

</div>

{% for ss in tool.screenshots %}
<div class="figure">
<img src="{{site.baseurl}}/{{ss}}" />
</div>
{% endfor %}

<p>{{ tool.description[page.lang] }}</p>

<a href="{{tool.url}}">{{tool.url}}</a>

{% if tool.citation %}
**Citation**

{% assign citeId = "/publications/" | append: tool.citation %}
{% assign pub = site.publications | where: "id", citeId | first %}

{% include pub.html p=pub %}
{% endif %}
{% endfor %}