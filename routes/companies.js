var express = require('express');
var sqlite3 = require("sqlite3").verbose();
var router = express.Router();

var file = "itjuzi";
/* GET users listing. */
router.get('/data', function(req, res) {
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
        // All done fetching records, render response
        data = [];
        for (var i = 0; i < companies.length; i++) {
          if(companies[i].date >= 1262275200000) {
            data.push(companies[i]);
          }
        }
        res.json({companies: data});
        // res.render("Companies", {title: 'companies', companies: companies.slice(0,10)});
    });
  });
});

module.exports = router;
