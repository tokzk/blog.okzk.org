---
layout: post
title: Rails logger あれやこれや
date: 2013-02-05 19:58:28 +0900
categories: tech
---

Rails のログに関するまとめ

## ログローテーション

### 通常のログローテーションに関して

```config/environment.rb
+ require 'active_support/core_ext/numeric/bytes'
```

先頭に追加

config/environments/development.rb

```
   config.assets.debug = true
+
+  config.logger = Logger.new("#{Rails.root}/log/#{Rails.env}.log", 10, 1.megabytes)
end
```

config/environments/production.rb

```
+
+  config.logger = Logger.new("#{Rails.root}/log/#{Rails.env}.log", 'daily')
end
```

### Passenger を使う時のログローテーション（バッドノウハウな気がします）

```
# cat /etc/logrotate.d/passenger 
/home/application/projects/rails_app/current/log/production.log {
  weekly
  missingok
  rotate 30
  compress
  delaycompress
  sharedscripts
  postrotate
    touch /home/application/projects/rails_app/current/tmp/restart.txt
  endscript
}
```

## ログの解析

簡易的に見るのはこれが楽そう。

- [wvanbergen/request-log-analyzer · GitHub](https://github.com/wvanbergen/request-log-analyzer)

```
$ request-log-analyzer log/production.log --file report.html --output HTML
```

## 参考

- [Rubyist Magazine - 標準添付ライブラリ紹介 【第 2 回】 Logger](http://jp.rubyist.net/magazine/?0008-BundledLibraries)
- [#56 The Logger (revised) - RailsCasts](http://railscasts.com/episodes/56-the-logger-revised)
- [Home · wvanbergen/request-log-analyzer Wiki](https://github.com/wvanbergen/request-log-analyzer/wiki)
