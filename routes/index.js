var express = require('express');
var sqlite3 = require("sqlite3").verbose();
var router = express.Router();

var file = "itjuzi";
var areas = [
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
];

var statByArea = function(records){

};

var statByLocation = function(records){

};

var statByTimes = function(records){

};

var statBySum = function(records){

};

/* GET users listing. */
router.get('/', function(req, res) {
  var db = new sqlite3.Database(file);
  var companies = [];
  db.serialize(function() {
    db.each("SELECT * FROM companies", function(err, row) {
      companies.push({
        id: row.itid,
        name: row.name,
        date: row.date.replace('年','-').replace('月',''),
        url: row.url,
        location: row.location,
        state: row.state,
        area: row.area,
        stage: row.stage,
        tags: row.tags,
        discr: row.discr
      });
    }, function() {
        // All done fetching records, render response
        res.render("Index", {title: 'companies', companies: companies});
    });
  });
});

module.exports = router;
