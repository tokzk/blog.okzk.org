---
layout: post
title: Railsのログのカスタマイズ方法 date:   2017/04/14 16:14:00 +0900
categories: tech
---
Railsのログは複数行あるので、どこからどこまでかリクエストに対するログなのか一瞬で分からない時があります。なのでApacheのログのように1行でまとめて表示するためのgemである[lograge][1]をインストールしてログの出力を変更してみます。

{% image better-rails-logging %}

[1]: https://github.com/roidrage/lograge “An attempt to tame Rails' default policy to log everything.”

## インストール

Gemfileに記述。

```
# Gemfile
gem 'lograge'
```

記録したい項目を追加したい場合は、AplicationControllerでappend_info_to_payload(payload)をオーバーライドして、payloadに項目を追加します。

```
# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  def append_info_to_payload(payload)
    super
    payload[:host] = request.host
    payload[:ua] = request.user_agent
  end
end
```

記録するlogの設定をします。
アプリケーション全体で変更してもいいですし、プロダクション環境だけで変更してもいいと思います。
custom_optionsで記録する項目を追加できます。

```
# config/initializers/lograge.rb
# OR
# config/environments/production.rb

Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.custom_options = lambda do |event|
    {
      time: event.time,
      ua: event.payload[:ua],
      exception: event.payload[:exception],
      exception_object: event.payload[:exception_object]
    }
  end
end
```


## 結果

このログ表示が↓

```
Started GET "/users" for 127.0.0.1 at 2017-04-14 14:21:02 +0900
Processing by UsersController#dashboard as HTML
  Rendering users/index.html.erb within layouts/application
  Rendered users/index.html.erb within layouts/application (592.0ms)
  Rendered layouts/_nav.html.erb (2.9ms) [cache miss]
  Rendered layouts/_messages.html.erb (0.5ms) [cache miss]
Completed 200 OK in 2419ms (Views: 2355.1ms | ActiveRecord: 21.1ms)
```

このような形になります↓

```
method=GET path=/users format=html controller=UsersController action=index status=200 duration=213.15 view=206.34 db=1.76 time=2017-04-14 14:19:02 +0900 ua=Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36 exception= exception_object=
```

他にもログを色々整形したり、別のログ収集ツールに飛ばしたりも出来るので、色々便利そうです。

---

{% amazon 4774188832 detail %}
