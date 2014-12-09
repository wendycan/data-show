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
      companies.push({title: row.name, date: row.date, url: row.url});
    }, function() {
        // All done fetching records, render response
        // res.render("dynamic", {title: "Dynamic", posts: posts})
        res.send(companies);
    });
  });
});

module.exports = router;
