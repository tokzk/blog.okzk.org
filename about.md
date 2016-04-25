---
layout: page
title: About
permalink: /about/
---

東京在住、フリーランスのプログラマーです。
大学卒業後、友人の紹介で入った制作会社でWebアプリ開発に携わってきました。
2010年くらいまでは主にJavaプログラマでしたが、Railsに出会ってからは、Web開発は8割ぐらいがRailsの仕事になっています。
小さな会社にいたので、要件定義から見積、設計、実装、環境構築、運用まで一通り何でもこなせます。部分的なお手伝いのご依頼も随時受け付けています。
お仕事の依頼は、Twitter、メールもしくはお問い合わせフォームからお願いします。

<ul class="list-inline">
  <li>
    <a class="btn-outline btn-social" href='https://twitter.com/tokzk'>
      <i class='fa fa-fw fa-twitter'></i>
    </a>
  </li>
  <li>
    <a class="btn-outline btn-social" href='https://github.com/tokzk'>
      <i class='fa fa-fw fa-github'></i>
    </a>
  </li>
</ul>

<div class="contact-form">
  <form action="http://mailthis.to/tokzk" method="post">
    <div class="form-group">
      <label for="email">
        <i class='fa fa-envelope-o'></i>
        メールアドレス(必須)
      </label>
      <input type="email" name="email" id="email">
    </div>
    <div class="form-group">
      <label for="message">
        <i class='fa fa-comment-o'></i>
        メッセージ本文(必須)
      </label>
      <textarea name="message" id="message"></textarea>
    </div>
    <div class="form-group">
      <button type="submit" id="submitBtn">
        <i class='fa fa-paper-plane'></i>
        送信
      </button>
      <input type="hidden" name="_subject" value="お問い合わせ">
      <input type="hidden" name="_replyto" value="%email">
      <input type="hidden" name="_valid[email]" value="valid_email">
      <input type="hidden" name="_valid[message]" value="min_length[10]">
      <input type="hidden" name="_after" value="{{ site.url }}/thanks/">
      <input type="text" name="_honey" value="" style="display:none">
    </div>
  </form>
</div>
