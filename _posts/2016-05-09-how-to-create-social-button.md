---
layout: post
title: 各SNSのシェアボタンの仕様一覧
date: 2016-05-09 15:02:00 +0900
categories: tech
---

今やBlogに記事ごとのシェアボタンは普通に存在していますが、Jekyllは最小限のものしかないので、自分で設定しないといけない。プラグインを用意してもいいのだけれど、各社のSNSのAPIがどうなっているか気になったのでまとめた。

* Twitter: [Tweet Button \| Twitter Developers](https://dev.twitter.com/web/tweet-button)
* Facebook: [シェアボタン - ソーシャルプラグイン](https://developers.facebook.com/docs/plugins/share-button#example)
* Google Plus: [Share  \|  Google+ Platform for Web  \|  Google Developers](https://developers.google.com/+/web/share/#share-link)
* Tumblr: [共有ボタンドキュメンテーション \| Tumblr](https://www.tumblr.com/docs/ja/share_button)
* Pocket: [Pocket for Publishers: Pocket Button Documentation](https://getpocket.com/publisher/button_docs)
* Pinterest: [Pinterest Developers](https://developers.pinterest.com/docs/widgets/pin-it/)
* Hatena: [はてなブックマークボタンの作成・設置について - はてなブックマーク](http://b.hatena.ne.jp/guide/bbutton)
* LINE: [設置方法｜LINEで送るボタン](https://media.line.me/howto/ja/)

とりあえず、share用の各URLにページのURLなりタイトルなりを設定してGETするリンクを作れば良さそうなので、以下のようなテンプレートを作ってリンクボタンを作れば良さそう。

[Font Awesome](https://fortawesome.github.io/Font-Awesome/)を使ってると国産のSNSのボタンがないので、どこかのタイミングで、[Ligature Symbols](http://kudakurage.com/ligature_symbols/)に変えたほうが良いかもなぁ。

```
<ul class="share-post list-inline pull-right">
  <li>
    <a href="https://twitter.com/intent/tweet?text={{ page.title }}&url={{ site.url }}{{ page.url }}&via={{ site.twitter_username }}&related={{ site.twitter_username }}" rel="nofollow" target="_blank" title="Share on Twitter" class='btn btn-default btn-xs'>
      <i class="fa fa-twitter"><span>Twitter</span></i>
    </a>
  </li>
  <li>
    <a href="https://facebook.com/sharer.php?u={{ site.url }}{{ page.url }}" rel="nofollow" target="_blank" title="Share on Facebook"" class='btn btn-default btn-xs'>
      <i class='fa fa-facebook'><span>Facebook</span></i>
    </a>
  </li>
  <li>
    <a href="https://plus.google.com/share?url={{ site.url }}{{ page.url }}" rel="nofollow" target="_blank" title="Share on Google+" class='btn btn-default btn-xs'>
      <i class='fa fa-google-plus'><span>Google</span></i>
    </a>
  </li>
</ul>
```