---
layout: post
title:  PostgreSQLで大文字小文字区別無しで検索　Case Insensitive
date:   2008-02-13 12:00:00 +0900
categories: tech
---

PostgreSQLでの検索を大文字小文字区別なしで行いたいとの事なので、対応する演算子を捜したところ、以下の文章が見つかったのでテストしてみました。

<http://www.postgresql.jp/document/current/html/functions-matching.html>

	SELECT * FROM entry WHERE title ILIKE '%TEST%';
	SELECT * FROM entry WHERE title ~~* '%TEST%';

LIKE と ~~ は等価、ILIKE と ~~* が等価のようだ。

~を一つにするとPOSIX正規表現を使ったマッチングになるようだ。
今回は部分一致の検索のみでいいので、TESTの値はプログラム側で
キーワード(_や%)をエスケープ処理してSQLInjectionを防ぎ、
ILIKEを使い前後へのマッチングのみに対応した。