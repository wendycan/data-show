areas = [
  '移动互联网',
  '电子商务',
  'SNS社交网络',
  '广告营销',
  '搜索引擎',
  '游戏动漫',
  '电子硬件',
  '媒体资讯',
  '多媒体娱乐工具',
  '软件消费',
  '生活金融服务',
  '医疗健康',
  '企业服务',
  '旅游户外',
  '房产酒店',
  '文化艺术体育',
  '教育培训',
  '汽车交通',
  '法律法务',
  '其他'
]

statByTimesLines = (records)->
  results = []
  data = []
  for area in areas
    r = []
    r[0] = area
    r[1] = []
    results.push r
    data.push r
  for d in records
    index = areas.indexOf(d.area)
    if index >= 0
      results[index][1].push d.date
  for r,i in results
    data[i][1] = statByMonth(r)
  data

statByMonth = (records)->
  data = bubbleSort(records[1])
  labels = []
  results = []
  for d in data
    index = labels.indexOf(d)
    if index >= 0
      if results[index]
        results[index][1] += 1
    else
      labels.push d
      results.push [d,1]
  results

bubbleSort = (list) ->
  anySwaps = false
  swapPass = ->
      for r in [0..list.length-2]
          if list[r] > list[r+1]
              anySwaps = true
              [list[r], list[r+1]] = [list[r+1], list[r]]
  swapPass()
  while anySwaps
      anySwaps = false
      swapPass()
  list

renderStatTimesLines = (data)->
  results = statByTimesLines(data.investevents)
  series = []
  for r in results
    t = {}
    t.name = r[0]
    t.data = r[1]
    series.push t
  $('#lines-times-content').highcharts({
    title:
      text: '公司融资记录'
    chart:
      zoomType: 'xy'
    xAxis: {
      type: 'datetime',
      title: {
          text: '时间'
      }
    }
    yAxis: {
      title:
        text: '数量'
    }
    credits:
      enabled: false
    plotOptions:
      line:
        dataLabels:
          enabled: true
    series: series
  })

$(document).ready ->
  $.get('/investevents/data').done (data)->
    $('#content').html $('#t-lines-times').html()
    renderStatTimesLines(data)

    $('#times').click ->
      $('#content').html $('#t-lines-times').html()
      renderStatTimesLines(data)
