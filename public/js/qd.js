var qd_colors = ["#D92120","#E66B2D","#E0A239","#C3BA45","#99BD5C","#70B484","#519CB8","#416FB8","#43328D","#781C81"];


function render_boxplots(container, data) {
  var cat = Object.keys(data);

  $(function () { $(container).highcharts({
    chart: {
      type: 'boxplot'
    },
    title: {
      text: null
    },
    labels: {
      style: {
        color: "#404040"
      }
    },
    yAxis: {
      lineColor: "#404040",
      min:0
    },
    xAxis: {
      categories: cat,
      title: {
        enabled: false,
        text: "Figure"
      },
      labels: {
        style: {
          color: "#404040"
        }
      },
      lineColor: "#404040",
      tickColor: "#404040"
    },
    legend: {
      enabled: false
    },
    series: [
      {
        color: "#404040",
        name: "Monologe",
        data: cat.map(function(cur, a, b) {
          return {
            low:data[cur].stats[0],
            q1:data[cur].stats[1],
            median:data[cur].stats[2],
            q3:data[cur].stats[3],
            high:data[cur].stats[4],
            color:qd_colors[9-a] };
        })
      }
    ].concat(cat.map(function(cur, index, c) {
      return {
        color: qd_colors[9-index],
        name: cur,
        type: 'scatter',
        marker: {
          symbol:"circle",
          lineColor: qd_colors[9-index],
          fillColor: "#FFF",
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
    }))
  });
  });
}

function render_stacked_figure_statistics(container, data, dramanames) {
  $(function () {
      $(container).highcharts({
          chart: {
              type: 'column'
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
          series: d.map(function(cur, a, b) {
  					return {data:cur.map(function(cur2, ind2, _) {return {y:cur2.tokens, name:cur2.figure};})};
  				})
      });
  });
}
