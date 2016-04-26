---
layout: post
title: さくらインターネットでWordPressする時のホームの設定
date: 2013-01-30 18:07:28 +0900
categories: tech
---

ブログを設置するにあたり、

1. ドメインのトップページからWordpressにしておきたい。
http://okzk.org/ でWordPressのトップページにアクセスされるようにしたい。
コーポレートサイトサイトなどを作る時は特にこの要件が重要になるんではなかろうか。

2. WordPressをインストールするディレクトリは、一つにまとめておきたい。
WordPress以外のコンテンツを置くときに、ドキュメントルートにWordPressが直にインストールされていると、ゴチャゴチャするし、管理が面倒だ。
出来ることならば、一つのディレクトリにWordPressを追いやっておきたい。

この2つの要件を満たすにあたり、殆どの人は、以下の対処法で解決するだろう。

[WordPress を専用ディレクトリに配置する - WordPress Codex 日本語版](http://wpdocs.sourceforge.jp/WordPress_%E3%82%92%E5%B0%82%E7%94%A8%E3%83%87%E3%82%A3%E3%83%AC%E3%82%AF%E3%83%88%E3%83%AA%E3%81%AB%E9%85%8D%E7%BD%AE%E3%81%99%E3%82%8B)

## さくらインターネットの場合

さくらインターネットの場合、WordPressのクイックインストールというサービスがある。
当初はこれを使用していたが、これを設定すると **うまくいかない**。

つまり、さくらで上記2点を満たすためには、 **クイックインストール** でWordPressをインストールしては **いけない**。

以下のように、手動(といっても大したことではないが)でWordPressを設定すればよい。

1. データベースの設定をする。
2. [WordPress \| 日本語](http://ja.wordpress.org/) からダウンロードし展開する。
3. FTPで、 さくらのドメインの設定から「2. マルチドメインの対象のフォルダをご指定ください」で指定したディレクトリに、WordPress用のディレクトリを作成（例えばblog）し、そこに配置する。
4. http://example.com/blog/wp-admin/のようにアクセスし、インストールウィザード通りに設定する。
5. その後、WordPressの管理にアクセスし、設定 > 一般設定 > サイトアドレス (URL)の最後の/blogを削って、保存する

これで http://example.com/ でWordPressにアクセスできる様になり、かつ、ドキュメントルート/blogディレクトリにWordPressのファイルをまとめることができる。