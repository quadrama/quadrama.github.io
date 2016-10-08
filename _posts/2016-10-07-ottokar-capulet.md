---
layout: post
title: "Ottokar Capulet und Julia Schroffenstein"
subtitle: Liebeskonflikte und Gattungskontexte bei Kleist und Shakespeare
---
<div id="container">bla</div>
Figure 1: Figure Speech Statistics

<script src="{{ site.baseurl }}/public/js/jquery-3.1.1.min.js"></script>
<script src="{{ site.baseurl }}/public/js/hc/highcharts.js"></script>
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

$(function () {
    $('#container').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: ["Romeo und Julia (Ü: Schlegel)","Die Familie Schroffenstein","Emilia Galotti"]
        },
        yAxis: {
            min: 0,
            title: {
                text: 'Spoken tokens'
            },
            stackLabels: {
                enabled: false,
                style: {
                    fontWeight: 'bold',
                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
                }
            }
        },
				colors: ["#D92120","#E66B2D","#E0A239","#C3BA45","#99BD5C","#70B484","#519CB8","#416FB8","#43328D","#781C81"],
        legend: {enabled:false},
        tooltip: {
						followPointer: true,
            headerFormat: '<b>{point.x}</b><br/>',
            pointFormat: '{point.name}: {point.y}'
        },
        plotOptions: {
            column: {
                stacking: 'normal',
                dataLabels: {
									format:"{point.name}",
                    enabled: false,
                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white'
                }
            }
        },
        series: d.map(function(cur, _, _) {
					return {data:cur.map(function(cur2, ind2, _) {return {y:cur2.tokens, name:cur2.figure}})}
				})
    });
});
</script>

## Appendix

### Figure Speech Statistics

```R
{% include {{ site.baseurl }}/assets/2016-10-07-ottokar-capulet/figure-statistics.R %}
```
