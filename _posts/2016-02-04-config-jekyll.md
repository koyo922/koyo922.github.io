---
title: "Jekyll 折腾记录"
date: 2016-02-04 22:20:00
tags: Jekyll config Markdown
description: 花了两天时间，总算用Jekyll搭建好了一个个人博客；本地和Github都能用；代码高亮，有行号，支持高级Markdown扩展。
---

<style>
.koyo-li {
	margin-top: 2em;
}
</style>

{::options parse_block_html="true" /}

## 目录
* TOC
{:toc}

## 动机
1. 整理自己的技术经验（每次搭建/配置/调试都很费劲，总结一下方便以后看）
2. 提供一个让自己坚持使用Github的理由

## 步骤

##### 1) 在本机上安装Jekyll（顺便鄙视一下某社比 **GFW** 还要变态的网络代理）

{% highlight bash %}
sudo gem install -n /usr/local/bin --http-proxy=http://proxy.xxx.co.jp:8080 jekyll
{% endhighlight %}

1. 可能不需要sudo
2. Mac OSX EI Caption (10.11.2)以上版本引入了“rootless”的概念，禁止对一部分系统目录的读写（即使sudo也不行）；可以禁用该属性或者通过`-n /usr/local/bin`的方法来将软件安装到非关键区域[^non-critical]
3. 如果公司的网络要走http代理的话，记得加上`--http-proxy`选项
{:.note}

##### 2) 从<http://jekyllthemes.org>上clone一个自己喜欢的Jekyll模板并*重命名*

~~~
cd ~/learn/
git clone git@github.com:streetturtle/jekyll-clean-dark.git koyo922.github.io
~~~
这篇博客写完之后，我又换了一个更好看/更符合中文习惯的模板  
来自于黄玄的Github <https://github.com/Huxpro/huxblog-boilerplate>
{:.note}

##### 3) 将上述仓库推到自己的GitHub Page上

在自己的GitHub上建立一个名为\<username\>.github.io的仓库，并将上述模板push到该仓库

~~~ bash
cd koyo922.github.io/
git remote set-url origin git@github.com:koyo922/koyo922.github.io.git
git push
~~~

1. 用于发布GitHub Pages的仓库名称必须是 \<username\>.github.io 
2. 必须用*master*分支，而非gh-pages
{:.note}

##### 4) 略加修改

{::nomarkdown}<ol>{:/}
<li>首先是 `vi _config.yml`[^inst-jemoji] [^emoji-chart]
{% highlight yaml %}
# Site settings
baseurl: ""        # for example, '/blog' if your blog hosted on 'host/blog'
timezone: +0900
future: true

# SNS settings
weibo_username:     2045173904  # caution, non-VIP users maybe using number-ids
zhihu_username:     qian-wei-shuo
github_username:    koyo922
facebook_username:  100005178853657

# Build settings
highlighter: rouge
gems: [jekyll-paginate, jemoji]

# Markdown settings
markdown: kramdown
kramdown:
  input: GFM        # use Github Flavored Markdown !important
  syntax_highlighter: rouge
  default_lang: bash

# Disqus settings
#disqus_username: _your_disqus_short_name_

# Duoshuo settings
duoshuo_username: koyo922

# Analytics settings
# Baidu Analytics
ba_track_id: a2bb43ef451f25a0f65288a7a1189357
# Google Analytics
ga_track_id: 'UA-73383919-2'
ga_domain: koyo922.github.io

defaults:
    -
      scope:
          path: ""
          type: "posts"
      values:
          css: "koyo-markdown"
          author: "koyo"
          layout: "post"
{% endhighlight %}
</li>
{:.koyo-li}

