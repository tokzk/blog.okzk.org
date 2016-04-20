---
layout: post
title: Jekyll(Markdown)でリンクを外部リンクにする方法
date:   2016-04-20 14:00:00 +0900
categories: tech
---

Jekyllでリンクを作る時、Markdownの記法で書きます。
しかし、その際はすべて通常のAタグのHTMLが出力されますので、画面遷移のリンクになってしまい、記事中にリンクを貼ると移動されてしまい、あまり良くありません。

普通のHTMLではAタグに`target=“_blank”`のような要素を加えるのですが、Markdownでこれを追加できないものかなと調べました。

Jekyllで表示使用のMarkdownエンジンのKramdownでは、[”IAL(Inline Attribute Lists)”](http://kramdown.gettalong.org/syntax.html#inline-attribute-lists)という方法で実現できるようです。

```markdown
[title](http://example.com){:target="_blank"}
```

ただ、これだと毎回リンクにターゲットを書いていかないといけないのと、MarkdownにHTML的なものを書くのは気が引けるので、以下の方法で、出力されたHTMLをJSで操作して対応したいと思います。

Javascriptでリンク先を新しいウィンドウを開く方法

```javascript
var links = document.links;
for (var i = 0, linksLength = links.length; i < linksLength; i++) {
   if (links[i].hostname != window.location.hostname) {
       links[i].target = '_blank';
   } 
}
```

jQueryでリンク先を新しいウィンドウを開く方法

```javascript
$(document.links).filter(function() {
    return this.hostname != window.location.hostname;
}).attr('target', '_blank');
```

Markdownのいい所は、ブログなどの仕組みを変えたとしてもデータとしてのMarkdownは変わらず残るので、なるべく、html的なものやエンジン独自のものは省いていったほうがいいと思います（MVCフレームワークでViewとModelは分けておいた方がいいように）。


