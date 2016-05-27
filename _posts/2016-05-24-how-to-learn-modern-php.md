---
layout: post
title: モダンなPHPの開発の学び方 date:   2016-05-24 20:30:00 +0900
categories: tech
---

簡単なPHPのお仕事を頂きまして、ソースコードを見てみると、10年前に見たような中々レガシーな感じ。とはいえ、久々のPHPの仕事で、自分の知識もCakePHP1.Xを使用した当時で止まっているので、知識のアップデートがてら、ソースコードをリファクタリングすることにしました。
その際に集めた情報ややったことなどを、列挙していきます。

## The Right Way

まずは、みんなどういう開発をしてるんだろうなぁと調べる時のキーワードですが、こういう時は「最新」とかで調べても上手くヒットしません。「モダン」は割といいキーワードだと思います。とりあえず「モダン PHP」とかで検索したところをざっと眺めます。

最近は、GitHubで「awesome ◯◯」で調べると、◯◯関連の情報をまとめたドキュメントなどがあるのでそれも参考にします。

そして見つけたのがこれ。

[PHP: The Right Way](http://www.phptherightway.com)

ここを見とけば、一通りはOKなのではないでしょうか。
このなかで、適用できそうなものをどんどん採用していくことにします。

## 開発環境

### ディレクトリ構成

```
bin/      # 実行ファイルを配置
etc/      # 設定ファイルを配置
public_html/  # HTML,PHPを配置
src/      # ライブラリを配置
tests/    # テストを配置
tmp/      # テンポラリ
```

#### bin/

`bin`には開発に便利なシェルスクリプトなどを置いておきます。
どんなときでも使えそうなものはエイリアスを.bashrcに書いとくといいかも。
今回はビルトインウェブサーバの起動スクリプトを書いておきます。

#### etc/

設定ファイルなどを入れておきます。
今回の場合はphp.iniなどがあるでしょう。開発用と本番用などもまとめて入れておきます。

#### src/

今回作るPHPを入れておきます。できれば、ライブラリとしてなるべく汎用的にしていき独立させていきたいところですが、今回はある程度のところで止めておきます。

#### tests/

リファクタリングするには、まずテストを書きます。今回はユニットテストを書く意味はあまりなさそうなので、エンドツーエンドテストだけ書いておきます。

#### tmp/

作りかけとかいらなくなったものとかは`tmp/`にぶち込んでおきます。
`.gitignore`には`tmp/`とだけ書いておけば、`tmp/`以下はリポジトリにはコミットされません。`git status`などでも余計なファイルが表示されないようにします。

#### README.md

プロジェクトの詳細や、インストール等の条件、サーバの詳細などはここに記載しておきます。
githubなりbitbucketなりでトップページに表示される内容になるので、関係者に知らせたい項目や、コーディング規約等を書いておいたりします。

### ローカルサーバ

以前はXAMPPとかローカルのApacheなどがありました。Ruby on Railsで[Pow](http://pow.cx/)を使ってた場合などに併用に苦労した覚えがありますが、現在はビルトインウェブサーバがあるようなので、それを使用することにします。

以下のようなファイルをワーキングディレクトリに配置して、`./bin/phpd`とかでサーバを起動するようにします。

```shell
#!/bin/sh

abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(readlink "$name" || true)"
  done

  pwd -P
  cd "$cwd"
}

script_dir="$(abs_dirname "$0")"

php -S localhost:8123 -c $script_dir/../etc/php.ini-development -t $script_dir/../public_html
```

開発サーバの設定は`etc/php.ini-development`に配置しておきます。

```
display_errors = On
display_startup_errors = On
error_reporting = -1
log_errors = On
output_buffering = On
sendmail_path = /usr/bin/env catchmail
```

### メールサーバ

今回はメールを飛ばすプログラムなので、ダミーのSMTPサーバを用意しておきます。
メールはテスト中に実際に飛んでいってしまうとトンデモナイことになることが多いので注意が必要です。

Railsでは[letter_opener](https://github.com/ryanb/letter_opener)や<http://mailtrap.io/>などで対応していましたが、今回はローカルのsendmail(postfix)を使う代わりに、[MailCatcher](https://mailcatcher.me/)を使うことで対応します。

`php.ini-development`の最下行に加えた一文でプログラムが送信したメールはMailCatcherが拾ってWebで確認できるようなります。

以下のようなファイルを`bin/`に置いておくと、しばらく立って忘れたとき、思い出すきっかけになるので簡単なものでも作っておいたりします。

```
#!/bin/sh
maicatcher && open http://localhost:1080/
```


### Composer

ライブラリの依存性管理は、最近は`PEAR`は使わず、`Composer`というもので、venderディレクトリ以下にインストールするのが一般的だそうで、Rubyでいうところの`Bundler`のようなもののようです。
今回はPHPUnitとSeleniumを簡単に使えるFacebookのライブラリ`php-webdriver`を使って、E2Eのテストだけ書いておくことに。
ここらへんは長くなりそうなので別途要望があれば書きます。

## リファクタリング

### クラスローダー

元のファイルをみたところ、クラスの文字もないようなベタ書きのPHPスクリプトでした。
これをどんどんクラス化していくなかで、今までの感じだと、`require_once`を列挙してクラスを読み込むことになってしまう。

しかし、現在は、命名規則とクラスローダーを使うことで煩雑な作業を省略することができる。
まずは、[jwagejwage/SplClassLoader.php](https://gist.github.com/jwage/221634) でクラスローダーをダウンロードしてきて、`src/`に配置すします。

`./public_html/phptest.php`というファイルを用意して、以下のように記述し、`SplClassLoader.php`を読み込みます。


```./public_html/phptest.php
<?php

require_once '../../src/SplClassLoader.php';
$classloaderTest = new SplClassLoader(’Test’, __DIR__ . '/../../src');
$classloaderTest->register();

$entry = new \Test\Entry();
$entry->run();

```

`./src/Test/Entry.php`を用意して、以下のように記述する。

```
<?php

class Entry {
    public function run() {
        echo ‘Hello World’;
    }
}
```

`./bin/phpd`を起動し、http://localhost:8123/phptest.php をブラウザで表示する。

`Hello World`と表示されたら成功。問題があれば、ウェブサーバのログを確認して修正する。

### コーディング規約

各フレームワークで乱立していたコーディング規約が最近は、皆で統一しようとなったようで、[PHP-FIG](http://www.php-fig.org/)で扱っている、PSR(PHP Standards Recommendations)というのに集約されつつあるようです。郷に入らば郷に従えなので、これに従って行きましょう。

大体のポイントを抑えれば、大分綺麗になるようです。
正確な記述はPSRを見てもらい、ここでは、以下のような感じで作っていきます。

- namespaceを作る。
- ベンダー名\パッケージ名\クラス名などがよさそう。
- ディレクトリ名はnamespaceと一致させる。
- ファイル名はクラス名と一致させる。
- ファイルはBOMなしUTF-8で、改行コードはLF。
- PHPのみのファイルは<?phpタグではじめて、閉じタグは書かない（閉じタグ後のスペースや改行が問題になることが多かった）。
- クラスは大文字で始める。
- 定数はクラス内に`const VERSION = ‘1.0’`のような形で記述する。
- プロパティはアンダースコア `$date_approved` のような形で記述する。
- 関数、メソッドはキャメルケース。
- クラスとメソッドの{は宣言の次の先頭に。
- 変数のない文字列はシングルクォーテーションでくくる。
- 変数のある文字列はダブルクォーテーションでくくる。
- 一行が80-120行以内ぐらいでおさまるように。
- 変な省略はしない。
- if文は1行で書かない。カッコは省略しない
- メソッド、プロパティなどはアクセス制限(private public protected)をちゃんとかく。
- タブは使わない、インデントはスペース4文字
- 制御文と引数、引数とカッコの間は1スペース
     - 例：`if(condition){` -> `if (condition){`

あとは`php-cs-fixer`や`PHP_CodeSniffer`というようなコーディングスタイルチェックツールに自動で訂正してもらうのに従うのが楽そう。今回は最終的に、`php-cs-fixer`を使ってます。

###　コードの整形

- まずは、インデント等はツールにまかせて整形する。
- 意味のわからない変数や省略された変数を変更する。
    - `$eles` → `$elements`
    - `$sjb` → `$subject`
- 間違ってそうな変数などを変更する。
    - `$key=>$var` → `$key => $val`
- 途中で変更されない変数は定数に置き換える。
- booleanを0/1で判断しているものはtrue/falseに置き換える。
    - `private $remail = 1` → `const SEND_AUTOREPLY_MAIL = true`
- 複雑すぎたり意味の分かりにくいconditionをメソッドや定数に置き換える。
    - `if($remail == 1){` → `if ($this->isSendAutoreplyMail()) {`
- 深いネストはガード節を使用して早めに判断して抜ける。
- HTMLで記述されてるところを一つのメソッドにまとめる。

```
$err .= "<div class='caution'>「電話番号」は入力必須です。</div>\n";
```

↓

```
$err .= $this->errorMessage(self::ERROR_REQUIRED, ’電話番号’);

private function errorMessage($type, $key)
{
    switch ($type) {
        case self::ERROR_REQUIRED:
            $msg = "<div class='caution'>「".$key."」は入力必須です。</div>\n";
            break;
…
```

などなど。

特に、今回はネストが深すぎたのでガード節で抜けていったら相当シンプルになりました。

## まとめ

3日位で、駆け足で調べてみましたが、さすがはPHPは開発者が多いこともあって情報も多く、最近は大分道が整備されてるように思えます。ブログ等は結構古い（or古くなる)ことも多いので、以下の参考資料等が充実しているのでそちらを参考にするほうがいいでしょう（ここも例外ではないです（笑）

* [PHP: The Right Way](http://ja.phptherightway.com/)を読む
* [PHP Standards Recommendations - PHP-FIG](http://www.php-fig.org/psr/)を読む
* [PHP: Hypertext Preprocessor](http://php.net/)を読む


