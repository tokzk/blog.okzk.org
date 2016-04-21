---
layout: post
title: Middlemanのインストールでエラー
date: 2014-01-29 15:53:28 +0900
categories: tech
---

middlemanをインストールしようとしたら、以下のエラー

```
$ gem install middleman
ERROR:  While executing gem ... (Gem::RemoteFetcher::UnknownHostError)
     no such name (https://api.rubygems.org/quick/Marshal.4.8/ffi-1.0.4-java.gemspec.rz)
```

以下でgemをアップデートしたら直った。

```
$ gem update --system
```
