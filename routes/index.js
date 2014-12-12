var express = require('express');
var sqlite3 = require("sqlite3").verbose();
var router = express.Router();

var file = "itjuzi";

/* GET users listing. */
router.get('/', function(req, res) {
  res.render("Index", {title: 'companies'});
});

router.get('/investevents', function(req, res) {
  res.render("Investevents", {title: 'investevents'});
});

router.get('/companies', function(req, res) {
  var db = new sqlite3.Database(file);
  var companies = [];
  db.serialize(function() {
    db.each("SELECT * FROM companies", function(err, row) {
      companies.push({
        id: row.itid,
        name: row.name,
        date: (new Date(row.date.replace('年','-').replace('月',''))).valueOf(),
        url: row.url,
        location: row.location,
        state: row.state,
        area: row.area,
        stage: row.stage,
        tags: row.tags,
        discr: row.discr
      });
    }, function() {
        res.render("Companies", {title: 'companies', companies: companies.slice(0,100)});
    });
  });
});

module.exports = router;
