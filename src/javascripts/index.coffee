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


statByTimes = (records)->


statBySum = (records)->

renderStatAreas = (data)->
  data_years = stateByYear(data.companies)
  for data_year, i in data_years
    results = statByArea(data_year)
    $('#areas-'+i).highcharts
      title:
        text: "#{data_year.name}年"
      series: [
        type: 'pie'
        name: 'Browser share'
        data: results
      ]

$(document).ready ->
  $.get('/companies').done (data)->
    $('#content').html $('#t-areas').html()
    renderStatAreas(data)

    # event
    $('#areas').click ->
      $('#content').html $('#t-areas').html()
      renderStatAreas(data)

    $('#locations').click ->
      $('#content').html $('#t-locations').html()

    $('#times').click ->
      $('#content').html $('#t-times').html()

    $('#sum').click ->
      $('#content').html $('#t-sum').html()
