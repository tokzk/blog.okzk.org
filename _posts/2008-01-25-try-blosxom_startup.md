---
layout: post
title:  Blosxomを導入
date:   2008-01-25 12:00:00 +0900
categories: tech
---

一通り回ってやっぱりBlosxomに返って来た。テキストで管理したいというのがやはり最大の理由。というわけで再度設定を記録しておきます。

1.  [hail2u.net - Archives - blosxom starter kit] から blosxom starter kit 1.1.3 をダウンロードし、展開。config.cgiを変更する。
2.  [blosxom :: the zen of blogging :: plugins/general/flavourdir.txt] から flavourdirプラグインをダウンロード pluginsディレクトリに入れる。
3.  entries以下にflavoursというディレクトリを作り、フレーバーファイルを全てその中に移す。
4.  blosxom.cgiの名前をblogに変更する。
5.  .htaccess に以下の記述をする。
	
		<Files blog>
			SetHandler cgi-script
		</Files>

6.  [Markdown] からmarkdown.plダウンロードする。最新版はおそらく以下  
	<http://daringfireball.net/projects/downloads/Markdown_1.0.2b4.tar.gz> 
7.  markdown.pl を markdown に変更し、plugins フォルダに入れる。
8.  投稿テキストはUTF-8、一行目がタイトル、あとはMarkdown記法で記述してアップロード
9.  以上で <http://www5.big.or.jp/~tex/blog> にアクセスできるようになる。


追記
----
SPAM防止のために、story.rssから

	(mailto:$rss10::email)

	<trackback:ping rdf:resource="$url$path/$fn.trackback"/> 

を削除した。

また、story.html, story.htm から Auto Trackback Discovery 用の記述も削除

	<!--
	<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	  xmlns:dc="http://purl.org/dc/elements/1.1/"
	  xmlns:trackback="http://madskills.com/public/xml/rss/module/trackback/">
	  <rdf:Description
	    rdf:about="$url$path/$fn.htm"
	    dc:identifier="$url$path/$fn.htm"
	    dc:title="$title"
	    trackback:ping="$url$path/$fn.trackback"/>
	</rdf:RDF>
	-->

[hail2u.net - Archives - blosxom starter kit]: http://hail2u.net/archives/bsk.html
[blosxom :: the zen of blogging :: plugins/general/flavourdir.txt]: http://www.blosxom.com/plugins/general/flavourdir.htm
[Markdown]: http://daringfireball.net/projects/markdown/

