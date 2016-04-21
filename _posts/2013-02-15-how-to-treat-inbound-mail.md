---
layout: post
title: Gmailで作る空メール受信システム
date: 2013-02-15 19:58:28 +0900
categories: tech
---

```Gemfile
gem 'mail_room'
```

error

証明書がないといけないぽい

```
$ ruby -ropenssl -e 'p OpenSSL::X509::DEFAULT_CERT_FILE'
```

ファイルがないのでここに作る

````
/Users/okzk/.rvm/usr/ssl/cert.pem
```

Firefox から書きだして上書き

```
$ mail_room -f config.yml
```

便利だけど、受信したタイミングでしか動作しないので、プロセス動かし続けないといけないのが難点なので、止めた時に取り逃したりすると問題ありそう。


herokuでsendgrid使ってるなら
<https://github.com/thoughtbot/griddler>
こっちでもよさそう

これに似たようなので、受信、httpでアクション、INBOXのファイルを別のフォルダに移動させるとかの作ったら、空メール受信とかできるかもなー
