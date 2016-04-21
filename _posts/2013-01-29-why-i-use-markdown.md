---
layout: post
title: Markdownとの出会い
date: 2013-01-29 19:58:28 +0900
categories: tech
---

2007年ごろ、ドキュメントを書く仕事があった。

納品するソフトウェアのドキュメントであったので、バージョンアップをするたびに更新をしないといけない。
お客さんの方で、変更履歴を確認したいという要望と印刷したものを記録として残しておきたいという要望があった。 その上、新しく配属されたメンバーなどに資料を配布するので、WordやPDFのようなもので印刷に耐えうるようレイアウトされたものが欲しいという要望があった。

当時、cvsでバージョン管理を行なっていたが、資料に関してはWordやPDFなどをバイナリで保存して管理していた。 どうにか、できないかと色々探した中で見つけたのがMarkdownだったと思う。

Markdown はテキスト文書を記述するための記法のひとつである。
そして、仕事のドキュメントは、Markdownを使って記述し、それをバッチ処理でpandocに渡してcss付きのHTMLを出力するようなスクリプトを書いて納品した。

以来、個人的な資料、会社での資料、メール、議事録などドキュメント類はほとんど、Markdownで記録するようにした。 以前書いていたブログもBlosxomにMarkdown.plを導入してテキストで管理していた。

- Markdownの記法は簡単だ。複雑なことは出来ないが必要十分である。
- 元々メールの装飾から作られただけあって、見た目とリンクしていて分かりやすい。
- 単なるテキストファイルなので、手軽に扱える。Dropboxに置いておけばどこでも使えるし、どんなエディタでも編集できる。
- 最近は、アプリケーションサポートが充実しているので、iPhone,iPadアプリでも扱えるし、Mac,PCなども専用のエディタも出ている。
- シンプルなルールなので文章自体に注力できる。集中力も増すというものだ。

というわけで、WordPressでもMarkdownで記録したい。

プラグイン > 新規追加 > 検索 で 「Markdown」で入力して一番上に表示されたものを入れてみた。
[WordPress › Markdown on Save Improved « WordPress Plugins](http://wordpress.org/extend/plugins/markdown-on-save-improved/)

新規投稿欄の右のサイドメニューに「Disable Markdown formatting」と「Convert HTML to Markdown」が表示されている。

- 「Disable Markdown formatting」のチェックを外せば、Markdownでの書き込みができる。
- 「Convert HTML to Markdown」のチェックを付けて保存すれば、HTMLで記述されたテキストがMarkdown形式に変換されて保存される。

便利便利。

そういえば、Markdownを考案したJohn Gruberの協力者の一人、Aaron Swartzが先日自殺をしてしまった。まだ若いのにとても残念だ。

## 参考

- [Markdown - Wikipedia](http://ja.wikipedia.org/wiki/Markdown)
