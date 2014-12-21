How left does Switzerland vote?
========================================================
author: Leo Buettiker
date: Sun Dec 21 20:34:30 2014

Project explanation
========================================================
transition: rotate

[Switzerland](http://en.wikipedia.org/wiki/Switzerland) is a country in the middle of europe. It's seperated into 26 [cantons](http://en.wikipedia.org/wiki/Cantons_of_Switzerland). In [Switzerland](http://en.wikipedia.org/wiki/Switzerland) the [4 official languages](http://en.wikipedia.org/wiki/Switzerland#Languages) are German, French, Italien and Romansh.

- The two main languages are German and French
- People are allowed to [vote on political topics](http://en.wikipedia.org/wiki/Switzerland#Direct_democracy) on a regular basis
- Most votes can be categorized into a left or right wing topic
- The big left wing party is the [Social Democratic Party of Switzerland (SP)](http://en.wikipedia.org/wiki/Social_Democratic_Party_of_Switzerland), the big right wing party is the [Swiss People's Party (SVP)](http://en.wikipedia.org/wiki/Swiss_People%27s_Party)


Hypotesis
========================================================
People in french speaking cantons vote more left than german speaking.

<!-- GeoChart generated in R 3.1.0 by googleVis 0.5.6 package -->
<!-- Sun Dec 21 20:34:31 2014 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataGeoChartID276c4c642606 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 "Total",
"Tessin - Italian",
1 
],
[
 "Zürich",
"Zürich - German",
3 
],
[
 "Bern",
"Bern - German",
3 
],
[
 "Luzern",
"Luzern - German",
3 
],
[
 "Uri",
"Uri - German",
3 
],
[
 "Schwyz",
"Schwyz - German",
3 
],
[
 "Obwalden",
"Obwalden - German",
3 
],
[
 "Nidwalden",
"Nidwalden - German",
3 
],
[
 "Glarus",
"Glarus - German",
3 
],
[
 "Zug",
"Zug - German",
3 
],
[
 "Freiburg",
"Freiburg - French",
2 
],
[
 "Solothurn",
"Solothurn - German",
3 
],
[
 "Basel-Stadt",
"Basel-Stadt - German",
3 
],
[
 "Basel-Landschaft",
"Basel-Landschaft - German",
3 
],
[
 "Schaffhausen",
"Schaffhausen - German",
3 
],
[
 "Appenzell Ausserrhoden",
"Appenzell Ausserrhoden - German",
3 
],
[
 "Appenzell Innerrhoden",
"Appenzell Innerrhoden - German",
3 
],
[
 "St. Gallen",
"St. Gallen - German",
3 
],
[
 "Graubünden",
"Graubünden - German",
3 
],
[
 "Aargau",
"Aargau - German",
3 
],
[
 "Thurgau",
"Thurgau - German",
3 
],
[
 "Tessin",
"Tessin - Italian",
1 
],
[
 "Waadt",
"Waadt - French",
2 
],
[
 "Wallis",
"Wallis - German",
3 
],
[
 "Neuenburg",
"Neuenburg - French",
2 
],
[
 "Genf",
"Genf - French",
2 
],
[
 "Jura",
"Jura - French",
2 
] 
];
data.addColumn('string','kanton');
data.addColumn('string','text');
data.addColumn('number','col');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartGeoChartID276c4c642606() {
var data = gvisDataGeoChartID276c4c642606();
var options = {};
options["width"] =    600;
options["height"] =    400;
options["resolution"] = "provinces";
options["region"] = "CH";
options["colors"] = ['blue', 'red', 'green'];

    var chart = new google.visualization.GeoChart(
    document.getElementById('GeoChartID276c4c642606')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "geochart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartGeoChartID276c4c642606);
})();
function displayChartGeoChartID276c4c642606() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartGeoChartID276c4c642606"></script>
 
<!-- divChart -->
  
<div id="GeoChartID276c4c642606" 
  style="width: 600; height: 400;">
</div>

Methodology
========================================================
- The number used is how many percent points a canton deviate from the mean 
- A vote is used for the mean if the main left wing party (SP) disagrees with the main right wing party (SVP).
- If the left wing party votes yes, the data of the vote is considered unmutated.
- If the right wing party votes yes the data is inverted (multiplied with -1)
- The application is implemented with [shiny](http://shiny.rstudio.com/), the maps are created with [googleVis](http://cran.r-project.org/web/packages/googleVis/index.html) and the data are preprocessed with [readODS](http://cran.r-project.org/web/packages/readODS/index.html) and [XLConnect](http://cran.r-project.org/web/packages/XLConnect/index.html)

Conclusion
=========================================================
- To no surprise the thesis holds mostly true
   - except for Zurich and both Basels which vote also left
- Bellow you can see the indication of "leftness" for all cantons

<!-- GeoChart generated in R 3.1.0 by googleVis 0.5.6 package -->
<!-- Sun Dec 21 20:34:31 2014 -->


<!-- jsHeader -->
<script type="text/javascript">
 
// jsData 
function gvisDataGeoChartID276c762158c5 () {
var data = new google.visualization.DataTable();
var datajson =
[
 [
 "Total",
0 
],
[
 "Zürich",
0.4680412371 
],
[
 "Bern",
0.8257731959 
],
[
 "Luzern",
-3.855670103 
],
[
 "Uri",
-5.430927835 
],
[
 "Schwyz",
-9.14742268 
],
[
 "Obwalden",
-7.010309278 
],
[
 "Nidwalden",
-7.626804124 
],
[
 "Glarus",
-5.741237113 
],
[
 "Zug",
-3.859793814 
],
[
 "Freiburg",
2.562886598 
],
[
 "Solothurn",
-2.416494845 
],
[
 "Basel-Stadt",
6.365979381 
],
[
 "Basel-Landschaft",
0.418556701 
],
[
 "Schaffhausen",
-2.073195876 
],
[
 "Appenzell Ausserrhoden",
-4.473195876 
],
[
 "Appenzell Innerrhoden",
-9.811340206 
],
[
 "St. Gallen",
-4.982474227 
],
[
 "Graubünden",
-1.691752577 
],
[
 "Aargau",
-4.82371134 
],
[
 "Thurgau",
-5.939175258 
],
[
 "Tessin",
0.5783505155 
],
[
 "Waadt",
6.734020619 
],
[
 "Wallis",
-0.1103092784 
],
[
 "Neuenburg",
7.610309278 
],
[
 "Genf",
9.164948454 
],
[
 "Jura",
8.808247423 
] 
];
data.addColumn('string','Kanton');
data.addColumn('number','LeftVotes');
data.addRows(datajson);
return(data);
}
 
// jsDrawChart
function drawChartGeoChartID276c762158c5() {
var data = gvisDataGeoChartID276c762158c5();
var options = {};
options["width"] =    600;
options["height"] =    400;
options["resolution"] = "provinces";
options["region"] = "CH";
options["colorAxis"] = {colors: ['red', 'blue']};

    var chart = new google.visualization.GeoChart(
    document.getElementById('GeoChartID276c762158c5')
    );
    chart.draw(data,options);
    

}
  
 
// jsDisplayChart
(function() {
var pkgs = window.__gvisPackages = window.__gvisPackages || [];
var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
var chartid = "geochart";
  
// Manually see if chartid is in pkgs (not all browsers support Array.indexOf)
var i, newPackage = true;
for (i = 0; newPackage && i < pkgs.length; i++) {
if (pkgs[i] === chartid)
newPackage = false;
}
if (newPackage)
  pkgs.push(chartid);
  
// Add the drawChart function to the global list of callbacks
callbacks.push(drawChartGeoChartID276c762158c5);
})();
function displayChartGeoChartID276c762158c5() {
  var pkgs = window.__gvisPackages = window.__gvisPackages || [];
  var callbacks = window.__gvisCallbacks = window.__gvisCallbacks || [];
  window.clearTimeout(window.__gvisLoad);
  // The timeout is set to 100 because otherwise the container div we are
  // targeting might not be part of the document yet
  window.__gvisLoad = setTimeout(function() {
  var pkgCount = pkgs.length;
  google.load("visualization", "1", { packages:pkgs, callback: function() {
  if (pkgCount != pkgs.length) {
  // Race condition where another setTimeout call snuck in after us; if
  // that call added a package, we must not shift its callback
  return;
}
while (callbacks.length > 0)
callbacks.shift()();
} });
}, 100);
}
 
// jsFooter
</script>
 
<!-- jsChart -->  
<script type="text/javascript" src="https://www.google.com/jsapi?callback=displayChartGeoChartID276c762158c5"></script>
 
<!-- divChart -->
  
<div id="GeoChartID276c762158c5" 
  style="width: 600; height: 400;">
</div>
