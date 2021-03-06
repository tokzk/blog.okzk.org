---
layout: post
title: 「Game Programming Patterns」はWeb開発者も読むべき本だった
date:   2016-06-08 20:20:00 +0900
categories: tech
---

「{% amazon B015R0M8W0 title %}」を読んでみたところ、ゲームプログラミングと題されていますが、Web開発でも通じる内容、デザインパターンと実際の開発の間をつなぐ良本だったので紹介します。

iOSでゲームのプログラムを書いてた時、このあたりはどう書いたらいいんだろうか、もう少し効率のよい書き方はあるんじゃないかなと思い始めていました。そこで、なにかいい情報はないかなと探していた時、あるサイトを見つけました。

<http://gameprogrammingpatterns.com/>

すこしWeb版を読んでみたのですが、なかなか分かりやすく、書籍版はないのかなと見てみると、翻訳版が出ていたので早速購入しました。

{% amazon B015R0M8W0 detail %}

## 概要
この本のプロローグにも書いてありますが、実際のゲーム開発の特定の領域を扱う本では**ありません**。また、ゲームエンジンを扱う本でも**ありません**

ゲーム開発における様々な問題に対し、実際現場で適応されている解決策やその考え方が書かれています。その多くが、ゲーム開発にかぎらず、Web開発などでも適用できるアイデアになっています。

特に、サンプルはゲームを扱ったものなので、想像もしやすいですし、面白いです。
実際に、問題点も頭に浮かびやすいですし、適用の仕方もわかりやすいです。

ゲームプログラミングを元に解説をしているのでサンプルコードはC++で書かれています。
僕は、C++は書けませんが、それほど複雑なものはないので、文法的なところをその都度調べればわかると思います。

## 感想

ゲームプログラミング、とりわけ、インタフェースに対するプログラミングのパターンは、昨今のWebではSPAなどのJavascriptを中心としたイベント駆動式のプログラミング、またはモバイル・アプリケーションなどへの応用ができるかと思います。

特に各パターンが生まれた背景が丁寧に書かれているので、どうしてそのパターンが必要なのかということが分かりやすくかつ面白く書かれている。特にユーモアある脚注が面白い。

この本の目標は以下の３つ。

1. プロジェクトが生きている間はコードが読みやすくなければならないので、整ったアーキテクチャが維持される。
2. 実行速度が速い。
3. 今日見出された問題にできるだけ短時間で答えを出せる。

このあたりはシステム開発でもよく問題になる話で、どれを優先するかで日々バトルが繰り返されてる問題でもあります。
実際のところ、どれも違う立場やスコープで**速度**のことを言っているだけなのです。
それぞれ以下のようなものを如何にバランスを取って開発をするかの指針が示されています。

1. 長期的な開発速度をあげる。かかわる開発者全体の生産性上げ、チームで開発していたり、時期が長期化すればするほど、ここを重視しているかいないかで、かかる時間が変わる。また読みやすさ等にも影響し副次的に3.の速度を上げることもある。考え過ぎ、複雑になると3.を下げることも。
2. 実行速度を上げる、製品のインターフェース、製品の性能に影響する。ユーザーが体感する部分で、ゲームの面白さ、利便性などに影響する。最適化すると、変更への速度を下げる
3. 短期的な開発速度を上げる。バグの対応や新機能追加などのユーザへの対応速度などを上げる。将来への生産性を下げることもある。

実際はどれもトレードオフとバランスで成り立っていて、条件によって、変わることも明記されています。（捨てるプロトタイプだと３を重視されるとか、経営層がそれをそのまま製品にしろというような話も書かれていて涙で前が見えない）

特にコマンド、オブザーバ、プロトタイプ、シングルトンあたりは色々適用できそうな場所がわかりやすかったです。
面白かったの、Bytecodeのあたりで、今まで敬遠していた分野を分かりやすく説明してくれていたのでよかったです。

以下に本文の表現の中で、面白かったものを引用します。

> このように書くと、VMの作成よりずっと敷居が高いように聞こえます。プログラマーの多くが大学のコンパイラの授業で苦労し、授業で得たものといえば表紙に龍の絵がある本や、「lex」「yacc」などの単語を見ただけで引き起こされるPTSDの症状だけといったありさまです。


> 文法の定義が必要ですーー言語設計者はプロもアマも文法の定義を甘く見すぎています。パーサ（構文解析器）に楽をさせる文法を定義することは簡単です。ユーザーに楽をさせる文法を定義するのは難題です。文法のデザインはユーザーインターフェース（UI）のデザインであり、UIを文字列によるものに絞ったところでデザインの過程が簡単になるわけではありません。


> プログラミングになじみのないユーザーから敬遠されます。ーー私たちプログラマーはテキストファイルが好きです。強力なコマンドラインツールと組み合わせれば、コンピュータ世界の「レゴ」ブロックになると思っています。簡単で、しかも無限の組み合わせが可能です。ところが、一般の人々はそのように考えていません。彼らにとってテキストファイルを書くのは、セミコロンを１つ忘れたからといって怒鳴りつけてくる、融通の利かない不機嫌な役人に提出する税金の申告書を書いているようなものなのです。


> プログラマーは、人間がエラーを犯すことを恥ずべき欠陥と考えて、エラーを起こさないように最大限の努力をする傾向があります。しかし、ユーザーが楽しんで使えるシステムを作成するには、間違いやすいという性質も含めて、人間のすべての性質を受け入れることが必要です。間違いは誰もが犯すものあり、創造的なプロセスの基礎となるものです。「取り消し」を可能にするなどしてエラーをさりげなく処理することで、ユーザーの創造性は高まり、より良いものを作れるようになります。


> ゲームのビヘイビアを定義するのに、スクリプト言語やその他の高レベルの手段を利用すると、実行時の効率はいくぶん低下しますが、生産性はめざましく向上します。ハードウェアは進化し続けますが、人間の脳のほうはそうはいきませんので、生産性の向上に重きを置くことがますます重要になってきます。

作者の文章（とみごとな翻訳）は、とてもおもしろく、心に響いたり、頷いたり、反省したりと楽しめました。

## まとめ

プログラミング経験がある程度あって、書いてるプログラムが、すこし大きくなってきたときに、より効率よくプログラミングしたいなーという人にはぜひ読んでほしい。

デザインパターン本を読んでいたけれど、どういう条件で適用したらいいかを考える時に参考に知るととても良いのではないかと思います。

また、プログラミングにまつわる読み物としても面白いです。

---

{% amazon B015R0M8W0 detail %}
