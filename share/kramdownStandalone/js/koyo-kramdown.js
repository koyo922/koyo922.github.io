function async(u, c) {
	var d = document, t = 'script',
		o = d.createElement(t),
		s = d.getElementsByTagName(t)[0];
	o.src = u;
	if (c) {
		o.addEventListener('load', function (e) { c(null, e); }, false);
	}
	s.parentNode.insertBefore(o, s);
}

async("http://cdn.bootcss.com/anchor-js/1.1.1/anchor.min.js",function(){
	anchors.options = {
		visible: 'always',
		placement: 'right',
		icon: '#'
	};
	anchors.add().remove('.intro-header h1').remove('.subheading').remove('.sidebar-container h5');
})
