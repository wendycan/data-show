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
locations = [
  '北京',
  '天津',
  '河北',
  '山西',
  '辽宁',
  '吉林',
  '黑龙江',
  '上海',
  '江苏',
  '浙江',
  '安徽',
  '福建',
  '江西',
  '山东',
  '河南',
  '湖北',
  '湖南',
  '广东',
  '广西',
  '海南',
  '重庆',
  '四川',
  '贵州',
  '云南',
  '西藏',
  '陕西',
  '甘肃',
  '青海',
  '宁夏',
  '新疆',
  '内蒙古'
]

statByArea = (records)->
  results = []
  for area in areas
    r = []
    r[0] = area
    r[1] = 0
    results.push r
  data = records.data
  for d in data
    index = areas.indexOf(d.area)
    if index >= 0
      results[index][1] += 1
  results

statByAreaLines = (records)->
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

statByLocationsLines = (records)->
  results = []
  data = []
  for location in locations
    r = []
    r[0] = location
    r[1] = []
    results.push r
    data.push r
  for d in records
    index = locations.indexOf(d.location)
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


stateByYear = (records)->
  years = ['2010', '2011', '2012', '2013', '2014']
  limit = [1262275200000, 1293811200000, 1325347200000, 1356969600000, 1388505600000]
  results = [{name: '2010', data: []}, {name: '2011', data: []}, {name: '2012', data: []}, {name: '2013', data: []}, {name: '2014', data: []}]
  for r in records
    if r.date > limit[4]
      results[4].data.push r
    else if r.date > limit[3]
      results[3].data.push r
    else if r.date > limit[2]
      results[2].data.push r
    else if r.date > limit[1]
      results[1].data.push r
    else if r.date > limit[0]
      results[0].data.push r
  results

statByLocation = (records)->
  results = []
  for location in locations
    r = {}
    r.name = location
    r.value = 0
    results.push r
  data = records.data
  for d in data
    index = locations.indexOf(d.location)
    if index >= 0
      results[index].value += 1
  results

renderStatAreas = (data)->
  data_years = stateByYear(data.companies)
  for data_year, i in data_years
    results = statByArea(data_year)
    $('#areas-' + i).highcharts
      title:
        text: "#{data_year.name}年"
      series: [
        type: 'pie'
        name: 'Browser share'
        data: results
      ]


renderStatAreasLines = (data)->
  results = statByAreaLines(data.companies)
  series = []
  for r in results
    t = {}
    t.name = r[0]
    t.data = r[1]
    series.push t
  $('#lines-areas-content').highcharts({
    chart:
      zoomType: 'xy'
    title:
      text: '近五年来公司领域分布'
    xAxis: {
      type: 'datetime',
      title: {
          text: 'Date'
      }
    }
    series: series
    credits:
      enabled: false
  })

renderStatLocationsLines = (data)->
  results = statByLocationsLines(data.companies)
  series = []
  for r in results
    t = {}
    t.name = r[0]
    t.data = r[1]
    series.push t
  $('#lines-locations-content').highcharts({
    chart:
      zoomType: 'xy'
    title:
      text: '近五年来公司地域分布'
    xAxis: {
      type: 'datetime',
      title: {
          text: 'Date'
      }
    }
    credits:
      enabled: false
    series: series
  })

renderStatLocations = (data)->
  data_years = stateByYear(data.companies)
  for data_year, i in data_years
    results = statByLocation(data_year)
    $('#locations-' + i).highcharts('Map', {
      chart: {
        width: '800'
        height: '400'
      }
      colorAxis: {
        min: 0
        minColor: '#FFFFFF'
        maxColor: '#FF6722'
      }
      title: {
        text: "#{data_year.name}年"
      }
      series : [
        data : results
        mapData: Highcharts.maps['countries/cn/custom/cn-all-sar-taiwan']
        joinBy: 'name'
        name: '公司数量'
        states: {
          hover: {
              color: '#6EE5D8'
          }
        }
      ]
      credits:
        enabled: false
    })

$(document).ready ->
  $.get('/companies/data').done (data)->
    $('#content').html $('#t-lines-areas').html()
    renderStatAreasLines(data)

    # areas event
    $('#areas').click ->
      $('.button').removeClass('active')
      $('#details-areas').addClass('active')
      $('#areas').parent().find('.sub-nav').toggle('slow')
      $('#content').html $('#t-lines-areas').html()
      renderStatAreasLines(data)

    $('#details-areas').click ->
      $('.button').removeClass('active')
      $('#details-areas').addClass('active')
      $('#content').html $('#t-details-areas').html()
      renderStatAreas(data)

    $('#lines-areas').click ->
      $('.button').removeClass('active')
      $('#lines-areas').addClass('active')
      $('#content').html $('#t-lines-areas').html()
      renderStatAreasLines(data)

    # locations event
    $('#locations').click ->
      $('.button').removeClass('active')
      $('#lines-locations').addClass('active')

      $('#locations').parent().find('.sub-nav').toggle('slow')
      $('#content').html $('#t-lines-locations').html()
      renderStatLocationsLines(data)

    $('#lines-locations').click ->
      $('.button').removeClass('active')
      $('#lines-locations').addClass('active')

      $('#content').html $('#t-lines-locations').html()
      renderStatLocationsLines(data)

    $('#details-locations').click ->
      $('.button').removeClass('active')
      $('#details-locations').addClass('active')
      $('#content').html $('#t-locations').html()
      renderStatLocations(data)

