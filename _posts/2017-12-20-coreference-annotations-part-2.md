---
title: "Annotating Coreference Chains (Part 2)"
authors:
- Nils Reiter
layout: post
categories:
- Article
- Technology
lang: en
ref: coreference-annotations-part-2
index: true
---

We have recently started to annotate coreference chains in dramatic texts. In this loose series of blog posts, we will discuss interesting findings and examples. This post revisits the annotation tool question.

[Part 1]({{ site.baseurl }}{% link _posts/2017-12-06-coreference-annotations-part-1.md %}) | 
Part 2 |
[Part 3]({{ site.baseurl }}{% link _posts/2018-04-19-coreference-annotations-part-3.md %})


<!--more-->
## Table of contents
{:.no_toc}

* ToC
{:toc}

Before going into details about interesting findings, we'll have to revisit the annotation tool question, because there has been a development.

## XML-Editor and TEI

Our initial setup was to ask the annotators to annotate coreferences directly in TEI/XML, using the plain text editor [Atom](https://atom.io). Atom is extendable relatively easy, so that we could have provided a [package](https://github.com/quadrama/edit-drama-corpus) to support the annotators to some extent. Initial annotations done by the annotators contained only a few XML issues (missing quotes mostly), which were easy to fix.

However, there is no straightforward way of inspecting, correcting and merging the annotations, and this proved to be a severe issue. Since chain ids have to be selected by each annotator individually, it is not trivial to identify disagreements. More advanced features we might want to annotate (link types, for instances) are increasingly complex to do in TEI. So, we were not happy with the situation.

## Requirements
Let's revisit our requirements: We need to be able to 

- Produce TEI files, in order to retain compatibility with other drama corpora.
- Incorporate newer versions of the base corpus (GerDraCor) into our annotations
- Annotation using [WebAnno](https://webanno.github.io): The main reason for WebAnno is that the output format it uses (UIMA XMI) is the same we are using to do [natural language processing](https://github.com/quadrama/DramaNLP) of texts (because both are based on [Apache UIMA](http://uima.apache.org)).

So the question is: Can we find a setup that fulfills all these requirements, and if so, how does it look like?

## Converting TEI/XML to UIMA XMI

One of the core challenges is converting the data formats on a technical level. Since we have been parsing TEI/XML texts into UIMA since the very beginning of our project, this is more or less solved: We parse the XML using [JSoup](https://jsoup.org) and set the entire text content of the DOM document as document text in UIMA. In addition, we create stand-off annotations for every XML element, such that it covers exactly the text it contains, and add all the XML attributes as features to the annotation. This allows to formulate rules by misusing the CSS engine of jsoup. For instance, we can specify that the text content of the element described by `div[type=act] > div > head` is to be annotated as an `ActHeading` (the heading of a dramatic act). And the nice thing is, we can employ the same technology (with different rules) to parse texts from HTML (e.g., from [Gutenberg-DE](http://gutenberg.spiegel.de)).[^1]

[^1]: If you're interested: The heavy lifting of this is done in the class [`GenericXmlReader`](https://github.com/quadrama/DramaNLP/blob/263ceb4bf1e9e0f62c5bcbc4d04df05e65c7f0e7/de.unistuttgart.ims.drama.io.core/src/main/java/de/unistuttgart/quadrama/io/core/GenericXmlReader.java), rules for converting GerDraCor can be found in the class [`GerDraCorUrlReader`](https://github.com/quadrama/DramaNLP/blob/263ceb4bf1e9e0f62c5bcbc4d04df05e65c7f0e7/de.unistuttgart.ims.drama.io.tei.textgrid/src/main/java/de/unistuttgart/quadrama/io/tei/textgrid/GerDraCorUrlReader.java).

It is not surprising that this direction is easier, since UIMA XMI is the more flexible and powerful format. But what about the other direction?

## Converting UIMA XMI to TEI/XML


The data format UIMA XMI is based on character offsets, i.e., for each annotation we record it's begin and end character. This allows, for instance, to annotate overlapping spans. Assume, for the moment, that we want to annotate the sentence

> The dog barks.

If, for some reasons, we want to mark the span "the dog" (e.g., as a noun phrase), and at the same time annotate "dog barks" (e.g., as a BARK-event). This would result in overlapping, but not enclosing annotations. In UIMA, this would be represented[^2] with two annotations:

[^2]: Conceptually, I'm leaving out a lot of technical stuff here here.

```xml
<cas text="The dog barks." />
<nounphrase begin="0" end="7" />
<bark begin="4" end="13" />
```

The original text is stored as an attribute of the `cas`-element, and each annotation is its own XML element that refers to portions of the text by character positions.

If we want to use inline XML (as done in TEI/XML), we could write something like

```xml
<text>
	<nounphrase>The <bark>dog</nounphrase> barks</bark>.
</text>
```

... with the unfortunate side-effect, that **this is not valid XML** (because it no longer is a tree of objects).

In essence: When we encounter overlapping, non-enclosing annotations, they can not be represented in TEI/XML (at least not without jumping through additional hoops). The bright side is: When doing coreference annotation, we should expect quite a bit of overlapping enclosing annotations (e.g., in "my dog barks", both "my" and "my dog" refer to an entity), but no overlapping *non*-enclosing annotations, since our annotation boundaries follow linguistic structures (full phrases).

I therefore implemented a TEI export from UIMA/XML[^3]. The core idea is to reverse the parsing operation: As a first step, we add annotations for every XML element we want to export (or keep the ones we have from import). We then put the entire textual content of the XMI document in a Java StringBuilder (a string, but editable). Then, we go over each character position (in reverse direction, i.e., from end to the beginning), and check which annotations begin and end here. If, at a certain position, an annotation begins, we insert the opening tag and all attributes here (selecting the shortest annotations first, to maintain hierarchy). If an annotation ends, we insert the closing tag (longest first). We insert these tags all at the same position, which makes the string longer. But since we're iterating from the back, no character positions need to be recalculated.

[^3]: It's [here](https://github.com/quadrama/DramaNLP/blob/263ceb4bf1e9e0f62c5bcbc4d04df05e65c7f0e7/de.unistuttgart.ims.drama.io.tei.textgrid/src/main/java/de/unistuttgart/quadrama/io/tei/textgrid/TEIWriter.java), but name and/or location will likely change.

Voilà. We can now convert UIMA documents into TEI (and back), as long as there are no overlapping annotations (and we cannot guarantee the same ordering of empty XML tags).


## WebAnno

In order to annotate dramatic texts using WebAnno, we can now follow this easy 7-step recipe:

1. Import Dramatic text into UIMA pipeline
2. Do tokenization, sentence splitting
3. Convert existing speaker-markings (who speaks?) to coreference chains, following the [DKpro type system](https://dkpro.github.io/dkpro-core/releases/1.8.0/docs/typesystem-reference.html#_coreference) (the type system defines which annotations can exist -- in the example above, it would define that there are annotations called "nounphrase" and annotations called "bark").
4. Export as UIMA XMI, upload into WebAnno
5. Annotate
6. Export WebAnno project (or individual files) as UIMA XMI
7. Convert UIMA XMI into TEI/XML

And with that, we decided that we use WebAnno for doing coreference annotations in the future. In addition, this setup allows doing other linguistic annotations easily (e.g., part of speech or lemmatization).

Next time, we will really talk about interesting coreference findings.
