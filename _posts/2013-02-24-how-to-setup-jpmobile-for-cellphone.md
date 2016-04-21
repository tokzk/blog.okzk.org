---
layout: post
title: Devise の各種メールを Jpmobile を使って、ケータイ対応
date: 2013-02-24 20:45:28 +0900
categories: tech
---

もう、今時UTF-8で送ってもよいような気がしますが、手間なく対応出来たらいいなーと思って調べてみました。

モンキーパッチ当てるのとか、mail-iso-2022-jp gemを使うのとかなかなか良さそうではあったんですが、view の表示で Jpmobile を使っていたので、Jpmobile::Mailer::Base を継承すれば、通常のメールは対応できそうです

Devise のメールの仕組みを見てみます。

<https://github.com/plataformatec/devise/blob/master/app/mailers/devise/mailer.rb#L1>

Devise.parent_mailer で指定したClassを継承してるようです。

<https://github.com/plataformatec/devise/blob/master/lib/devise.rb#L207> を見ると通常 ActionMailer::Base なので、これを、Jpmobile::Mailer::Base にすれば問題無さそう。

```
Devise.setup do |config|
  ...
  config.parent_mailer = "Jpmobile::Mailer::Base"
  ...
end
```

送信テストしてみると、ISO-2022-JPで送られてれば送信成功です。

```
Sent mail to test@example.com (244ms)
Date: Sun, 24 Feb 2013 19:34:18 +0900
From: please-change-me-at-config-initializers-devise@example.com
Reply-To: please-change-me-at-config-initializers-devise@example.com
To: test@example.com
Message-ID: &lt;5129ecaa7c4ee_16a933fd0d5c606704865e@xxxxx.local.mail&gt;
Subject: =?ISO-2022-JP?B?GyRCJSIlKyUmJXMlSCRORVBPP0p9SyEbKEI=?=
Mime-Version: 1.0
Content-Type: text/plain;
 charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
```

## 参考

- [jpmobile/jpmobile · GitHub](https://github.com/jpmobile/jpmobile)
- [How To: Use custom mailer · plataformatec/devise Wiki](https://github.com/plataformatec/devise/wiki/How-To:-Use-custom-mailer)
- [ails 3.xでISO-2022-JP（JISコード）の電子メールを送る: mail-iso-2022-jp - Rails 雑感 - Ruby on Rails with OIAX](http://www.oiax.jp/rails/zakkan/mail-iso-2022-jp.html)