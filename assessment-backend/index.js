var express = require("express");

var app = express();
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
  });
app.get("/", (req, res, next) => {
    res.json([{"id":"Hello Pirelli!"}]);
   });
app.listen(4000, () => {
 console.log("Server running on port 4000");
});