1. “[多说](http://duoshuo.com/)”是个比较好用的评论系统，
但是其官网文档极其隐蔽，
根本没告诉你在哪里注册。参考了网上的文章[^duoshuo]，
找到注册入口 <http://duoshuo.com/create-site/>
2. [百度分析](http://tongji.baidu.com/web/register)要专门注册*百度推广/百度联盟*帐号，[谷歌分析](https://analytics.google.com/)
直接用Google帐号即可登录；两者都非必须。
3. `/_include/footer.html`中有涉及highlight.js的内容；删掉，不然css代码的渲染会很丑（折叠起来）
4. timezone(时区设置)比较坑爹，[官网](http://jekyllrb.com/docs/configuration/)说可以用
[IANA TimeZone Database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)
中定义的时间名称；但是在本机实测只能用类似`+0900`这样的数字串
{:.note}

<li>
然后是 `vi css/koyo-markdown.css` (html中默认的`<em>`{:.language-html}标签只是斜体，不醒目)
{% highlight css %}
em {
	color: darkorange;
	font-style: normal;
}
img.emoji {
	box-shadow: none;
	background-color: transparent;
	display: inline-block;
	margin: 2px;
}
.footnotes p {
	margin-bottom: 0;
}
.highlight > pre > code pre {
	color: #ddd; // GitHub上渲染的代码结构跟本地略有不同，如果不改这里，可能看不到部分颜色的代码
}
a.footnote {
	padding-left: 0.3em;
	color: dodgerblue;
}
a.footnote:before {
	content: "[";
}
a.footnote:after {
	content: "]";
}

.note {
	color:brown;
	border-left: 12px solid #dc0;
	background-color: #ffa;
	padding: 8px;
	margin: 0;
}
.note:before {
	content: "注意:";
	display: block;
	font-weight: bold;
}
ol.note, ul.note {
	padding-left: 30px;
}

.markdown-toc {
	padding-bottom: 80px;
}
{% endhighlight %}
</li>
{:.koyo-li}

<li>
`vi _posts/2016-02-04-config-jekyll.md`, 在Front Matter中写上要嵌入的css(见第3行)，不带后缀名
{% highlight html %}
---
layout: post
css: koyo-markdown
title: "Jekyll折腾记录"
date: 2016-02-04 22:20:00
tags: Jekyll config markdown
description: 花了两天时间，总算用Jekyll搭建好了个人博客；
本地和Github都能用；代码高亮，有行号(本地支持不太好)，支持高级Markdown扩展。
---
\{::options parse_block_html="true" /}
\{\::\nomarkdown}</ol>\{\:/}
\{\% capture m %}I want this to be in *Markdown*!\{\% endcapture %}\{\{ m | markdownify }}
{% endhighlight %}

1. 上述反斜框（\）不是正确的Liquid语法，是我为了转义加在这里的。
2. 关于`nomarkdown`的用法，见此<http://kramdown.gettalong.org/quickref.html#extensions>
3. 关于`capture`的用法，见此<http://stackoverflow.com/questions/16517735/rdiscount-enable-parsing-markdown-within-block-html#answer-16533635>
{:.note}
</li>
{:.koyo-li}

<li>
`vi _layouts/post.html`, 根据文章的Front Matter中的css属性来嵌入样式[^use-koyo-css]
{% highlight liquid %}
{% raw %}
{% include header.html %}
<!-- koyo -->
{% if page && page.css %}
  <link rel='stylesheet' href='{{site.baseurl | prepend:site.url}}/css/{{ page.css }}.css' /> 
{% endif %}
<!-- koyo -->
{% endraw %}
{% endhighlight %}
</li>
{:.koyo-li}

{::nomarkdown}</ol>{:/}

##### 5) 查看结果
* 开两个窗口，分别执行 `jekyll build --watch` 和 `jekyll serve`
* 在Chrome中分别观察[本地](http://localhost:4000/)和[GitHub Page](http://koyo922.github.io)[^cname]


## 主要参考资料
* 阮一峰的文章(原理讲得很清晰，照着做一遍差不多就理解了 :+1:)<br><http://www.ruanyifeng.com/blog/2012/08/blogging_with_jekyll.html>
* Markdown Cheatsheet <https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet>
* Kramdown语法(Jekyll对此支持并不完整) <http://kramdown.gettalong.org/syntax.html>


## 脚注
[^non-critical]: MaxOS 10.11上的rootless属性问题及解决方案 <http://tex.stackexchange.com/questions/249966/install-latex-on-mac-os-x-el-capitan-10-11#answer-249967>
[^inst-jemoji]: 要先执行`sudo gem install jemoji`{:.language-bash}，见 [GitHub/jekyll/jemoji](https://github.com/jekyll/jemoji)
[^emoji-chart]: Emoji代码表 <http://www.emoji-cheat-sheet.com/>
[^duoshuo]: 感谢网友文章 http://blog.lessfun.com/blog/2013/11/27/create-blog-in-github-page-using-octopress-and-binding-domain
[^use-koyo-css]: Liquid模板语言中的`{% raw %}{% ... %}{% endraw %}`需要用*小写的*`{% raw %}{% RAW %}{% endraw %}`和`{% raw %}{% ENDRAW %}{% endraw %}`括起来转义<br>详见 <http://stackoverflow.com/questions/3426182/how-to-escape-liquid-template-tags>
[^cname]: 如果做了在仓库根下放了CNAME文件（里面写blog.koyo.xyz）之类的话，会自动跳转到相应的URL（内容一样）
