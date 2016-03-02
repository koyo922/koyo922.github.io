// responsive tables
$(document).ready(function() {
	var h2 = $("div.footnotes").prev();
	if ($.inArray(h2.prop('tagName'),['H2','H3'])>-1 && h2.text()=='脚注'){
		h2.css('margin-top','5em');
	}
});
