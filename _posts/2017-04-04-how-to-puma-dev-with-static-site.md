---
layout: post
title: 静的サイトをPuma-devで管理/herokuにデプロイする date:   2017/04/04 12:00:00 +0900
categories: tech
---

[前回]、Rails環境はPuma-devに移行したたけど、ローカルにある静的なサイトを、開発環境で`http://static-site.dev`という形で確認したいなぁと思ったので、どうにかすることにした。割りとデザイナーさんとかでも便利かもしれないなーと思った。

{% image how-to-puma-dev-with-static-site.png %}


とまぁ、原理を考えればやることは簡単で、Puma-devはPumaを使ったRackアプリケーションを`http://xxxx.dev`という形で表示するのでRackアプリケーションにしてしまえばいい。

Railsを使ってもいいし、Rackだけを使うのもいいけど、今回はsinatraを使ったRackアプリケーションにする。

[前回]:　{% post_url 2017-04-03-how-to-replace-pow-to-puma-dev %}

## 設定

テンプレートを作ったのでそれをgitでcloneしてきて、bundle installして、Puma-devの設定をするだけ。

```
$ git clone git@github.com:tokzk/static-web.git
$ cd static-web
$ bundle install
$ puma-dev link -n example-web #オプション無しならディレクトリ名
$ open http://example-web.dev/
```

以上で、完了です。

### Herokuへデプロイ

おまけとしてherokuへのデプロイ方法も書いておく。

cloneしたディレクトリのGitを初期化する。

```
$ rm -rf .git
$ git init
$ heroku create
$ git add .
$ git commit -m "Initial version”
```

herokuへデプロイする。

```
$ git push heroku master
$ heroku open
```


以降、更新はgit pushを行うだけ。
```
$ git commit -m "Add top page"
$ git push heroku master
```


## リポジトリの解説

中身は単なるsinatraアプリケーション。  


```
# Gemfile
# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.4.1'

gem 'puma'
gem 'sinatra'
```

ファイルを分けるのが面倒なので、すべて`config.ru`に以下を記述。

```
# config.ru
Bundler.require

class App < Sinatra::Application
  get '/' do
    send_file File.join(settings.public_folder, 'index.html')
  end
end

run App
```

そして`public`フォルダに`index.html`を置けばOK

## まとめ

というわけで、Puma-devでRailsサイトも静的サイトも管理することが出来るようになった。今回の様に静的サイトもRackアプリケーションにするやり方で、herokuのようなPaaSでも静的サイトをデプロイすることが出来るので覚えておいて損はなさそう。

---

{% amazon 4048915134 detail %}