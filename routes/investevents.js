var express = require('express');
var sqlite3 = require("sqlite3").verbose();
var router = express.Router();

var file = "itjuzi";
/* GET users listing. */
router.get('/data', function(req, res) {
  var db = new sqlite3.Database(file);
  var investevents = [];
  db.serialize(function() {
    db.each("SELECT * FROM investevents", function(err, row) {
      investevents.push({
        id: row.itid,
        money: row.money,
        date: (new Date(row.date.replace('年','.').replace('月','.').replace('日','.'))).valueOf(),
        area: row.area,
        turn: row.turn
      });
    }, function() {
        // All done fetching records, render response
        res.json({investevents: investevents});
        // res.render("Companies", {title: 'companies', companies: companies.slice(0,10)});
    });
  });
});

module.exports = router;
