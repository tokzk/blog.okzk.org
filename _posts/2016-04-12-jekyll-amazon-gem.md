---
layout: post
title:  Jekyllでamazonアソシエイトリンクを作るためのgem ”jekyll-amazon”
date:   2016-04-12 10:00:00 +0900
categories: tech
---

Markdownのタグで、Amazonのリンクを作るとなかなか、面倒くさそうだったので、Jekyllでamazonアソシエイトリンクを作るための、jekyllプラグインを作りました。

が、Github-pagesだと動作しないのでどうしようか悩んでます。


## インストール

jekyllのディレクトリで、`_config.yml`に以下を追加。

    gems: [jekyll-amazon]

Gemfile に以下の行を追加。

    gem 'jekyll-amazon’, group: [:jekyll_plugins]

そして以下を実行。

    $ bundle

[Product Advertising API](https://affiliate.amazon.co.jp/gp/advertising/api/detail/main.html "Product Advertising API") を使用しているので、アソシエイトタグと別途アマゾンから取得した、AWS_ACCESS_KEY_IDとAWS_SECRET_KEYを環境変数で設定。

    $ export ECS_ASSOCIATE_TAG=...
    $ export AWS_ACCESS_KEY_ID=...
    $ export AWS_SECRET_KEY...


使い方は簡単で、_postsの記事の中に、`{% raw %}{% amazon <asin> <type> %}{% endraw %}`と記述します。

* **asin**: ASINコード
* **type**: テンプレートタイプ、title, image, detail

| タイプ | 出力されるもの |
|:-|:-|
| title | タイトルをAタグでくくったもの |
| image | 画像（サイズ:中)をAタグでくくったもの |
| detail | 画像、タイトル等を出力したもの、クラス指定はしてあるので、別途CSSでスタイリング可能 |

初めての、gemなのでおかしいところがちょいちょいありそうです。
最低限のコードなので、もうちょっとスタイルされた出力を追加していきたい。


[tokzk/jekyll-amazon](https://github.com/tokzk/jekyll-amazon)
[jekyll-amazon | RubyGems.org | your community gem host](https://rubygems.org/gems/jekyll-amazon/)

## 参考

{% amazon 4774158798 detail %}

