---
layout: post
title: Jekyllで関連記事の生成が遅い問題を解消
date:   2016-04-27 16:39:00 +0900
categories: tech
---

Jekyllで記事を作った後、関連記事が常に最新の3件が表示されるだけで、関連した記事が表示されていない。これを有効にするには、lsiオプションが必要らしい。しかし、lsiオプションをしただけだと、記事の生成にとても時間がかかり実用的でない。そこで、記事の生成時間を劇的に早める方法がわかったので紹介する。

## 方法

1. `homebrew`を使って`gsl`をインストールする

        $ brew install gsl

2. `rb-gsl`をインストールする
    `Gemfile`に以下を追加

        gem ‘nmatrix’
        gem ‘gsl’

    インストールする。

        $ bundle install

3. lsiオプションを追加

        $ jekyll build —lsi

    もしくは、`_config.yml`に`lsi: true`を追加する。

## まとめ

これで記事の生成が、数十分かかっていたものが、5秒以下で生成されるようになった。