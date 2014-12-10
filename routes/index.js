var express = require('express');
var sqlite3 = require("sqlite3").verbose();
var router = express.Router();

var file = "itjuzi";

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
        res.render("Index", {title: 'companies'});
    });
  });
});

module.exports = router;
