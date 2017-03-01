---
layout: post
title: モダンなDocker環境の学び方 date:   2017/03/01 17:14:00 +0900
categories: tech
---
チュートリアルを終わらせたところで放置していたDocker。もっとしっかりやらないとなーと思っていたので、久々に触ってみることにした。しかし、バージョンも随分上がっていて、色々変わっていたので、初めから勉強し直すことにした。

{% image how-to-learn-modern-docker.jpg %}

とりあえず、Macだけで考えることにするが、インストール以外は対して変わらないと思うので適宜置き換えてほしい。

## Dockerをインストールする。

まずは、[公式サイト](https://www.docker.com/)を確認する。すべての基本。検索エンジンから飛んだ場合に古いドキュメントなどに行くことがあるので、トップページから辿ったほうがいい。

アプリケーションのインストールには、**Docker for Mac**というパッケージを使うのが薦められているようだ。OSがYosemiteより古ければ別のを使えと書いてあるが、問題ないようなのでDocker for Macを使うことにする。Docker Toolboxとかがあったようだけど、もう忘れよう。

自分は面倒なので、Homebrew経由でインストールすることにした。（これはこれで別途バージョンが最新かどうか等調べた）

    % brew cask install docker

## dockerってなんだ

なにぶん、技術的な定義の文章はそれが全てであるというぐらい重要なのに、格段に目が滑りやすい（個人的なことかもしれないが）なので、じっくり読むことにする。

[What is Docker?](https://www.docker.com/what-docker)

まずは**Docker Engine**について学んでいこう。**Docker Engine**は、Dockerが提供するもの（Dockerオブジェクト)を管理するサーバーと、それを操作するREST API、と管理クライアントのdocker CLIで構成されているクライアント・サーバー型のアプリケーションだということだ。

これは、dockerのversionを確認してみると分かる。

    % docker version

バージョン番号が表示されるが、Client: Server:と二種類それぞれの番号が表示されるのだ。

2017年2月現在。Docker のバージョンは1.13.1。
ブログを見てみると最近、大きく変更のあるバージョンアップをしたらしい。

- [Introducing Docker 1\.13 \- Docker Blog](https://blog.docker.com/2017/01/whats-new-in-docker-1-13/)

docker CLIが扱うコマンドの数が増えたので、どうやら1.13で再構成するようになり、コンテナ操作とイメージ操作は以下のように階層化されたようだ（以前のままでも動く）

- `docker container COMMAND` # Dockerコンテナを操作
- `docker image COMMAND`     # Dockerイメージを操作

他にも、`docker system`やら`docker network`など様々な管理コマンドがある。**とりあえずは、このcontainerとimageの2種類を覚えておくことにする。**

過去との互換性を維持しているので同じ動作が色んなコマンドで動くようになっているため、結構混乱する。

コンテナの一覧を確認するコマンド一つをとっても

- `docker ps`
- `docker container ps`
- `docker container ls`

等があるが、エイリアス（別名）なだけで同じコマンドのようだ。
新しく追加された形式で覚えていくことにする（これが推奨だろう）
詳しくは`docker help`を実行して見よう。

## 実践

まずは、以下のコマンドを実行してみよう。

```
% docker container run -d -p 8888:80 --name webserver nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
5040bd298390: Pull complete
31123d939af1: Pull complete
23f1bdd267a9: Pull complete
Digest: sha256:4296639ebdf92f035abf95fee1330449e65990223c899838283c9844b1aaac4c
Status: Downloaded newer image for nginx:latest
29ed6e9125cc037119b810816075120e30f2370514e1e26a826a59e6022a3071
```

これは、

- 元になるイメージとしてnginxという名称のものをダウンロード
- 生成するコンテナはwebserverと命名
- コンテナのポート番号80番をホストOSの8000番にマッピング
- detachモード(コンテナをバックグラウンド）
- コンテナを生成して起動

という意味のようだ。


webserver を webserver2 とでもしたらnginxイメージを元に別のコンテナを立ち上げることができるだろう。

立ち上がってるコンテナを確認するには以下

```
% docker container ls
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                           NAMES
29ed6e9125cc        nginx               "nginx -g 'daemon ..."   50 seconds ago      Up 49 seconds       443/tcp, 0.0.0.0:8888->80/tcp   webserver
```

さらに起動しているかどうか試してみる。

```
% open http://localhost:8888
```

問題なく起動しているようだ。

{% image how-to-learn-modern-docker-1.png %}

コンテナを終了する場合は、以下を実行

```
% docker stop webserver
webserver
```

もう一度確認してみよう。

```
% docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

無事停止しているようだ。
停止してるコンテナも含めて確認するのは以下で出来る。

```
% docker container ls -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                     PORTS               NAMES
82b61d3bdc6c        nginx               "nginx -g 'daemon ..."   17 seconds ago      Exited (0) 5 seconds ago                       webserver
```

`-a` はallの略だ。`docker ps --help`で確認できる。
このコンテナは停止をしているだけなので、以下で再度起動できる。

```
% docker container start webserver
webserver
```

では、実際もう使わなくなって削除したい場合はどうするか？  
まずは、コンテナの動作を停止する。

```
% docker container stop webserver
webserver
```

その後、コンテナを削除する

```
% docker container rm webserver
webserver
```

さて、再度確認してみよう。

```
% docker container ls -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

見事になくなっている。

しかし、これはコンテナを削除しただけなので、元になるイメージは存在している。なので、改めてコンテナを作っても今度は、イメージのダウンロードを飛ばして瞬時にコンテナを作成できる。

```
% docker container run -d -p 8888:80 --name webserver2 nginx
cf82067ae97bd95b59cbc516a3f9d94843ed85cb0f5365408d8f57c149445211
% docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                           NAMES
cf82067ae97b        nginx               "nginx -g 'daemon ..."   15 seconds ago      Up 14 seconds       443/tcp, 0.0.0.0:8888->80/tcp   webserver2
```

それではイメージを削除してみよう。  
まずはコンテナの削除から。

```
% docker container rm -f webserver2
webserver2
```

`-f`は起動しているコンテナも強制的に削除する。forceの略だ。これも`docker rm --help`で確認できる。

次にイメージ一覧を表示してみよう。

```
% docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
nginx               latest              db079554b4d2        11 days ago         182 MB
```

イメージの削除は以下のようにして行う。

```
% docker image rm nginx
Untagged: nginx:latest
Untagged: nginx@sha256:4296639ebdf92f035abf95fee1330449e65990223c899838283c9844b1aaac4c
Deleted: sha256:db079554b4d2f7c65c4df3adae88cb72d051c8c3b8613eb44e86f60c945b1ca7
Deleted: sha256:df27efc40487633097ad83e255b23f053ce4878157edb4ca574cde556a82033f
Deleted: sha256:d7b15d95395e412bafd0edd29bf60d53e34d32f087b8bf28f5659b023b922feb
Deleted: sha256:a2ae92ffcd29f7ededa0320f4a4fd709a723beae9a4e681696874932db7aee2c
```

削除されているか確認しよう。

```
% docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
```

見事に削除されている。  
これでdockerの基本的な仕組みと動作は理解できた。
あとは細かいコマンドに関しては`--help`を使用すればいいだろう。

## 結論

このブログをいずれ古くなるので、すべては公式を確認しよう（という元も子もない結論）

今度は、docker-compose コマンドなどで複数のコンテナを使った開発環境の構築などをやっていきたい。
