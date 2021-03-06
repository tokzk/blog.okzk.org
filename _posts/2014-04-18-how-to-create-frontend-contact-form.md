---
layout: post
title: 静的サイトにプログラムなしでコンタクトフォームを設置する方法
date:   2016-04-18 12:52:28 +0900
categories: tech
---

コンタクトフォームを設置したいと思ったけど、Jekyllなので動的なプログラムは設置できない。それでは他に選択肢がないか調べたなかで良さそうなものを、紹介します。
{% image how-to-create-frontend-contact-form.jpg %}

プログラムいらずで、任意のフォームの入力をメールへ転送してくれるサービス 
[MailThis.to](http://mailthis.to/)

アカウント登録等の設定や、サイト側の設定は一切いりません。
サイトにフォームを作って、mailthis.toにフォームのデータを送信するだけで、指定したメールアドレスにフォームの内容を、送信された数秒後に転送してくれます。自分は設定してませんが、添付ファイルもいけるようです。

## ざっと解説

サイトのGetting Startedを順に追っていけばいいのでわかると思いますが、簡単におってみます。

1. Emailの別名を定義する（オプション）
    後にも出てきますが、送信先のメールアドレスをフォームのActionに設定します。その場合、メールアドレスがソースに公開されるので、スパム用に収集される可能性があります。

        <form action="//mailthis.to/me@gmail.com" method="post">

    なので、メールアドレスに対応する文字列を指定し、その文字列を指定することで、メールアドレスを守る仕組みです。
    メールアドレスと、対応する文字列を入れておきましょう。

2. HTMLフォームを作る。
実際に設置するフォームを作りましょう。
雛形ができているので、HTML Exampleを編集しながら、Resulting Formで確認してみましょう。

3. 高度なフィールドを使ってみる。(オプション)
様々なオプションを指定することで、細かに挙動を変更することが出来ます。
送信するメールのタイトルを指定したり、CC、BCCを指定したり、送信完了後のページを指定したり出来ます。スパム避け用のフィールドなどもあります。
他にも指定できるのでドキュメントを確認しておくと良いでしょう。

4. バリデーション（入力の検証）を指定する。
必須項目や、入力制限、数字の強制や、正しいメールアドレスの強制などの指定ができます。
これも様々な項目があるのでドキュメントを確認しておくと良いでしょう。

これで、完了です。
ただし、一回目の送信は指定したメールアドレスが有効なものかどうかを判定しますので、一度フォームからメッセージを送ってみてください。最初のフォーム送信してしばらくすると、メールが飛んできます。それに記載されたURLで認証すると、以降メールアドレス宛にフォームからの送信がメールに飛んできます。

## まとめ

このサービスまだベータ版なので制限等の条件がわかりません。簡易的なフォームで、特にセキュリティ面等大げさにする必要が無いようだったら、プログラムいらずで設置できるのでいかがでしょうか。

他にも同様のサービスはあるので、商用で使う場合はそちらのほうがいいかもしれません。日本で同様のサービスはないんですかね。

- [Mailthis.to](http://mailthis.to/)
- [elFormo](https://www.elformo.com/)
- [Formspree](http://formspree.io/)
- [Flipmail](http://flipmail.co/)
- [Simple Form](https://getsimpleform.com/)