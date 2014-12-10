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

renderStatLocations = (data)->
  data = [
        {
            "hc-key": "cn-3664",
            "value": 0
        },
        {
            "hc-key": "cn-sh",
            "value": 1
        },
        {
            "hc-key": "cn-zj",
            "value": 2
        },
        {
            "hc-key": "cn-ha",
            "value": 3
        },
        {
            "hc-key": "cn-xz",
            "value": 4
        },
        {
            "hc-key": "cn-yn",
            "value": 5
        },
        {
            "hc-key": "cn-ah",
            "value": 6
        },
        {
            "hc-key": "cn-hu",
            "value": 7
        },
        {
            "hc-key": "cn-sa",
            "value": 8
        },
        {
            "hc-key": "cn-cq",
            "value": 9
        },
        {
            "hc-key": "cn-gz",
            "value": 10
        },
        {
            "hc-key": "cn-hn",
            "value": 11
        },
        {
            "hc-key": "cn-sc",
            "value": 12
        },
        {
            "hc-key": "cn-sx",
            "value": 13
        },
        {
            "hc-key": "cn-he",
            "value": 14
        },
        {
            "hc-key": "cn-jx",
            "value": 15
        },
        {
            "hc-key": "cn-nm",
            "value": 16
        },
        {
            "hc-key": "cn-gx",
            "value": 17
        },
        {
            "hc-key": "cn-hl",
            "value": 18
        },
        {
            "hc-key": "cn-fj",
            "value": 19
        },
        {
            "hc-key": "cn-gd",
            "value": 20
        },
        {
            "hc-key": "cn-bj",
            "value": 21
        },
        {
            "hc-key": "cn-hb",
            "value": 22
        },
        {
            "hc-key": "cn-ln",
            "value": 23
        },
        {
            "hc-key": "cn-sd",
            "value": 24
        },
        {
            "hc-key": "cn-tj",
            "value": 25
        },
        {
            "hc-key": "cn-js",
            "value": 26
        },
        {
            "hc-key": "cn-qh",
            "value": 27
        },
        {
            "hc-key": "cn-gs",
            "value": 28
        },
        {
            "hc-key": "cn-xj",
            "value": 29
        },
        {
            "hc-key": "cn-jl",
            "value": 30
        },
        {
            "hc-key": "cn-nx",
            "value": 31
        }
    ]
  $('#locations-0').highcharts('Map', {
    colorAxis: {
      min: 0
    }
    series : [
      data : data
      mapData: Highcharts.maps['countries/cn/cn-all']
      joinBy: 'hc-key'
      name: 'Random data'
      mapNavigation: {
        enabled: true,
        buttonOptions: {
            verticalAlign: 'bottom'
        }
      }
      states: {
        hover: {
            color: '#BADA55'
        }
      }
    ]
  })

$(document).ready ->
  $.get('/companies').done (data)->
    $('#content').html $('#t-areas').html()
    renderStatAreas(data)

    # event
    $('#areas').click ->
      $('#content').html $('#t-areas').html()
      console.log 'here'
      renderStatAreas(data)

    $('#locations').click ->
      $('#content').html $('#t-locations').html()
      renderStatLocations(data)

    $('#times').click ->
      $('#content').html $('#t-times').html()

    $('#sum').click ->
      $('#content').html $('#t-sum').html()
