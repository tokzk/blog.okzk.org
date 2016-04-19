---
layout: post
title:  OpenPNEの構成ディレクトリ
date:   2008-07-07 12:00:00 +0900
categories: tech
---

OpenPNEを使うことになったので、OpenPNEの構成ディレクトリを記録しておきます。

## OpenPNE構成ディレクトリ

	.
	|-- config.php				設定ファイル
	|--	bin/					Cron、メール処理等コンソールで行うスクリプト
	|-- lib/					OpenPNE外ライブラリの格納場所
	|	|--	include/			PEAR等ライブラリの格納場所
	|	`--	smarty_plugins/		Smarty用プラグインの格納場所
	|-- public_html				Apacheで公開されるドキュメントルート
	|   |-- cmd/				小窓用JS格納ディレクトリ
	|   |-- flash/				Flash格納用ディレクトリ。フレンドリスト用SWFのみ
	|   |-- img/				公開画像ディレクトリ
	|   |-- js/					公開JavaScriptディレクトリ
	|   |-- modules/			モジュール別公開ファイル
	|   |-- openid/				OpenID用コントローラ
	|   |-- skin/				スキン格納ファイル
	|   |-- cap.php				キャプチャ作成PHP
	|   |-- config.inc.php		初期設定用PHP
	|   |-- img.php				画像用フィルタ
	|   |-- img_skin.php		スキン用フィルタ
	|   |-- index.php			フロントコントローラ
	|   `-- xhtml_style.php		カスタムCSS用PHP
	|-- setup					セットアップ用
	|   |-- script
	|   `-- sql					セットアップ用SQLファイル
	|       |-- mysql40			MySQL4.0用SQL
	|       |-- mysql41			MySQL4.1用SQL(大幅に変更があったため)
	|       |   |-- install		インストール用SQL、テーブル、初期データ
	|       |   |-- option		オプション等(Biz等)SQL
	|       |   |-- update		マイナーバージョンアップ用
	|       |   `-- upgrade		メジャーバージョンアップ用
	|       `-- postgres74		PostgreSQL用
	|-- var						一時ファイル置き場（適時削除してもよい）
	|   |-- function_cache		関数キャッシュ用（ランキング等逐次実行の必要のないもの）
	|   |-- img_cache			画像キャッシュ用
	|   |-- log					ログ用
	|   |-- rss_cache			RSSキャッシュ用（cronから生成）
	|   |-- templates_c			Smartyテンプレートコンパイル済みPHP用
	|   `-- tmp					一時ファイル用（ファイルアップロード用）
	|-- webapp					OpenPNEアプリケーション
	|   |-- lib/				アプリケーション用ライブラリ（OpenPNE用カスタム等）
	|   |-- modules/			モジュールディレクトリ
	|   |   |-- admin/			管理画面モジュール
	|   |   |   |-- init.inc	初期設定ファイル
	|   |   |   |-- do/			処理実行系PHP格納ディレクトリ
	|   |   |   |-- lib/		管理画面モジュール用ライブラリ格納ディレクトリ
	|   |   |   |-- page/		ページ系PHP格納ディレクトリ
	|   |   |   |-- templates/	Smartyテンプレート格納ディレクトリ
	|   |   |   `-- validate/	妥当性検証用INIファイルの格納ディレクトリ
	|   |   |-- api				API用
	|   |   |-- ktai			携帯用
	|   |   |-- openid			OpenID用
	|   |   |-- pc				PC用
	|   |   |-- portal			SNSポータル用
	|   |   `-- setup			セットアップ用
	|   |-- templates			テンプレート
	|   |-- validate			妥当性検証
	|   |-- init.inc			初期設定用
	|   `-- version.php			バージョン情報
	|-- webapp_biz				BIZ機能（予定表、グループウェア、施設管理、ToDo）
	`-- webapp_ext				拡張モジュールの格納ディレクトリ
	


OpenPNEの基本構成
=================

  -	public_html/index.php を使用したフロントコントローラパターン
  -	テンプレート名とアクション名の規約 /{module}/{type}/{action}.php
	  -	module モジュール名
	  	例: admin, pc, ktai, api, openid, portal, setup 等
		パラメータ: m
	  -	type アクションタイプ名
		例: page, do
		パラメータ a prefix
	  -	action アクション名
		例: `csv_member`, `delete_c_admin_user` 等
		パラメータ a suffix

  -	`webapp_ext` による拡張モジュール対応
	`webapp_ext` に置いたファイルは同名のwebappのファイルの代替ファイルとなり
	優先的に実行される。
	
  -	Smartyによるテンプレートエンジンの使用
	テンプレートファイルにSmartyを仕様。JavaScriptの括弧と競合するため
	デリミタを変更している {} -> ({})

  -	ライブラリの内包
	PEARやSmartyのライブラリを内包し環境依存をなくしているため、
	OpenPNE外に依存するライブラリがほぼ存在しない。

  -	小窓機能による他サイトAPIとのMashup
	小窓機能と呼ばれるURL自動変換スクリプトにより
	外部サイトのプレイヤー等をOpenPNE内にマッシュアップ可能となる


アクション
==========

  - OpenPNE_Actionを継承し、execute関数をオーバーライドする。
  - 認証外のアクションを作りたい場合はisSecureがfalseを返すようにする。デフォルトtrue
  -	page系
	ページ遷移系のアクションの処理を定義する。画面遷移先はファイル名等同名の
	Smartyテンプレートによって処理される。
	Smartyテンプレートで処理するパラメータはexecute($request)関数で作り、
	処理に問題がなければ関数は"success"を返すようにする。

  - do系
	処理実行系のアクションを定義する。画面遷移先が決まっていないので、
	execute関数の最後で、openpne_forwardで遷移先を指定し、
	ブラウザにLocationヘッダを返し、クライアントリダイレクトを指示する。
	
参考URL
=======
  -	[OpenPNE](http://www.openpne.jp/)
  -	[OpenPNE Document](http://www.openpne.jp/docs)
  -	[OpenPNE Help](http://demo.so-netsns.jp/help/)
  -	[OpenPNE Admin Manual](http://www.so-net.ne.jp/sns/support/index.html)
  -	[Smarty](http://www.phppro.jp/phpmanual/smarty/index.html)

