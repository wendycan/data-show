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
            "hc-key": "tw-ph",
            "value": 0
        },
        {
            "hc-key": "cn-sh",
            "value": 1
        },
        {
            "hc-key": "tw-km",
            "value": 2
        },
        {
            "hc-key": "cn-zj",
            "value": 3
        },
        {
            "hc-key": "tw-lk",
            "value": 4
        },
        {
            "hc-key": "cn-3664",
            "value": 5
        },
        {
            "hc-key": "cn-3681",
            "value": 6
        },
        {
            "hc-key": "tw-tw",
            "value": 7
        },
        {
            "hc-key": "tw-cs",
            "value": 8
        },
        {
            "hc-key": "cn-gs",
            "value": 9
        },
        {
            "hc-key": "cn-6657",
            "value": 10
        },
        {
            "hc-key": "cn-6663",
            "value": 11
        },
        {
            "hc-key": "cn-6665",
            "value": 12
        },
        {
            "hc-key": "cn-6666",
            "value": 13
        },
        {
            "hc-key": "cn-6667",
            "value": 14
        },
        {
            "hc-key": "cn-6669",
            "value": 15
        },
        {
            "hc-key": "cn-6670",
            "value": 16
        },
        {
            "hc-key": "cn-6671",
            "value": 17
        },
        {
            "hc-key": "tw-kh",
            "value": 18
        },
        {
            "hc-key": "tw-hs",
            "value": 19
        },
        {
            "hc-key": "tw-hh",
            "value": 20
        },
        {
            "hc-key": "tw-cl",
            "value": 21
        },
        {
            "hc-key": "tw-ml",
            "value": 22
        },
        {
            "hc-key": "cn-nx",
            "value": 23
        },
        {
            "hc-key": "cn-sa",
            "value": 24
        },
        {
            "hc-key": "tw-ty",
            "value": 25
        },
        {
            "hc-key": "cn-3682",
            "value": 26
        },
        {
            "hc-key": "tw-cg",
            "value": 27
        },
        {
            "hc-key": "cn-6655",
            "value": 28
        },
        {
            "hc-key": "cn-ah",
            "value": 29
        },
        {
            "hc-key": "cn-hu",
            "value": 30
        },
        {
            "hc-key": "tw-hl",
            "value": 31
        },
        {
            "hc-key": "tw-nt",
            "value": 32
        },
        {
            "hc-key": "tw-th",
            "value": 33
        },
        {
            "hc-key": "cn-6656",
            "value": 34
        },
        {
            "hc-key": "cn-6658",
            "value": 35
        },
        {
            "hc-key": "cn-6659",
            "value": 36
        },
        {
            "hc-key": "tw-yl",
            "value": 37
        },
        {
            "hc-key": "cn-6660",
            "value": 38
        },
        {
            "hc-key": "cn-6661",
            "value": 39
        },
        {
            "hc-key": "cn-6662",
            "value": 40
        },
        {
            "hc-key": "cn-6664",
            "value": 41
        },
        {
            "hc-key": "cn-6668",
            "value": 42
        },
        {
            "hc-key": "tw-pt",
            "value": 43
        },
        {
            "hc-key": "tw-tt",
            "value": 44
        },
        {
            "hc-key": "cn-gd",
            "value": 45
        },
        {
            "hc-key": "cn-fj",
            "value": 46
        },
        {
            "hc-key": "tw-tn",
            "value": 47
        },
        {
            "hc-key": "cn-bj",
            "value": 48
        },
        {
            "hc-key": "cn-hb",
            "value": 49
        },
        {
            "hc-key": "tw-il",
            "value": 50
        },
        {
            "hc-key": "tw-tp",
            "value": 51
        },
        {
            "hc-key": "cn-sd",
            "value": 52
        },
        {
            "hc-key": "tw-ch",
            "value": 53
        },
        {
            "hc-key": "cn-tj",
            "value": 54
        },
        {
            "hc-key": "cn-js",
            "value": 55
        },
        {
            "hc-key": "cn-ha",
            "value": 56
        },
        {
            "hc-key": "cn-qh",
            "value": 57
        },
        {
            "hc-key": "cn-jl",
            "value": 58
        },
        {
            "hc-key": "cn-xz",
            "value": 59
        },
        {
            "hc-key": "cn-xj",
            "value": 60
        },
        {
            "hc-key": "cn-he",
            "value": 61
        },
        {
            "hc-key": "cn-nm",
            "value": 62
        },
        {
            "hc-key": "cn-hl",
            "value": 63
        },
        {
            "hc-key": "cn-yn",
            "value": 64
        },
        {
            "hc-key": "cn-gx",
            "value": 65
        },
        {
            "hc-key": "cn-ln",
            "value": 66
        },
        {
            "hc-key": "cn-sc",
            "value": 67
        },
        {
            "hc-key": "cn-cq",
            "value": 68
        },
        {
            "hc-key": "cn-gz",
            "value": 69
        },
        {
            "hc-key": "cn-hn",
            "value": 70
        },
        {
            "hc-key": "cn-sx",
            "value": 71
        },
        {
            "hc-key": "cn-jx",
            "value": 72
        }
    ]
  $('#locations-0').highcharts('Map', {
    colorAxis: {
      min: 0
    }
    series : [
      data : data
      mapData: Highcharts.maps['countries/cn/custom/cn-all-sar-taiwan']
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
