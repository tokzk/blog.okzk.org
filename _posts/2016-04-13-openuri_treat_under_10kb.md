---
layout: post
title:  RailsのファイルダウンロードでTypeErrorが出た問題と対処法
date:   2016-04-13 12:52:28 +0900
categories: tech
---

### 現象

RailsでcarrierwaveでS3でアップロードしたファイルをダウンロードする際、以下のようなエラーが出ていた。

```
TypeError (no implicit conversion of StringIO into String):
```

### 原因

[Why does OpenURI treat files under 10kb in size as StringIO?](http://stackoverflow.com/questions/10496874/why-does-openuri-treat-files-under-10kb-in-size-as-stringio)

OpenURIでファイルを開く時に10kb以下だとTempfileを作らないでStringIOで処理するから、それをしないで、全てTempfileで処理するように設定を変更するということだろうか。

### 解決

`config/initializers/open-uri.rb` に以下を置いて解決。

```rb
require 'open-uri'
# Don't allow downloaded files to be created as StringIO. Force a tempfile to be created.
OpenURI::Buffer.send :remove_const, 'StringMax' if OpenURI::Buffer.const_defined?('StringMax')
OpenURI::Buffer.const_set 'StringMax', 0
```
