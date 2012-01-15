jQuery ->

  processChart = (element) ->
    (data) ->
      data['chart']['renderTo'] = element.attr('id')
      new Highcharts.Chart(data)

  addChart = (index, el) ->
    element = $(el)
    url = element.attr('data-chart')
    jQuery.get(url, processChart(element), 'json')

  jQuery("*[data-chart]").each(addChart)
