---
layout: post
title: jekyll-amazonの詳細表示を修正とリファクタリング
date:   2016-07-27 12:00:00 +0900
categories: tech
---

[jekyll\-amazon](https://github.com/tokzk/jekyll-amazon)
に[Pull Request](https://github.com/tokzk/jekyll-amazon/pull/1)が来ていた。仕事以外では初めてのプルリクエストだったので、嬉しい。（中身はバグで申し訳ない）。

環境変数は、direnvを使っていて、.envrcを見たら間違っていた。うーむ。
それと合わせて、色々、詳細表示を変えていたのでそれも反映させてバージョンを上げた。

しばらくSwiftばっかりいじっていたので、そろそろRubyのコードが触りたい。
