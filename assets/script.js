/* unorphan */
var els = document.querySelectorAll('p,h1,h2,h3,h4,h5,h6');
for (var i = 0, len = els.length; i < len; i++) {
  var el = els[i];
  var last = el.lastChild;

  if (last && last.nodeType === 3) {
    last.nodeValue = last.nodeValue.replace(/\s+([^\s]+\s*)$/g, '\xA0$1');
  }
}

/* loaded */
document.documentElement.className += ' loaded';
