---
layout: post
title: Technology Overview
lang: en
ref: technology
logo: /assets/generic/code.r.png
categories: Technology
authors: Nils Reiter
---

This post gives an overview of the current state of the technology we are using and how we plan to proceed in the future. All programs, scripts and components are available on [our github page](http://github.com/quadrama).
<!--more-->

## NLP Processing

The NLP processing components (e.g., PoS-Tagging and Lemmatization, but also speaker identification etc.) are grouped in the module [DramaNLP](http://github.com/quadrama/DramaNLP).

## Web service

To have a clear repository of the processed texts, we created a tomcat web app as a web service. The web service can be used to update certain kinds of meta data or re-run NLP analyses to a certain extent. Most importantly, the web services offers querying options to retrieve **CSV-tables** that can be processed with R. In fact, R directly access the web service using `read.csv`.

## R Analysis
The R package (currently called DramaAnalysis, which is a bit unfortunate...) collects a number of often used functions. It will grow over time and be extended.

## This web page / web app
We have experimented with an interactive web application to show some analyses. Some of the ideas are now re-used in the form of this web page. Basically, we export data from R into json and then javascript to make it interactive.
