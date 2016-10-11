var qd_colors = ["#D92120","#E66B2D","#E0A239","#C3BA45","#99BD5C","#70B484","#519CB8","#416FB8","#43328D","#781C81"];

$(document).ready(function($) {
	$('.hslider').unslider({
    arrows: false,
    animateHeight: true
  });

  if ($(window).width() > 500) {
    // $('.sidebar-toggle').click();
  }
});

function render_table(container, data, columns) {
  $(container).DataTable({
    columns: columns,
    data: data,
    pageLength: 5,
    lengthMenu: [ 5, 10, 20, 50, 100 ],
    language: {
    "sEmptyTable":      "Keine Daten in der Tabelle vorhanden",
    "sInfo":            "_START_ bis _END_ von _TOTAL_ Einträgen",
    "sInfoEmpty":       "0 bis 0 von 0 Einträgen",
    "sInfoFiltered":    "(gefiltert von _MAX_ Einträgen)",
    "sInfoPostFix":     "",
    "sInfoThousands":   ".",
    "sLengthMenu":      "_MENU_ Einträge anzeigen",
    "sLoadingRecords":  "Wird geladen...",
    "sProcessing":      "Bitte warten...",
    "sSearch":          "Suchen",
    "sZeroRecords":     "Keine Einträge vorhanden.",
    "oPaginate": {
        "sFirst":       "Erste",
        "sPrevious":    "Zurück",
        "sNext":        "Nächste",
        "sLast":        "Letzte"
    },
    "oAria": {
        "sSortAscending":  ": aktivieren, um Spalte aufsteigend zu sortieren",
        "sSortDescending": ": aktivieren, um Spalte absteigend zu sortieren"
    }
}
  });
}

function render_spiderweb_table(container, data) {

  var cat = Object.keys(data[0]).filter(function(a) { return a != "drama";});

  var dt = $(container).DataTable({
    columns: cat.map(function(cur, ind, arr) {
      return {title: cur, data: cur};
    }),
    pageLength: 5,
    lengthMenu: [ 5, 10, 20, 50, 100 ],
    language: {
    "sEmptyTable":      "Keine Daten in der Tabelle vorhanden",
    "sInfo":            "_START_ bis _END_ von _TOTAL_ Einträgen",
    "sInfoEmpty":       "0 bis 0 von 0 Einträgen",
    "sInfoFiltered":    "(gefiltert von _MAX_ Einträgen)",
    "sInfoPostFix":     "",
    "sInfoThousands":   ".",
    "sLengthMenu":      "_MENU_ Einträge anzeigen",
    "sLoadingRecords":  "Wird geladen...",
    "sProcessing":      "Bitte warten...",
    "sSearch":          "Suchen",
    "sZeroRecords":     "Keine Einträge vorhanden.",
    "oPaginate": {
        "sFirst":       "Erste",
        "sPrevious":    "Zurück",
        "sNext":        "Nächste",
        "sLast":        "Letzte"
    },
    "oAria": {
        "sSortAscending":  ": aktivieren, um Spalte aufsteigend zu sortieren",
        "sSortDescending": ": aktivieren, um Spalte absteigend zu sortieren"
    }
}
  });

  dt.rows.add(data).draw();
}

function render_spiderweb(container, data, initially_visible) {

  var cat = Object.keys(data[0]).filter(function(a) { return a!="figure" && a != "drama";});
  cat = cat.sort();
  var s = data.sort(function(a,b) {return a.figure.localeCompare(b.figure);}).map(function(cur, a,b) {
    return {
      name: cur.figure,
      visible: initially_visible.indexOf(cur.figure)>=0,
      data: cat.map(function(cat, a, b) {
        return cur[cat];
      })
    };
  });
  console.log(s);


  $(container).highcharts({
    chart: {
      polar: true,
      type: 'line',
      className: 'qd-spiderweb'
    },
    plotOptions: {
      line: {
        pointPlacement: 'on'
      }
    },
    title: {
      text:null
    },
    colors: qd_colors,
    yAxis: {
      gridLineInterpolation: 'polygon',
    },
    xAxis: {
      lineWidth: 0,
      categories: cat,
    },
    series: s
  });
}

function render_boxplots(container, data) {
  var cat = Object.keys(data).sort();

  $(function () { $(container).highcharts({
    chart: {
      type: 'boxplot'
    },
    title: {
      text: null
    },
    yAxis: {
      min:0
    },
    xAxis: {
      categories: cat,
      title: {
        enabled: false,
        text: "Figure"
      }
    },
    legend: {
      enabled: false
    },
    series: cat.map(function(cur, index, c) {
      return {
        name: cur,
        type: 'scatter',
        marker: {
          symbol:"circle",
          lineWidth:1
        },
        tooltip:{
          pointFormat: "{point.y}",
          headerFormat: null
        },
        data: data[cur].out.map(function(c, d, e) {
          return [index,c];
        })
      };
    }).concat([
      {
        name: "Monologe",
        data: cat.map(function(cur, a, b) {
          return data[cur].stats;
        })
      }])
  });
});
}

function render_stacked_figure_statistics(container, data, dramanames) {
  $(function () {
      $(container).highcharts({
          chart: {
              type: 'column',
              className: 'qd-stacked-figure-statistics'
          },
          title: {
              text: ''
          },
          xAxis: {
              categories: dramanames
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
          series: data.map(function(cur, a, b) {
  					return {data:cur.map(function(cur2, ind2, _) {return {y:cur2.tokens, name:cur2.figure};})};
  				})
      });
  });
}
