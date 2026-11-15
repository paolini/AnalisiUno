// statistiche di visita, come in docs/index.html: Google Analytics e Matomo

// Google Analytics
window.dataLayer = window.dataLayer || [];
function gtag() { dataLayer.push(arguments); }
gtag('js', new Date());
gtag('config', 'G-VRBT3T3Q7E');

// Matomo
var _paq = window._paq = window._paq || [];
_paq.push(['trackPageView']);
_paq.push(['enableLinkTracking']);

(function() {
  var d = document, s = d.getElementsByTagName('script')[0];
  function load(src) {
    var g = d.createElement('script');
    g.async = true; g.src = src; s.parentNode.insertBefore(g, s);
  }
  load('https://www.googletagmanager.com/gtag/js?id=G-VRBT3T3Q7E');
  var u = "//matomo.matb.it/";
  _paq.push(['setTrackerUrl', u + 'matomo.php']);
  _paq.push(['setSiteId', '5']);
  load(u + 'matomo.js');
})();
