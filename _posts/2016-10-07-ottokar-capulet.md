---
layout: post
title: Ottokar Capulet und Julia Schroffenstein - Liebeskonflikte und Gattungskontexte bei Kleist und Shakespeare
lang: de
ref: 2016-10-07-ottokar-capulet
logo: /assets/2016-10-07-ottokar-capulet/logo_kleist_museum.gif
authors:
- Nils Reiter
- Marcus Willand
publication-date: 2016-10-07
categories: Vortrag
---



Eingeladener Vortrag am 07.10.2016 im Kleist-Museum, Frankfurt (Oder), im Rahmen des wissenschaftlichen Kolloquiums während der [Kleist-Festtage 2016](http://www.kleist-museum.de/fileadmin/kleist/dokumente/kleist-museum/Kleist-Festtage_Programmheft_2016.pdf). Wir untersuchen Figuren auf der Mikroebene und Gattungszuschreibungen auf der Makroebene.
<!--more-->

## Inhaltsverzeichnis
{:.no_toc}

* ToC
{:toc}

---

## Technische Vorarbeiten

Grundlage der hier beschriebenen Arbeit sind die Dramen im [TextGrid Repository](https://textgridrep.org). Diese wurden zunächst in ein Stand-Off-Format überführt (mit unserer Bibliothek [DramaNLP](https://github.com/quadrama/DramaNLP)). Auf dieser Basis konnten dann die in [DKPro Core](https://dkpro.github.io/dkpro-core/) integrierten Werkzeuge zur [Lemmatisierung](https://de.wikipedia.org/wiki/Lemma_(Lexikographie)) und zum [PoS-Taggen](https://de.wikipedia.org/wiki/Part-of-speech_Tagging) verwendet werden: [mate-tools](http://www.ims.uni-stuttgart.de/forschung/ressourcen/werkzeuge/matetools.en.html) und [Stanford PoS-Tagger](http://nlp.stanford.edu/software/tagger.shtml). Grundlage der Analysen mit R wiederum (siehe Anhang) sind  daraus exportierte CSV-Dateien, die die Wörter einzelnen Figuren zuordnen ([Romeo und Julia]({{ site.url }}/assets/2016-10-07-ottokar-capulet/vndf.0.csv), [Die Familie Schroffenstein]({{ site.url }}/assets/2016-10-07-ottokar-capulet/r0px.0.csv)).

## Ausgangslage

### Forschungsproblem
Die literaturwissenschaftliche Forschung hat im Anschluss an die Bemühungen von Meta Corssen (1930) zahlreiche Textmerkmale identifiziert, mit denen der Einfluss von Shakespeares *Romeo und Julia* auf Kleists *Familie Schroffenstein* zu belegen versucht wird. Angeführt werden dabei Textelemente oder Texteigenschaften , die sowohl bei Shakespeare als auch bei Kleist nachweisbar sind (Gundolf 1911 unterscheidet "Shakespeare als Stoff", "Form" und "Gehalt"). Hierzu zählen <br><br>
- Figuren und Figurentypen wie der Narr (Rupert), der Bastard (Jeronimus) und die Hexe (Ursula, Barnabe), aber auch <br>
- Handlungselemente (Kindsmord), <br>
- Stilelemente (Grausamkeit des Kindsmords) und <br>
- Motive wie das der verbotenen Liebe (Schmidt 2003, 62). <br>

Auch *vermeintliche* direkte Zitate und Metaphern wie die Beschreibung des Geliebten als Vogel in der Hand eines Mädchens werden als Übernahmen Kleists verstanden (hierzu Theisen 1999: 93), aber letztlich muss auch aufgrund der Uneindeutigkeit der spärlichen Hinweise in den wenigen erhaltenen Briefen Kleists ([hier](http://kleist-digital.de/brief?id=letters/b_027.xml#shakespeare), Z. 192 und [hier](http://kleist-digital.de/brief?id=letters/b_092.xml#shakespeare), S. 141) unklar bleiben, welche Stücke Shakespeares Kleist tatsächlich kannte und ob er sie im Original oder einer der Übersetzungen seiner Zeit gelesen hat (am prominentesten waren die von Wieland aus den 1760ern, die von Eschenburg aus den 1770ern und die in den 1790ern begonnenen von Schlegel/Tieck; Schabert 2009, 821-842)

### Forschungsfrage

Im Folgenden möchten wir untersuchen, ob sich mit den von uns entwickelten *tools* zur quantitativen Dramenanalysen ein Einfluss Shakespeares auf Kleist hinsichtlich der Konzeption von Figurenrede nachweisen lässt. Unsere Untersuchung möchten wir jedoch nicht als Kritik oder Herausforderung weder der bisherigen Forschungsmeinungen noch der etablierten Praktiken des literaturwissenschaftlichen Lesens und Interpretierens verstanden wissen. Vielmehr soll die durch Digitalisierung ermöglichte Verarbeitung sehr großer Dramen-Korpora eine Neuperspektivierung einzelner dramatischer Texte ermöglichen und dergestalt bisher kaum feststellbare dramenhistorische Einflussbeziehungen offenlegen. <br>
Dieser Form der Makroanalyse stellen wir - ganz im Sinne des *scalable readings* - Mikroanalysen der dramatischen Texte gegenüber. In diesen werden die Redesemantiken der relevanten und analogen Figuren aus beiden Stücken verglichen. 
Dabei wird sich zwar zeigen, dass sich ein Einfluss Shakespeares auf Kleist nur eingeschränkt nachweisen lässt: vielmehr scheint seine Figurenkonzeption - bzw. genauer: seine Konzeption der Figurenrede - überhaupt nur als Überlagerung verschiedener dramatischer Strömungen seiner Zeit zu verstehen zu sein; hierfür spricht auch die Skepsis Kleists gegenüber einer generisch eindeutigen Festlegung seiner Stücke nach dem *Krug*, also ab etwa 1806. Der regen Diskussion darüber, ob die als "Schauspiel" oder "Drama" publizierten Stücke (*Hermannsschlacht*, *Prinz von Homburg*) eher der Komödie oder der Tragödie zuzuordnen sind, werden wir ebenfalls ein quantitatives Argument beisteuern. Wir werden zu zeigen versuchen, dass Kleists Entscheidung gegen eine klare Zuordnung offenbar Resultat eines propfunden Gattungsbewusstseins ist, das bereits die Komposition seiner Texte beeinflusst. 

## Mikroanalyse: Figurenrede

Unsere Analysen gehen von der Annahme aus, dass das Zählen von Wörtern in dramatischen Texten zu Einsichten führt, die einer Erstlektüre ebenso wie einer professionellen Interpretation von Texten sekundieren können, indem Informationen solcher Art sichtbar gemacht werden, die durch Linearität und Umfang der Texte für menschliche Leser sonst kaum zugänglich sind. Dass Zählen und Aufzählen jedoch bei Weitem nicht reicht, um Erkenntnisprozeese zu befördern, mag ein kurzer Blick in den 8./9. Band der Reihe "Indices zur deutschen Literatur" (Schanze 1989, 242f.) zeigen:
<div class="figure">
  <img width="400" src="{{ site.url }}/assets/2016-10-07-ottokar-capulet/Schanze1989.png" />

  <p class="caption">Wörterbuch zu Heinrich von Kleist (Schanze 1989, 242f.)</p>
</div>
Wie generell in den *Digital Humanities* muss sich auch in der Literaturwissenschaft eine den spezifischen Arbeitsweisen der Disziplin angemessene Form der Visualisierung von (größeren) Datensätzen erst noch durchsetzen. <red> Für die Darstellung wenig-dimensionaler Daten scheinen uns klassische Balkendiagramme am geeignetsten</red>:  

<div class="figure">
<div id="container">bla</div>
<p class="caption">Statistik zur Figurenrede</p>
</div>

<script type="text/javascript">
var d = [[{"drama":"vndf.0","figure":"Graf Paris","tokens":641},{"drama":"r0px.0","figure":"Santing,","tokens":586},{"drama":"rksp.0","figure":"PIRRO","tokens":366}],
[{"drama":"vndf.0","figure":"Escalus","tokens":654},{"drama":"r0px.0","figure":"Barnabe, ihre Tochter.","tokens":947},{"drama":"rksp.0","figure":"Angelo, und einige Bediente.","tokens":678}],
[{"drama":"vndf.0","figure":"Gräfin Capulet","tokens":954},{"drama":"r0px.0","figure":"Gertrude, Sylvesters Gemahlin, Stiefschwester der Eustache.","tokens":1346},{"drama":"rksp.0","figure":"Conti, Maler.","tokens":764}],
[{"drama":"vndf.0","figure":"Benvolio","tokens":1393},{"drama":"r0px.0","figure":"Johann, Ruperts natürlicher Sohn.","tokens":1655},{"drama":"rksp.0","figure":"Graf Appiani.","tokens":1133}],
[{"drama":"vndf.0","figure":"Mercutio","tokens":2171},{"drama":"r0px.0","figure":"Eustache, seine Gemahlin.","tokens":2117},{"drama":"rksp.0","figure":"Claudia Galotti, Eltern der Emilia.","tokens":2137}],
[{"drama":"vndf.0","figure":"Capulet","tokens":2749},{"drama":"r0px.0","figure":"Rupert, Graf von Schroffenstein, aus dem Hause Rossitz.","tokens":2392},{"drama":"rksp.0","figure":"Emilia Galotti.","tokens":2363}],
[{"drama":"vndf.0","figure":"Juliens Amme","tokens":2899},{"drama":"r0px.0","figure":"Jeronimus von Schroffenstein, aus dem Hause Wyk.","tokens":2516},{"drama":"rksp.0","figure":"Gräfin Orsina.","tokens":2962}],
[{"drama":"vndf.0","figure":"Bruder Lorenzo","tokens":3322},{"drama":"r0px.0","figure":"Agnes, ihre Tochter.","tokens":2669},{"drama":"rksp.0","figure":"Odoardo,","tokens":3398}],
[{"drama":"vndf.0","figure":"Julia","tokens":5112},{"drama":"r0px.0","figure":"Sylvester, sein Sohn, regierender Graf.","tokens":3534},{"drama":"rksp.0","figure":"Hettore Gonzaga, Prinz von Guastalla.","tokens":5553}],
[{"drama":"vndf.0","figure":"Romeo","tokens":5585},{"drama":"r0px.0","figure":"Ottokar, ihr Sohn.","tokens":5064},{"drama":"rksp.0","figure":"Marinelli, Kammerherr des Prinzen.","tokens":5660}]];

render_stacked_figure_statistics("#container", d, ["Romeo und Julia (Ü: Schlegel)","Die Familie Schroffenstein","Emilia Galotti"])
</script>

Betrachtet man die obige Visualsiernung der Redeanteile von Figuren, so zeigt sich auf den ersten Blick, dass das titelgebendene Liebespaar in *Romeo und Julia* mit 10.697 Wörtern fast die Hälfte der gesamten dramatischen Rede von ca. 25.000 Wörtern spricht. Ähnlich zentral präsentiert Kleist das Liebespaar in *Die Familie Schroffenstein*, Agnes und Ottokar, die mit 7730 Wörtern zusammen etwa ein Drittel des Gesamttextes von ca 23.000 Wörtern sprechen. Unabhängig davon, dass Agnes' Vater Sylvester mehr als seine Tochter spricht und damit das Liebespaar nicht wie bei Shakespeare die mit Abstand größten Redeanteile trägt, lässt sich im Vergleich mit anderen Stücken sehr deutlich zeigen, dass Liebeskonflikte nicht zwangsläufig anhand der Liebenden selbst gezeigt werden. Emilia Galotti etwa, wie Romeo und Julia auch eine titelgebende Figur, steht nur an fünfter Stelle hinsichtlich der Länge ihrer Redeanteile. Sie spricht nicht einmal halb so viel wie Marinelli und der Prinz. Bei der Analyse der dramatischen Darstellung von Liebeskonflikten scheinen offensichtlich die Kategorien *Aktivität* und *Passivität* von Figuren relevant zu sein. Sie lassen sich sehr einfach analysieren und visualisieren, geben aber dennoch ausgesprochen deutliche Hinweise darauf, wie aktiv oder passiv eine Figur bei der dramatischen Aushandlung von Konflikten ist: *Löst sie* oder löst sie *aus*?


### Variation der Äußerungslänge

Nicht nur die Anteile der Rede einer Figur in Bezug auf den Gesamttext, sondern auch die Variation der *Länge ihrer Äußerungen* kann Hinweise auf die Funktion einer dramatischen Figur geben.
Im Folgenden verwenden wir für die Visualisierung der Verteilung des Merkmals "Äußerungslänge" sogenannte [Boxplots](https://de.wikipedia.org/wiki/Boxplot). Der Analyse der Grafiken liegt die Annahme zugrunde, dass Figuren mit relativ vielen *langen* Äußerungen wichtige Figuren in Bezug auf den dramatischen Konflikt und die dramatische Handlung sind. Dies wurde in Ansätzen bereits von der literaturwissenschaftlichen Forschung versucht zu berücksichtigen, etwa in Arbeiten zu der Frage, welche Bedeutung der längste Monolog eines Stückes hat (Leo 1908; Lott 1909; Grussendorf 1914; Huersch 1947; Clemen 1964)


<div class="hslider" id="utterance-length-variation">
  <ul>
    <li>
      <div class="figure" id="utterance-length-variation-vndf0">
        <div>bla</div>
        <p class="caption">Variation der Äußerungslänge bei <span class="qd_title">Romeo und Julia</span> (Übersetzung: Schlegel)</p>
      </div>
    </li>
    <li>
      <div class="figure" id="utterance-length-variation-r0px0">
        <div>bla</div>
        <p class="caption">Variation der Äußerungslänge bei <span class="qd_title">Die Familie Schroffenstein</span></p>
      </div>
    </li>
  </ul>
</div>

<script>


var d2 = {"Benvolio":{"stats":[0.0001,0.0002,0.0004,0.0008,0.0016],"n":[62],"conf":[0.0003,0.0005],"out":[0.0032,0.004,0.002,0.0023,0.0025,0.0074]},"Bruder Lorenzo":{"stats":[0.0001,0.0004,0.0008,0.0023,0.004],"n":[56],"conf":[0.0004,0.0012],"out":[0.0109,0.0059,0.0169,0.0098,0.0062,0.0131]},"Capulet":{"stats":[0.0001,0.0006,0.0013,0.0026,0.0042],"n":[50],"conf":[0.0009,0.0018],"out":[0.0092,0.0065,0.0082]},"Escalus":{"stats":[0.0002,0.0004,0.0006,0.0018,0.0035],"n":[16],"conf":[0,0.0012],"out":[0.0069]},"Graf Paris":{"stats":[0.0002,0.0004,0.0005,0.001,0.0015],"n":[23],"conf":[0.0003,0.0007],"out":[0.003,0.0034,0.0034,0.0026]},"Gräfin Capulet":{"stats":[0.0001,0.0003,0.0005,0.0011,0.002],"n":[42],"conf":[0.0003,0.0007],"out":[0.0049]},"Julia":{"stats":[0.0001,0.0004,0.0009,0.0017,0.0035],"n":[116],"conf":[0.0007,0.0011],"out":[0.0038,0.0076,0.0036,0.0039,0.0064,0.0119,0.0037,0.0101,0.0036,0.0057,0.0036,0.0152]},"Juliens Amme":{"stats":[0.0001,0.0003,0.0006,0.0012,0.002],"n":[88],"conf":[0.0004,0.0007],"out":[0.0129,0.0033,0.0031,0.0047,0.0039,0.0041,0.0036,0.0054,0.0068]},"Mercutio":{"stats":[0.0001,0.0004,0.0008,0.0018,0.0036],"n":[51],"conf":[0.0005,0.0011],"out":[0.0122,0.0055,0.004,0.0054,0.0039]},"Romeo":{"stats":[0.0001,0.0003,0.0007,0.0016,0.0032],"n":[153],"conf":[0.0005,0.0008],"out":[0.0042,0.0037,0.0035,0.0086,0.0069,0.0053,0.0076,0.0051,0.0037,0.0168]}};
var d3 =  {"Agnes":{"stats":[0,0.0002,0.0004,0.0006,0.0012],"n":[177],"conf":[0.0003,0.0004],"out":[0.0018,0.0044,0.0102,0.0031,0.0018,0.0029,0.0019,0.0019,0.0017,0.0017,0.0016,0.0016,0.0014,0.0017,0.0018,0.0015,0.002]},"Barnabe":{"stats":[0.0001,0.0002,0.0004,0.0007,0.0015],"n":[50],"conf":[0.0003,0.0005],"out":[0.0023,0.0042,0.0041,0.0032]},"Eustache":{"stats":[0.0001,0.0003,0.0005,0.0011,0.0022],"n":[86],"conf":[0.0003,0.0006],"out":[0.0036,0.008,0.0051,0.0025,0.003,0.0037,0.0048]},"Gertrude":{"stats":[0.0001,0.0003,0.0005,0.0008,0.0015],"n":[72],"conf":[0.0004,0.0006],"out":[0.0055,0.0025,0.0019,0.0018,0.002,0.0018]},"Jeronimus von Schroffenstein":{"stats":[0.0001,0.0002,0.0004,0.001,0.002],"n":[125],"conf":[0.0003,0.0005],"out":[0.0027,0.0034,0.0037,0.0037,0.0051,0.0037,0.0027,0.0045]},"Johann":{"stats":[0.0001,0.0005,0.0008,0.0013,0.0021],"n":[65],"conf":[0.0006,0.0009],"out":[0.0063,0.0036]},"Ottokar":{"stats":[0,0.0002,0.0004,0.0009,0.0018],"n":[227],"conf":[0.0003,0.0005],"out":[0.0028,0.003,0.0054,0.0059,0.0021,0.002,0.0069,0.0019,0.0092,0.0019,0.002,0.0043,0.0048,0.004,0.0039,0.0029,0.0023,0.0023,0.0089,0.0025,0.0057,0.0093,0.003,0.0031,0.0021]},"Rupert":{"stats":[0,0.0002,0.0004,0.0007,0.0013],"n":[134],"conf":[0.0003,0.0005],"out":[0.0016,0.0111,0.0042,0.0014,0.0017,0.0028,0.0029,0.0042,0.0018,0.0018,0.0036,0.002,0.002,0.0021,0.0017]},"Santing":{"stats":[0.0001,0.0003,0.0004,0.0008,0.0016],"n":[39],"conf":[0.0003,0.0006],"out":[0.0019]},"Sylvester":{"stats":[0.0001,0.0003,0.0007,0.0013,0.0028],"n":[126],"conf":[0.0005,0.0008],"out":[0.0045,0.0032,0.0065,0.0048,0.0071,0.0106]}};

render_boxplots("#utterance-length-variation-vndf0 > div", d2);
render_boxplots("#utterance-length-variation-r0px0 > div", d3);

</script>

Die angezeigten Boxen beinhalten die mittleren 50% der Daten, was in diesem Fall bedeutet, dass unter den Boxen das Viertel der kürzeren Äußerungen und über den Boxen das Viertel der längeren Äußerungen liegt. Die Punkte (Ausreißer) repräsentieren besonders lange Äußerungen. Dass die angezeigten Boxen jeweils kurz über Null beginnen, lässt sich damit erklären, dass es kaum eine Figur im dramatischen Texten gibt, die nicht irgendwann einmal in Einsatz-Antworten auf andere Figuren reagiert. Benvolio (ganz links) und Graf Paris etwa machen dies jedoch fast ausschließlich (flache Box, niedriger [Median](https://de.wikipedia.org/wiki/Median), kaum Ausreißer). Figuren dieser Art sind in der Regel nicht in solchen Szenen präsent, in denen zentale Elemente des dramatischen Konfliktes augehandelt werden. Bruder Lorenz hingegen (zweiter von link) ist offensichtlich sehr wenig in Gesprächssituationen involviert, in denen kurze Antworten genügen: Der Median liegt tief (d.h. 50-75% der Äußerungen sind relativ lang) und seine Äußerungen beinhalten viele Ausbrecher. Auffällig ist, dass Romeos und Julias Verteilung der Redelängen sehr ähnlich ist; Der etwas höhere Median bei Julia zeigt an, dass sie etwas häufiger als Romeo in kürzeren Äußerungen spricht; das macht sie überwiegend dann, wenn sie mit ihren Eltern co-präsent ist. 
Es deutet vieles darauf hin, dass die Äußerungslänge ein u.a. Marker für die Reflexionskraft von Figuren ist; sie kann allerdings auch auf andere Figureneigenschaften hinweisen, etwa die rauschhafte Verliebtheit von Romeo und Julia. 
Insgesamt zeigt sich, dass die Längenvarianz der Figurenrede in *Romeo und Julia* sehr groß ist (mal viele, mal wenige Ausreißer, unterschiedlich hohe Boxen und Mediane). Dieser Befund bestätigt das Bild von einer diversen, variantenreichen Dramenkonzeption Shakespears.
Vergleicht man hierzu die Äußerungslängen in der *Familie Schroffenstein* (Grafik oben nach links wischen), so zeigt sich das konträre Bild einer sehr geringen Varianz. Kleist reguliert die Redelänge seiner Figuren offensichtlich viel stärker; dies kann - so unsere These - zurückgeführt werden auf eine Veränderung der Dramenkonventionen durch Lessing hin zu einer Annäherung an die Alltagssprache (zur bewussten Künstlichkeit natürlicher Dialoge im Drama siehe u.a. Berghahn 1970 u. Zimmer 1982). Obgleich die Kleist'schen Syntaxen dieser Beobachtung nicht so sehr entsprechen, die quantitativen Analysen deuten darauf hin.


### Thematische Analyse der Figurenrede

Natürlich sind wir eigentlich nicht - bzw. nicht nur - daran interessiert, wer wie viel spricht. Bis zu einem gewissen Grad lassen sich zwar Zusammenhänge von Figurentyp und Quantität der Figurenrede annahmen, aber das Besondere und Innovative des QuaDramA-Projektes ist, dass es uns erlaubt, die Inhalte und Semantiken dieser Rede strukturiert darzustellen. Wir zielen also ab auf eine Beantwortung der Frage, *worüber wird eigentlich gesprochen*?

Grundsätzlich gehen wir von der Annahme aus, dass Worte und Themen sich gegenseitig bedingen. Man kann nicht über bestimmte Themen sprechen ohne bestimmte, semantisch verwandte Wörter zu verwenden. Umgedreht heißt das, dass die Verwendung bestimmter Wörter Rückschlüsse auf die verhandelten Themen erlaubt. Natürlich gibt es keine 1-zu-1-Beziehung zwischen Themen und Wörtern: Wörter sind ambig, also mehrdeutig. Das offensichtliche Beispiel heute ist *Frankfurt*, das [für](https://de.wikipedia.org/wiki/Frankfurt_am_Main) [verschiedene](https://de.wikipedia.org/wiki/Frankfurt_(Oder)) [Städte](https://de.wikipedia.org/wiki/Stadt_Frankfurt) [und](https://de.wikipedia.org/wiki/Frankfort_(Kentucky)) [Orte](https://de.wikipedia.org/wiki/(204852)_Frankfurt) stehen kann.

> You shall know a word by the company it keeps.

{:.right}
-- [J. R. Firth](https://de.wikipedia.org/wiki/John_Rupert_Firth)

Wir machen uns mit o.g. Zitat zunutze, dass der Kontext von Wörtern uns sehr viel über sie verrät. In einem Text über Frankfurt (Oder) tauchen andere Wörter mit anderen Häufigkeiten auf als in einem Text über Frankfurt am Main, unabhängig vom konkreten Thema. Es stimmt zwar, dass Wörter ambig sind -- das gilt aber vor allem für Einzelwörter. Betrachtet man größere Gruppen von Wörtern, disambiguieren sie sich gewissermaßen gegenseitig.

Dies nutzen wir uns bei der sog. Wortfeldanalyse aus. Dazu haben wir Wörterbücher zu fünf relevanten Themen erstellt: [Familie](https://github.com/quadrama/metadata/tree/b5ab13da5b9b7c2aae550f4cc4a8fcc836d7411f/fields/Familie.txt), [Krieg](https://github.com/quadrama/metadata/tree/b5ab13da5b9b7c2aae550f4cc4a8fcc836d7411f/fields/Krieg.txt), [Liebe](https://github.com/quadrama/metadata/tree/b5ab13da5b9b7c2aae550f4cc4a8fcc836d7411f/fields/Liebe.txt), [Ratio](https://github.com/quadrama/metadata/tree/b5ab13da5b9b7c2aae550f4cc4a8fcc836d7411f/fields/Ratio.txt) und [Religion](https://github.com/quadrama/metadata/tree/b5ab13da5b9b7c2aae550f4cc4a8fcc836d7411f/fields/Religion.txt). Sie sind hier im Volltext verlinkt, in jedem Wortfeld sind zwischen 70 und 90 Wörter enthalten.

Die Wörter aus diesen Wortfeldern wurden dann in der Figurenrede von *Romeo und Julia* und *Die Familie Schroffenstein* gezählt, separat für jede Figur (und eingeschränkt auf Nomen, Verben und Adjektive). Daraus lässt sich eine thematische Tendenz jeder Figur ermitteln.

<div class="hslider">
  <ul>
    <li>
      <div class="figure">
        <div id="fields-vndf0">bla</div>
        <p class="caption">Semantische Felder bei <span class="qd_title">Romeo und Julia</span></p>
      </div>
    </li>
    <li>
      <div class="table">
        <table id="fields-vndf0-table" class="stripe hover row-border compact"></table>
        <p class="caption">Zahlenwerte der semantischen Felder bei <span class="qd_title">Romeo und Julia</span></p>
      </div>
    </li>
  </ul>
</div>

<script>
d4 = [{"drama":"vndf.0","figure":"Peter","Familie":0,"Krieg":2.92740046838407e-05,"Liebe":0.000174398325776073,"Ratio":0.000151791135397693,"Religion":0.000115041702617199},{"drama":"vndf.0","figure":"Escalus","Familie":4.18918352813037e-05,"Krieg":5.4608999563128e-05,"Liebe":1.62665105081658e-05,"Ratio":0,"Religion":0},{"drama":"vndf.0","figure":"Julia","Familie":0.000117906832164984,"Krieg":2.79454504806617e-05,"Liebe":0.000126943695268538,"Ratio":3.44143047585927e-05,"Religion":6.17741536940944e-05},{"drama":"vndf.0","figure":"Balthasar","Familie":4.92756479747709e-05,"Krieg":0,"Liebe":0,"Ratio":0,"Religion":0},{"drama":"vndf.0","figure":"Benvolio","Familie":3.93356213553088e-05,"Krieg":6.40959901548559e-05,"Liebe":2.29109071191825e-05,"Ratio":4.65289410013028e-05,"Religion":0},{"drama":"vndf.0","figure":"Bruder Lorenzo","Familie":0.000107213842131741,"Krieg":2.68770964135203e-05,"Liebe":9.60713233504554e-05,"Ratio":3.62343077574866e-05,"Religion":6.86544778562903e-05},{"drama":"vndf.0","figure":"Bruder Marcus","Familie":0.000476474091721263,"Krieg":0,"Liebe":0,"Ratio":0,"Religion":0},{"drama":"vndf.0","figure":"Capulet","Familie":0.000149493962935463,"Krieg":1.94876058826586e-05,"Liebe":5.0308429370835e-05,"Ratio":3.03140535952468e-05,"Religion":5.10552481604156e-05},{"drama":"vndf.0","figure":"DER BEDIENTE","Familie":5.54600410404304e-05,"Krieg":0,"Liebe":8.61400637436472e-05,"Ratio":0,"Religion":7.10277718587968e-05},{"drama":"vndf.0","figure":"ERSTER WÄCHTER","Familie":0,"Krieg":0,"Liebe":0,"Ratio":0,"Religion":0},{"drama":"vndf.0","figure":"Graf Paris","Familie":0.000149595024896886,"Krieg":4.17873857811455e-05,"Liebe":9.95784512231553e-05,"Ratio":0,"Religion":2.73695158332649e-05},{"drama":"vndf.0","figure":"Gräfin Capulet","Familie":0.000272823870652767,"Krieg":3.74363581910752e-05,"Liebe":0.000100361300682457,"Ratio":4.85286124699123e-05,"Religion":1.83897899885983e-05},{"drama":"vndf.0","figure":"Gräfin Montague","Familie":0.000220945647370747,"Krieg":0,"Liebe":0,"Ratio":7.46714456391876e-05,"Religion":0},{"drama":"vndf.0","figure":"Gregorio","Familie":0.000167056465085199,"Krieg":0.000108885017421603,"Liebe":0,"Ratio":0,"Religion":0},{"drama":"vndf.0","figure":"Juliens Amme","Familie":8.97806045542393e-05,"Krieg":2.15591583304588e-05,"Liebe":8.07321673651222e-05,"Ratio":4.15213419697725e-05,"Religion":0.000108930484196002},{"drama":"vndf.0","figure":"Mercutio","Familie":3.15491251427598e-05,"Krieg":3.29012305060209e-05,"Liebe":5.3902015935396e-05,"Ratio":4.26497432485456e-05,"Religion":1.61620079678699e-05},{"drama":"vndf.0","figure":"Montague","Familie":0.000121585474588636,"Krieg":0,"Liebe":3.14742540601788e-05,"Ratio":0,"Religion":0},{"drama":"vndf.0","figure":"Romeo","Familie":6.37715995634098e-05,"Krieg":4.15654175725796e-05,"Liebe":0.000142859863997409,"Ratio":1.49209191286183e-05,"Religion":3.1412461323407e-05},{"drama":"vndf.0","figure":"Simson","Familie":0,"Krieg":9.99466950959488e-05,"Liebe":3.96951413147031e-05,"Ratio":6.90989496959646e-05,"Religion":0},{"drama":"vndf.0","figure":"Tybalt","Familie":4.16371736686514e-05,"Krieg":8.14155449413808e-05,"Liebe":3.23352518916122e-05,"Ratio":2.81436451649218e-05,"Religion":0}];

render_spiderweb("#fields-vndf0", d4, ["Julia", "Romeo"]);
render_spiderweb_table("#fields-vndf0-table", d4);
</script>

Wie in <span class="ref-figure" /> klar zu sehen ist, sprechen Romeo und Julia beide vor allem über Liebe. Julia Eltern hingegen, Graf und Gräfin Capulet, verwenden vor allem Wörter aus dem Bereich der Familie.

<div class="hslider">
  <ul>
    <li>
      <div class="figure">
        <div id="fields-r0px0">bla</div>
        <p class="caption">Semantische Felder bei <span class="qd_title">Die Familie Schroffenstein</span></p>
      </div>
    </li>
    <li>
      <div class="table">
        <table id="fields-r0px0-table" class="stripe hover row-border compact"></table>
        <p class="caption">Zahlenwerte der semantischen Felder bei <span class="qd_title">Die Familie Schroffenstein</span></p>
      </div>
    </li>
  </ul>
</div>

<script>
var d5 = [{"drama":"r0px.0","figure":"Agnes, ihre Tochter.","Familie":8.21199258867669e-05,"Krieg":6.69057431889953e-05,"Liebe":4.78304887478775e-05,"Ratio":3.46918668387383e-05,"Religion":5.25855665766139e-05},{"drama":"r0px.0","figure":"Aldöbern,","Familie":8.58848284450552e-05,"Krieg":0.000167935512763099,"Liebe":3.33488961515374e-05,"Ratio":2.90258910948566e-05,"Religion":5.49964252323599e-05},{"drama":"r0px.0","figure":"Barnabe, ihre Tochter.","Familie":0.000188048776959685,"Krieg":6.59978880675818e-05,"Liebe":5.61684153766654e-05,"Ratio":0,"Religion":0.00014820578373071},{"drama":"r0px.0","figure":"CHOR DER MÄDCHEN","Familie":0,"Krieg":0.000120656370656371,"Liebe":0.000287521564117309,"Ratio":0.000125125125125125,"Religion":0},{"drama":"r0px.0","figure":"DER WANDERER","Familie":0,"Krieg":0,"Liebe":0,"Ratio":0,"Religion":0},{"drama":"r0px.0","figure":"Ein Kirchenvogt.","Familie":8.89521437466643e-05,"Krieg":7.73036487322202e-05,"Liebe":0,"Ratio":2.00416867083534e-05,"Religion":7.5947444368497e-05},{"drama":"r0px.0","figure":"Eine Kammerjungfer der Eustache.","Familie":0.000277674935209182,"Krieg":6.03281853281853e-05,"Liebe":7.18803910293272e-05,"Ratio":0,"Religion":0.000118539592223803},{"drama":"r0px.0","figure":"Eustache, seine Gemahlin.","Familie":0.000174710918138229,"Krieg":5.06107024765504e-05,"Liebe":9.54783465160454e-05,"Ratio":3.49901152924299e-05,"Religion":0.000140881253677415},{"drama":"r0px.0","figure":"Fintenring, Vasallen Ruperts.","Familie":0.000156854543553278,"Krieg":6.81570338058888e-05,"Liebe":0,"Ratio":7.06813683912921e-05,"Religion":0},{"drama":"r0px.0","figure":"GÄRTNER","Familie":0,"Krieg":0,"Liebe":0,"Ratio":0,"Religion":0},{"drama":"r0px.0","figure":"Gertrude, Sylvesters Gemahlin, Stiefschwester der Eustache.","Familie":0.000173013902175904,"Krieg":5.30672893228614e-05,"Liebe":3.95181941765989e-05,"Ratio":6.87909306037092e-06,"Religion":0.000130340710617554},{"drama":"r0px.0","figure":"Jeronimus von Schroffenstein, aus dem Hause Wyk.","Familie":5.98906723000196e-05,"Krieg":7.45230524642289e-05,"Liebe":6.34238744376416e-05,"Ratio":4.0481658128717e-05,"Religion":4.88104203274482e-05},{"drama":"r0px.0","figure":"Johann, Ruperts natürlicher Sohn.","Familie":1.65542358150892e-05,"Krieg":3.77643504531722e-05,"Liebe":0.000134987465449637,"Ratio":3.35683115139308e-05,"Religion":4.24020777018074e-05},{"drama":"r0px.0","figure":"Ottokar, ihr Sohn.","Familie":0.000116319331731914,"Krieg":4.4078650417513e-05,"Liebe":0.000100836946657255,"Ratio":2.37698203732959e-05,"Religion":8.66106815221308e-05},{"drama":"r0px.0","figure":"Rupert, Graf von Schroffenstein, aus dem Hause Rossitz.","Familie":0.000120263893343107,"Krieg":8.58516483516483e-05,"Liebe":4.89219383761474e-05,"Ratio":4.25802056236839e-05,"Religion":5.86751158833539e-05},{"drama":"r0px.0","figure":"Santing,","Familie":0.000140259011641498,"Krieg":4.5709410043881e-05,"Liebe":1.81540919323215e-05,"Ratio":0,"Religion":0},{"drama":"r0px.0","figure":"Sylvester, sein Sohn, regierender Graf.","Familie":0.000104658464544038,"Krieg":7.57943245209799e-05,"Liebe":3.31129814928536e-05,"Ratio":3.40606594143663e-05,"Religion":7.9428906164676e-05},{"drama":"r0px.0","figure":"Sylvius, Graf von Schroffenstein, aus dem Hause Warwand.","Familie":2.71798217003696e-05,"Krieg":7.08616780045351e-05,"Liebe":6.3323201621074e-05,"Ratio":3.67430922986479e-05,"Religion":0},{"drama":"r0px.0","figure":"Theistiner, Vasall Sylvesters.","Familie":0,"Krieg":6.78119349005425e-05,"Liebe":0,"Ratio":7.0323488045007e-05,"Religion":0},{"drama":"r0px.0","figure":"Ursula, eine Totengräberswitwe.","Familie":0.000247939007004277,"Krieg":4.04007756948933e-05,"Liebe":0,"Ratio":0,"Religion":7.93839803127729e-05}];

render_spiderweb("#fields-r0px0", d5, ["Rupert, Graf von Schroffenstein, aus dem Hause Rossitz.", "Eustache, seine Gemahlin."]);
render_spiderweb_table("#fields-r0px0-table", d5);

</script>

- Diskussion Schroffenstein

## Makroanalyse: Gattungskontexte


- Einordnung Kleist durch LitWiss

### Stilometrische Analysen
Eines der Standardverfahren zur quantitativen Analyse von Gattungen kommt aus dem Bereich des Clusterings und wird im Moment vor allem zu stilometrischen Analysen verwendet. Dabei schauen wir auf die Häufigkeit von Wörtern oder Wortformen und erstellen sog. *Wortvektoren*.

<div class="hslider">
<ul>
<li>
<div class="table">
  <table class="stripe row-border dataTable">
    <thead>
      <tr><th>Text</th><th>Hund</th><th>Haus</th><th>Hof</th><th>...</th></tr>
    </thead>
    <tbody>
    <tr><td>1</td><td>15</td><td>1</td><td>2</td><td></td></tr>
    <tr><td>2</td><td>17</td><td>13</td><td>2</td><td></td></tr>
    <tr><td>3</td><td>0</td><td>25</td><td>11</td><td></td></tr>
    <tr><td>...</td><td></td><td></td><td></td><td></td></tr>
    </tbody>
  </table>
  <p class="caption">Fiktive Wortvektoren für drei Texte</p>
</div>
</li>
<li>
<div class="figure">
  <img height="250" src="{{ site.url }}/assets/2016-10-07-ottokar-capulet/scatter-plot-hof-und.png" />
  <p class="caption">Räumliche Interpretation der Wortvektoren (in 2 Dimensionen)</p>
</div>
</li>
</ul>
</div>

Diese Wortvektoren können im n-dimensionalen Raum räumlich interpretiert werden und entsprechende geometrische Distanzmaße angewendet werden. Diese numerische Distanz erlaubt eine (hierarchische) Gruppierung der Texte nach Ähnlichkeiten in der Worthäufigkeit. Zunächst werden dabei die ähnlichsten Texte gruppiert, dann etwas weniger ähnliche Texte dazugenommen (s.a. [Hierarchische Clusteranalyse](https://de.wikipedia.org/wiki/Hierarchische_Clusteranalyse), Wikipedia).

<div class="hslider">
  <ul>
  <li>
  <div class="table">
    <table id="corpus-overview">

    </table>
    <p class="caption">Die Dramen des verwendeten Korpus</p>
  </div>
  </li>
  <li>
    <div class="figure">
      <img src="{{ site.url }}/assets/2016-10-07-ottokar-capulet/ausriss-ca.png" />
      <p class="caption">Clusteranalyse von 176 Dramen auf Basis der Nomen, Verben und Adjektive aus den Figurenreden. Grün: Tragödie, Blau: Komödie. Das vollständige Bild kann <a href="{{ site.url }}/assets/2016-10-07-ottokar-capulet/cluster-analysis.pdf">hier als PDF</a> heruntergeladen werden.</p>
    </div>
  </li>
  </ul>
</div>
<script>
var corpus = [{"X1":"11d11.0","X2":"T","title":["Faust. Der Tragödie zweiter Teil"],"author":["Goethe, Johann Wolfgang"]},{"X1":"11f7n.0","X2":"T","title":["Faust [in ursprünglicher Gestalt]"],"author":["Goethe, Johann Wolfgang"]},{"X1":"11f81.0","X2":"T","title":["Clavigo"],"author":["Goethe, Johann Wolfgang"]},{"X1":"11f9k.0","X2":"C","title":["Der Bürgergeneral"],"author":["Goethe, Johann Wolfgang"]},{"X1":"11g3h.0","X2":"T","title":["Die natürliche Tochter"],"author":["Goethe, Johann Wolfgang"]},{"X1":"11g5f.0","X2":"C","title":["Der Großkophta"],"author":["Goethe, Johann Wolfgang"]},{"X1":"11g9q.0","X2":"T","title":["Faust. Der Tragödie erster Teil"],"author":["Goethe, Johann Wolfgang"]},{"X1":"11g9w.0","X2":"T","title":["Egmont"],"author":["Goethe, Johann Wolfgang"]},{"X1":"11hb1.0","X2":"C","title":["Die Mitschuldigen"],"author":["Goethe, Johann Wolfgang"]},{"X1":"jn6k.0","X2":"C","title":["Der Gwissenswurm"],"author":["Anzengruber, Ludwig"]},{"X1":"jn6r.0","X2":"C","title":["Heimg'funden"],"author":["Anzengruber, Ludwig"]},{"X1":"k8cn.0","X2":"C","title":["Der Rauchfangkehrer"],"author":["Auenbrugger, Johann Leopold von"]},{"X1":"k93g.0","X2":"C","title":["Der Postzug oder die noblen Passionen"],"author":["Ayrenhoff, Cornelius Hermann von"]},{"X1":"kd4r.0","X2":"C","title":["Industrie und Herz"],"author":["Bauernfeld, Eduard von"]},{"X1":"kd4v.0","X2":"C","title":["Großjährig"],"author":["Bauernfeld, Eduard von"]},{"X1":"kd4z.0","X2":"C","title":["Bürgerlich und Romantisch"],"author":["Bauernfeld, Eduard von"]},{"X1":"kjfg.0","X2":"T","title":["Der Paria"],"author":["Beer, Michael"]},{"X1":"kjfz.0","X2":"C","title":["Die Lügnerin"],"author":["Benedix, Julius Roderich"]},{"X1":"kjg2.0","X2":"C","title":["Die Hochzeitsreise"],"author":["Benedix, Julius Roderich"]},{"X1":"kmf9.0","X2":"T","title":["Ezechias"],"author":["Birck, Sixt"]},{"X1":"kmff.0","X2":"T","title":["Judith"],"author":["Birck, Sixt"]},{"X1":"kmq3.0","X2":"T","title":["Ein Faust der That"],"author":["Bleibtreu, Karl"]},{"X1":"knb2.0","X2":"C","title":["Im weißen Rößl"],"author":["Blumenthal, Oskar"]},{"X1":"kpkv.0","X2":"C","title":["Der Bookesbeutel"],"author":["Borkenstein, Hinrich"]},{"X1":"kq6k.0","X2":"T","title":["Faust"],"author":["Braun von Braunthal, Karl Johann"]},{"X1":"kq6v.0","X2":"T","title":["Der Freigeist"],"author":["Brawe, Joachim Wilhelm von"]},{"X1":"kscn.0","X2":"C","title":["Leonce und Lena"],"author":["Büchner, Georg"]},{"X1":"m0br.0","X2":"C","title":["Der Mißtrauische"],"author":["Cronegk, Johann Friedrich von"]},{"X1":"mgfp.0","X2":"C","title":["Die Gunst des Augenblicks"],"author":["Devrient, Philipp Eduard"]},{"X1":"mk3n.0","X2":"C","title":["Die Wände"],"author":["Dulk, Albert"]},{"X1":"mr3k.0","X2":"T","title":["Der letzte Held von Marienburg"],"author":["Eichendorff, Joseph von"]},{"X1":"msqv.0","X2":"C","title":["Die Freier"],"author":["Eichendorff, Joseph von"]},{"X1":"mv7f.0","X2":"T","title":["Eid und Pflicht"],"author":["Engel, Johann Jakob"]},{"X1":"mvr3.0","X2":"C","title":["Der Frauenmut"],"author":["Essig, Hermann"]},{"X1":"mvrv.0","X2":"T","title":["Iphigenie in Aulis"],"author":["Euripides"]},{"X1":"n2k7.0","X2":"C","title":["Die Journalisten"],"author":["Freytag, Gustav"]},{"X1":"n2m1.0","X2":"C","title":["Fraw Wendelgard"],"author":["Frischlin, Nicodemus"]},{"X1":"n750.0","X2":"C","title":["Die zärtlichen Schwestern"],"author":["Gellert, Christian Fürchtegott"]},{"X1":"n79j.0","X2":"C","title":["Die Betschwester"],"author":["Gellert, Christian Fürchtegott"]},{"X1":"ndmr.0","X2":"T","title":["Der Moloch"],"author":["Gerhäuser, Emil"]},{"X1":"nks0.0","X2":"T","title":["Der sterbende Cato"],"author":["Gottsched, Johann Christoph"]},{"X1":"nm24.0","X2":"C","title":["Das Testament"],"author":["Gottsched, Luise Adelgunde Victorie"]},{"X1":"nmf9.0","X2":"T","title":["Kaiser Heinrich der Sechste"],"author":["Grabbe, Christian Dietrich"]},{"X1":"nmfs.0","X2":"T","title":["Kaiser Friedrich Barbarossa"],"author":["Grabbe, Christian Dietrich"]},{"X1":"nmg0.0","X2":"T","title":["Don Juan und Faust"],"author":["Grabbe, Christian Dietrich"]},{"X1":"nmg5.0","X2":"T","title":["Herzog Theodor von Gothland"],"author":["Grabbe, Christian Dietrich"]},{"X1":"npsg.0","X2":"T","title":["Des Meeres und der Liebe Wellen"],"author":["Grillparzer, Franz"]},{"X1":"ns3r.0","X2":"T","title":["Die Jüdin von Toledo"],"author":["Grillparzer, Franz"]},{"X1":"ns9c.0","X2":"T","title":["Ein Bruderzwist in Habsburg"],"author":["Grillparzer, Franz"]},{"X1":"nsv5.0","X2":"T","title":["Die Ahnfrau"],"author":["Grillparzer, Franz"]},{"X1":"nttc.0","X2":"T","title":["König Ottokars Glück und Ende"],"author":["Grillparzer, Franz"]},{"X1":"nvk1.0","X2":"T","title":["Ein treuer Diener seines Herrn"],"author":["Grillparzer, Franz"]},{"X1":"p5c7.0","X2":"C","title":["Das Urbild des Tartüffe"],"author":["Gutzkow, Karl"]},{"X1":"p7dk.0","X2":"T","title":["Catharina von Georgien"],"author":["Gryphius, Andreas"]},{"X1":"p7m9.0","X2":"T","title":["Cardenio und Celinde"],"author":["Gryphius, Andreas"]},{"X1":"p8rz.0","X2":"T","title":["Carolus Stuardus"],"author":["Gryphius, Andreas"]},{"X1":"pgph.0","X2":"C","title":["Der Furchtsame"],"author":["Hafner, Philipp"]},{"X1":"pk6x.0","X2":"C","title":["Hanna Jagert"],"author":["Hartleben, Otto Erich"]},{"X1":"pkhc.0","X2":"T","title":["Frau Nadja Bielew"],"author":["Hauptmann, Carl"]},{"X1":"pkjc.0","X2":"C","title":["Der Antiquar"],"author":["Hauptmann, Carl"]},{"X1":"pm1c.0","X2":"T","title":["Kriemhilds Rache"],"author":["Hebbel, Friedrich"]},{"X1":"pm7m.0","X2":"C","title":["Der Rubin"],"author":["Hebbel, Friedrich"]},{"X1":"pm99.0","X2":"C","title":["Der Diamant"],"author":["Hebbel, Friedrich"]},{"X1":"pmgg.0","X2":"T","title":["Herodes und Mariamne"],"author":["Hebbel, Friedrich"]},{"X1":"pmj9.0","X2":"T","title":["Gyges und sein Ring"],"author":["Hebbel, Friedrich"]},{"X1":"pmtc.0","X2":"T","title":["Genoveva"],"author":["Hebbel, Friedrich"]},{"X1":"pn2n.0","X2":"T","title":["Judith"],"author":["Hebbel, Friedrich"]},{"X1":"psxj.0","X2":"T","title":["Almansor"],"author":["Heine, Heinrich"]},{"X1":"pvxf.0","X2":"T","title":["Die Kinder Godunófs"],"author":["Heiseler, Henry von"]},{"X1":"q41n.0","X2":"T","title":["Don Juan's Ende"],"author":["Heyse, Paul"]},{"X1":"q5q1.0","X2":"C","title":["Der Mann nach der Uhr, oder der ordentliche Mann"],"author":["Hippel, Theodor Gottlieb von"]},{"X1":"qd2g.0","X2":"T","title":["Elektra"],"author":["Hofmannsthal, Hugo von"]},{"X1":"qd2n.0","X2":"T","title":["Der Turm (Neue Fassung)"],"author":["Hofmannsthal, Hugo von"]},{"X1":"qd46.0","X2":"C","title":["Der Unbestechliche"],"author":["Hofmannsthal, Hugo von"]},{"X1":"qd6w.0","X2":"C","title":["Der Schwierige"],"author":["Hofmannsthal, Hugo von"]},{"X1":"qdj2.0","X2":"T","title":["Der Turm"],"author":["Hofmannsthal, Hugo von"]},{"X1":"qdjz.0","X2":"C","title":["Der Rosenkavalier"],"author":["Hofmannsthal, Hugo von"]},{"X1":"qdk1.0","X2":"T","title":["Alkestis"],"author":["Hofmannsthal, Hugo von"]},{"X1":"qfsn.0","X2":"T","title":["Der Tod des Empedokles"],"author":["Hölderlin, Friedrich"]},{"X1":"qh44.0","X2":"T","title":["Ignorabimus"],"author":["Holz, Arno"]},{"X1":"qkmw.0","X2":"C","title":["Figaro in Deutschland"],"author":["Iffland, August Wilhelm"]},{"X1":"qkp7.0","X2":"T","title":["Das Gericht von St. Petersburg"],"author":["Immermann, Karl"]},{"X1":"qkq1.0","X2":"T","title":["Andreas Hofer, der Sandwirt von Passeyer"],"author":["Immermann, Karl"]},{"X1":"qn2w.0","X2":"T","title":["Die Opferung"],"author":["Kaltneker, Hans"]},{"X1":"r0vx.0","X2":"T","title":["Robert Guiskard [Fragment]"],"author":["Kleist, Heinrich von"]},{"X1":"r121.0","X2":"T","title":["Faust. Ein Trauerspiel in fünf Acten"],"author":["Klingemann, August"]},{"X1":"r12v.0","X2":"T","title":["Die Zwillinge"],"author":["Klinger, Friedrich Maximilian"]},{"X1":"r135.0","X2":"T","title":["Das leidende Weib"],"author":["Klinger, Friedrich Maximilian"]},{"X1":"r1zm.0","X2":"T","title":["Der Tod Adams"],"author":["Klopstock, Friedrich Gottlieb"]},{"X1":"r2m4.0","X2":"C","title":["Die deutschen Kleinstädter"],"author":["Kotzebue, August von"]},{"X1":"r2mn.0","X2":"C","title":["Die Indianer in England"],"author":["Kotzebue, August von"]},{"X1":"r2mv.0","X2":"C","title":["Die beiden Klingsberg"],"author":["Kotzebue, August von"]},{"X1":"r2r7.0","X2":"C","title":["Die Candidaten oder Die Mittel zu einem Amte zu gelangen"],"author":["Krüger, Johann Christian"]},{"X1":"r2rb.0","X2":"C","title":["Die Geistlichen auf dem Lande"],"author":["Krüger, Johann Christian"]},{"X1":"rfct.0","X2":"C","title":["Gottsched und Gellert"],"author":["Laube, Heinrich"]},{"X1":"rfm5.0","X2":"C","title":["Hahnenkampf"],"author":["Lautensack, Heinrich"]},{"X1":"rfn5.0","X2":"C","title":["Die Pfarrhauskomödie"],"author":["Lautensack, Heinrich"]},{"X1":"rfxf.0","X2":"T","title":["Julius von Tarent"],"author":["Leisewitz, Johann Anton"]},{"X1":"rhjs.0","X2":"C","title":["Die Freunde machen den Philosophen"],"author":["Lenz, Jakob Michael Reinhold"]},{"X1":"rhzq.0","X2":"C","title":["Der Hofmeister oder Vorteile der Privaterziehung"],"author":["Lenz, Jakob Michael Reinhold"]},{"X1":"rj22.0","X2":"C","title":["Der neue Menoza"],"author":["Lenz, Jakob Michael Reinhold"]},{"X1":"rjdc.0","X2":"C","title":["Die alte Jungfer"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"rjg0.0","X2":"C","title":["Der Freigeist"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"rjh9.0","X2":"C","title":["Minna von Barnhelm, oder das Soldatenglück"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"rjmw.0","X2":"T","title":["Miß Sara Sampson"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"rjwv.0","X2":"C","title":["Der junge Gelehrte"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"rkq6.0","X2":"C","title":["Der Misogyn"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"rksp.0","X2":"T","title":["Emilia Galotti"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"rktc.0","X2":"C","title":["Die Juden"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"rkzk.0","X2":"C","title":["Der Schatz"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"rkzp.0","X2":"C","title":["Damon, oder die wahre Freundschaft"],"author":["Lessing, Gotthold Ephraim"]},{"X1":"s4hh.0","X2":"T","title":["Cleopatra"],"author":["Lohenstein, Daniel Casper von"]},{"X1":"s4hw.0","X2":"T","title":["Epicharis"],"author":["Lohenstein, Daniel Casper von"]},{"X1":"s4jp.0","X2":"T","title":["Ibrahim"],"author":["Lohenstein, Daniel Casper von"]},{"X1":"s4m0.0","X2":"T","title":["Agrippina"],"author":["Lohenstein, Daniel Casper von"]},{"X1":"s6m2.0","X2":"T","title":["Die Makkabäer"],"author":["Ludwig, Otto"]},{"X1":"s6m6.0","X2":"T","title":["Der Erbförster"],"author":["Ludwig, Otto"]},{"X1":"s8bv.0","X2":"C","title":["Der alte Bürger-Capitain"],"author":["Malß, Karl"]},{"X1":"s8fd.0","X2":"T","title":["König Eduard II."],"author":["Marlowe, Christopher"]},{"X1":"ssrb.0","X2":"T","title":["König Yngurd"],"author":["Müllner, Adolph"]},{"X1":"ssrf.0","X2":"T","title":["Die Schuld"],"author":["Müllner, Adolph"]},{"X1":"st5r.0","X2":"C","title":["Die Schäferinsel"],"author":["Mylius, Christlob"]},{"X1":"sttf.0","X2":"C","title":["Das Schäferfest oder Die Herbstfreude"],"author":["Neuber, Friederike Caroline"]},{"X1":"t2z2.0","X2":"C","title":["Die verhängnisvolle Gabel"],"author":["Platen, August von"]},{"X1":"t337.0","X2":"C","title":["Der romantische Ödipus"],"author":["Platen, August von"]},{"X1":"t8tr.0","X2":"C","title":["Die politische Wochenstube"],"author":["Prutz, Robert Eduard"]},{"X1":"t907.0","X2":"C","title":["Der Hypochondrist"],"author":["Quistorp, Theodor Johann"]},{"X1":"t9p7.0","X2":"C","title":["Kritik und Antikritik"],"author":["Raupach, Ernst"]},{"X1":"t9qh.0","X2":"C","title":["Graf Ehrenfried"],"author":["Reuter, Christian"]},{"X1":"tgw6.0","X2":"C","title":["Kater Lampe"],"author":["Rosenow, Emil"]},{"X1":"tp8b.0","X2":"T","title":["Der hörnen Sewfriedt"],"author":["Sachs, Hans"]},{"X1":"tpq4.0","X2":"C","title":["Die gedultig und gehorsam Marggräfin Griselda"],"author":["Sachs, Hans"]},{"X1":"trwt.0","X2":"T","title":["Faustine, der weibliche Faust"],"author":["Schäfer, Wilhelm"]},{"X1":"tv5t.0","X2":"C","title":["Das Gift"],"author":["Scheerbart, Paul"]},{"X1":"tvbm.0","X2":"C","title":["Der Herr vom Jenseits"],"author":["Scheerbart, Paul"]},{"X1":"tvdq.0","X2":"T","title":["Es lebe Europa!"],"author":["Scheerbart, Paul"]},{"X1":"tvdx.0","X2":"T","title":["Der Schornsteinfeger"],"author":["Scheerbart, Paul"]},{"X1":"tvg7.0","X2":"T","title":["Herr Kammerdiener Kneetschke"],"author":["Scheerbart, Paul"]},{"X1":"tz9d.0","X2":"T","title":["Die Jungfrau von Orleans"],"author":["Schiller, Friedrich"]},{"X1":"tzgk.0","X2":"T","title":["Die Verschwörung des Fiesco zu Genua"],"author":["Schiller, Friedrich"]},{"X1":"v0d8.0","X2":"T","title":["Die Braut von Messina oder die feindlichen Brüder"],"author":["Schiller, Friedrich"]},{"X1":"v341.0","X2":"T","title":["Alarkos"],"author":["Schlegel, Friedrich"]},{"X1":"v3mq.0","X2":"T","title":["Canut"],"author":["Schlegel, Johann Elias"]},{"X1":"v3mw.0","X2":"C","title":["Die stumme Schönheit"],"author":["Schlegel, Johann Elias"]},{"X1":"v3mx.0","X2":"C","title":["Der geschäftige Müßiggänger"],"author":["Schlegel, Johann Elias"]},{"X1":"v3n4.0","X2":"C","title":["Der Triumph der guten Frauen"],"author":["Schlegel, Johann Elias"]},{"X1":"v3nb.0","X2":"C","title":["Comedia des verlornen Sons"],"author":["Schmeltzl, Wolfgang"]},{"X1":"v3nq.0","X2":"C","title":["Comoedia der Hochzeit Cana Galilee"],"author":["Schmeltzl, Wolfgang"]},{"X1":"v3sw.0","X2":"C","title":["Komtesse Mizzi oder Der Familientag"],"author":["Schnitzler, Arthur"]},{"X1":"v3t6.0","X2":"C","title":["III. Zum grossen Wurstel"],"author":["Schnitzler, Arthur"]},{"X1":"vmvc.0","X2":"T","title":["Julius Cäsar"],"author":["Shakespeare, William"]},{"X1":"vn90.0","X2":"C","title":["Die Komödie der Irrungen"],"author":["Shakespeare, William"]},{"X1":"vncw.0","X2":"T","title":["Hamlet. Prinz von Dänemark"],"author":["Shakespeare, William"]},{"X1":"vnfd.0","X2":"T","title":["König Richard III."],"author":["Shakespeare, William"]},{"X1":"vnfz.0","X2":"T","title":["König Lear"],"author":["Shakespeare, William"]},{"X1":"w3zd.0","X2":"T","title":["Julie"],"author":["Sturz, Helfrich Peter"]},{"X1":"w40m.0","X2":"T","title":["Der Bettler von Syrakus"],"author":["Sudermann, Hermann"]},{"X1":"wbvk.0","X2":"C","title":["Die Lokalbahn"],"author":["Thoma, Ludwig"]},{"X1":"wc9p.0","X2":"C","title":["Die Medaille"],"author":["Thoma, Ludwig"]},{"X1":"wpvj.0","X2":"T","title":["Ernst Herzog von Schwaben"],"author":["Uhland, Ludwig"]},{"X1":"wz0s.0","X2":"T","title":["Faust III"],"author":["Vischer, Friedrich Theodor"]},{"X1":"wzgs.0","X2":"T","title":["Faust. Trauerspiel mit Gesang und Tanz"],"author":["Voß, Julius von"]},{"X1":"wznj.0","X2":"T","title":["Die Kindermörderin"],"author":["Wagner, Heinrich Leopold"]},{"X1":"x34j.0","X2":"T","title":["Frühlings Erwachen"],"author":["Wedekind, Frank"]},{"X1":"x3bf.0","X2":"T","title":["Die Büchse der Pandora"],"author":["Wedekind, Frank"]},{"X1":"x3f6.0","X2":"T","title":["Erdgeist"],"author":["Wedekind, Frank"]},{"X1":"x438.0","X2":"C","title":["Bäurischer Machiavellus"],"author":["Weise, Christian"]},{"X1":"x4gj.0","X2":"T","title":["Atreus und Thyest"],"author":["Weiße, Christian Felix"]},{"X1":"x4vf.0","X2":"C","title":["Das Manuscript"],"author":["Weißenthurn, Johanna von"]},{"X1":"x4vp.0","X2":"C","title":["Welcher ist der Bräutigam"],"author":["Weißenthurn, Johanna von"]},{"X1":"x5bv.0","X2":"T","title":["Der vierundzwanzigste Februar"],"author":["Werner, Zacharias"]},{"X1":"x8fs.0","X2":"T","title":["Lady Johanna Gray"],"author":["Wieland, Christoph Martin"]},{"X1":"x8mw.0","X2":"T","title":["Gracchus der Volkstribun"],"author":["Wilbrandt, Adolf von"]},{"X1":"x8nq.0","X2":"T","title":["Die Karolinger"],"author":["Wildenbruch, Ernst von"]},{"X1":"x90m.0","X2":"T","title":["Armut"],"author":["Wildgans, Anton"]},{"X1":"x90s.0","X2":"T","title":["Dies irae"],"author":["Wildgans, Anton"]}];

render_table("#corpus-overview", corpus, [
  {title:"Titel", data: "title"},
  {title:"Autor", data:"author"},
  {title: "Komödie (C)/Tragödie (T)", data: "X2"}]);

</script>



Dieses Verfahren (auch implementiert im R-Paket [stylo](https://sites.google.com/site/computationalstylistics/stylo)) haben wir auf 95 Tragödien und 86 Komödien angewendet (<span class="ref-table"/>). <span class="ref-figure" /> zeigt einen Ausriss, das vollständige Dendrogram kann [hier]({{ site.url }}/assets/2016-10-07-ottokar-capulet/cluster-analysis.pdf) als PDF heruntergeladen werden. In beiden Fällen sind Tragödien grün gekennzeichnet und Komödien blau.

Die Einteilung entlang von Wortfrequenzen funktioniert zwar nicht perfekt, aber doch erstaunlich gut. Tragödien werden überwiegend in der oberen Hälfte gruppiert, Komödien in der unteren. Das Autorsignal ist in einzelnen Fällen zwar noch sehr stark (sprich: Stücke der gleichen Autoren werden zusammen gruppiert), aber auch nicht immer. Die Dramen von Goethe z.B. erscheinen zwar innerhalb der Gattung als Blöcke. Solche Blöcke finden sich allerdings mehrere.

Wir nehmen diesen Befund zum Anlass, uns an einer Gattungseinteilung von Kleist-Dramen zu versuchen. Dazu extrahieren wir die Lemmata der Nomen, Verben und Adjektive, die in mindestens 20 Texten vorkommen und berechnen die Korrelation mit Tragödie bzw. Komödie mit dem Spearman-Korrelationsmaß (Spearman, 1904).

<div class="table">
  <table class="stripe row-border dataTable">
    <thead><tr><th>Komödie</th><th>Tragödie</th></tr></thead>
    <tbody>
      <tr>
        <td>
          gut, frauenzimmer, machen, sagen, herr, verstehen, wissen, sache, leute, lieber, hübsch, dumm, fein, bekommen, nehmen, richtig, zufrieden, gehen, gewiß, setzen, merken, ankommen, einfall, wahrhaftig, vernünftig, frau, anfangen, glauben, liebenswürdig, übel, person, artig, ganz, ursache, tisch, vortrefflich, gelegenheit, angenehm, woche, anderer, weiß, denken, vornehm, gehören, geschwind, kriegen, empfehlen, holen, wahr, vergnügen
        </td>
        <td>
          abgrund, haupt, aug, mörder, brust, tod, blut, lebend, fluch, mord, heil, antlitz, beugen, schmach, empor, erde, stürzen, schrecken, staub, fels, grab, flamme, macht, leiche, dunkel, retten, sturm, glut, glied, beben, schwert, sterbend, sonne, geschehn, waffe, senden, heer, brechen, angesicht, strom, schatten, knabe, opfer, lager, frevel, mächtig, kraft, tief, fern, dumpf
        </td>
      </tr>
    </tbody>
  </table>
  <p class="caption">Die 50 am stärksten mit Komödie bzw. Tragödie korrelierenden Inhaltswörter</p>
</div>

<span class="ref-table" /> zeigt die 50 am stärksten korreliderenden Lemmata für die beiden Klassen (Komödie, Tragödie).


### Gattungsklassifikation

Im nächsten Schritt haben wir gezählt, wie oft diese Wörter in den Dramen von Kleist auftauchen und können uns damit auf Basis der Worthäufigkeiten an einer Gattungseinordnung versuchen.

<div class="figure">
  <div id="kleist-tendencies">bla</div>
  <p class="caption">Gattungen von Kleist-Dramen nach Wortfrequenzen korrelierender Wörter</p>
</div>

<script>
var kleist_tendencies_data = [{"drama":"r10b.0","Comedy":188,"Tragedy":-144,"title":["Prinz Friedrich von Homburg"]},{"drama":"r0gb.0","Comedy":321,"Tragedy":-177,"title":["Das Käthchen von Heilbronn oder die Feuerprobe"]},{"drama":"r0px.0","Comedy":321,"Tragedy":-177,"title":["Die Familie Schroffenstein"]},{"drama":"r0n2.0","Comedy":121,"Tragedy":-292,"title":["Penthesilea"]},{"drama":"r0sb.0","Comedy":406,"Tragedy":-49,"title":["Der zerbrochene Krug"]},{"drama":"r0jz.0","Comedy":230,"Tragedy":-118,"title":["Amphitryon"]},{"drama":"r0hz.0","Comedy":212,"Tragedy":-202,"title":["Die Hermannsschlacht"]}];

var categories = kleist_tendencies_data.map(function(cur, ind, arr) {
  return cur.title[0];
});


$('#kleist-tendencies').highcharts({
  chart: {
    type: 'bar'
  },
  title: {
    text: ''
  },
  legend: {
    enabled:false
  },
  colors: qd_colors.reverse(),
  xAxis: [{
    categories: categories,
    reversed: false,
    labels: {
      step: 1
    }
  }],
  yAxis: {
    min: -500,
    max: 500,
    title: {
      text: "← Tragödie   Komödie →"
    }
  },
  plotOptions: {
    series: {
      stacking: 'normal'
    }
  },
  series: [{
    name: "Tragödie",
    data: kleist_tendencies_data.map(function(cur, ind, arg) {
      return cur.Tragedy;
    })
  },{
    name: "Komödie",
    data: kleist_tendencies_data.map(function(cur, ind, arg) {
      return cur.Comedy;
    })
  }]
});
</script>

Wie in <span class="ref-figure" /> zu sehen ist, sind einige Dramen sehr deutlich einer Gattung zuzuordnen. Im *zerbrochenen Krug* werden überwiegend Wörter verwendet die stark mit Komödien korrelieren, bei  *Penthesilea* scheint es sich um eine Tragödie zu handeln. Am wenigsten eindeutig lassen sich insbesondere *Die Hermannsschlacht* sowie *Prinz Friedrich von Homburg* zuordnen -- dabei handelt es sich just um die Dramen, denen auch Kleist eine klare Zuordnung verwehrt, in dem er sie als Drama oder Schauspiel untertitelt.



## Bibliographie

1. Dunz-Wolff, Günter: http://kleist-digital.de/. Digitale, textkritische Edition sämlicher Werke und Briefe von Kleist (im Entstehen).

Clemen, Wolfgang (1964). Shakespeares Monologe. Kleine Vandenhoeck-Reihe. 198/199. Göttingen.
Dunz-Wolff, Günter: http://kleist-digital.de/. Digitale, textkritische Edition sämlicher Werke und Briefe von Kleist (im Entstehen).
Grussendorf, Hermann (1914). Der Monolog in Drama des Sturms und Drangs [Diss.]. München.
Huersch, Irmgard (1947). Der Monolog im deutschen Drama von Lessing bis Hebbel. Winterthur.
Leo, Friedrich (1908). Der Monolog im Drama. Ein Beitrag zur griechisch-römischen Poetik. Berlin.
Lott, Bernhard (1909). Der Monolog im englischen Drama vor Shakespeare [Diss.]. Greifswald.
Schabert, Ina (Hg.) (2009):Shakespeare-Handbuch. Die Zeit, der Mensch, das Werk, die Nachwelt. (5., durchges. und erg. Aufl.) Stuttgart.
Schmidt, Jochen (2003): Heinrich von Kleist. Die Dramen und Erzählungen in ihrer Epoche. Darmstadt.
Spearman, Charles (1904): "The proof and measurement of association between two things". American Journal of Psychology. **15**: 72–101.
Theisen, Bianca (1999): „Der Bewunderer Shakespears. Kleists Skeptizismus“. Kleist-Jahrbuch: 87–108.


## Technical Appendix


### Figure Speech Statistics

```R
library(DramaAnalysis)
library(jsonlite)

t <- load.text(c("vndf.0", "r0px.0", "rksp.0"),
               tokens = TRUE)
t <- limit.figures.by.rank(t)

fstat <- figure.statistics(t, names=TRUE)

mat <- matrix(data=c(fstat[,3]),ncol=3)
colnames(mat) <- c(
      "Romeo und Julia (Ü: Schlegel)",
      "Die Familie Schroffenstein",
      "Emilia Galotti")
mat <- apply(mat, 2,
    function(x) {sort(x, decreasing=TRUE)})

# Plotting in R
# create the plot
barplot(mat, beside=FALSE, col=qd.colors, border=NA, ylab = "Tokens")
# add labels to some figures
text(x=c(0.7,0.7,1.9,1.9,3.1),
    y=c(mat[1,1]/2, sum(mat[1,1]+mat[2,1]/2),
        mat[1,2]/2, sum(mat[1:2,2])+mat[3,2]/2,
        sum(mat[1:4,3])+mat[5,3]/2),
    labels=c("Romeo", "Julia", "Ottokar", "Agnes", "Emilia"),
    col=c("white"))


# Export into json (for visualisation above)
ranks <- tapply(fstat$tokens, INDEX=fstat$drama, FUN = rank)
for (i in seq(1:10)) {print(toJSON(fstat[fstat$rank==i,1:3]))}
# copy-paste and do some manual editing (adding commas etc.)
```

### Utterance Length Variation

```R
library(DramaAnalysis)
library(jsonlite)

id <- "vndf.0"

text <- load.text(c(id), tokens=TRUE)
text <- limit.figures.by.rank(text)
ustat <- utterance_statistics(text, num.figures = F)

# Plotting in R
boxplot(ustat$utterance_length ~ ustat$figure,
          col=qd.colors, las=2,frame=F,
          main=paste("Figure Utterances"))

# Export to json
bp <- tapply(ustat$utterance_length, INDEX = ustat$figure, FUN = function(x) {boxplot.stats(x)})
toJSON(bp)

```
