---
layout: post
title: Railsとメール送信あれやこれや
date: 2013-01-29 12:52:28 +0900
categories: tech
---

Deviseを使ってUser登録機能を作ったりしていると、メールの送信が必要になってくるのでメモっておこうと思います。

## 開発環境
まずは、開発用。Railscasts の @ryanb が作ってる[letter_opener](https://github.com/ryanb/letter_opener) が大変便利。

Gemfileに以下を設定。

```ruby
group :development do
  gem 'letter_opener'
end
```

`config/environments/development.rb` に以下を設定。

```
config.action_mailer.delivery_method = :letter_opener
```

これで、メール送信処理が行われると、ブラウザが開いてメールが確認できます。

## 本番環境

### sendmail
本番環境でsendmailが動いているようなら、`config/environments/production.rb`に以下を追加して、ローカルからメールを送信するのが楽。

```
config.action_mailer.delivery_method = :sendmail
```

### smtp
PaaSなんかだとそういう環境はないかもしれないので、Gmail(smtp)を使った設定もあるので以下のように設定。

```
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'example.com',
  :user_name            => 'username', 
  :password             => 'password',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
```

'username'や'password'の方は埋め込むとセキュリティ上良くない場合なんかは
環境変数で設定するといいだろう。

```
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'example.com',
  :user_name            => ENV['SMTP_USERNAME'],
  :password             => ENV['SMTP_PASSWORD'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
```

Gmailの送信は確か、500通/日で、Fromの部分は登録されているアドレスでないといけないので、そこらへんは使用するGmailを設定して下さい。

### Sendgrid
Herokuを使っている場合は、Sendgridを使ってメールを送信するのが楽ちん
200通/日まで無料なので、自分の場合はステージング環境などには十分でした。

herokuでAddonを有効にするにはクレジットカードを登録する必要があります。

その後コマンドラインから

```
$ heroku addons:add sendgrid:starter
```

として有効にします。

`config/initializers/mail.rb` に以下のように記述します。

```ruby
ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => ENV['SENDGRID_USERNAME'],
  :password       => ENV['SENDGRID_PASSWORD'],
  :domain         => 'heroku.com'
}
ActionMailer::Base.delivery_method ||= :smtp
```

以上でメールが送信できるようになります。

## 参考

- [Ruby on Rails Guides: Action Mailer Basics"](href="http://guides.rubyonrails.org/action_mailer_basics.html)
- [“Sending Email from Your App \| Heroku Dev Center”](https://devcenter.heroku.com/articles/smtp)
- [SendGrid \| Heroku Dev Center](https://devcenter.heroku.com/articles/sendgrid)
