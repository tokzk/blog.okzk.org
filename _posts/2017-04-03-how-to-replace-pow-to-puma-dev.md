---
layout: post
title: PowからPuma-devへ切り換える
date:   2017/04/03 14:20:00 +0900
categories: tech
---
Railsの開発を複数行っている時、一々サーバ起動するのが面倒なので、Powを使用して、`http://rails-app.dev/`、 `http://rails-app2.dev/`のような形で、アクセス出来るようにしてある。すこしその環境に不満が出てきたので新たなツールへ置き換えてみることにする。

{% image how-to-replace-pow-to-puma-dev.png %}


## 背景

Railsを5.1にあげたら、Powの操作に使用していた[powder]からwarningが出ていた。[PullRequest]も出ているようだが、マージされる気配がないのでどうしようか悩んだ。
[specific_install]でPR版のpowderをインストールしようかと思ったが、そこまでするのもなぁと思い、Powの代替手段はないかなぁと探していたら、[Puma-dev]というのがあるではないか。

というわけで、乗り換えてみることにした。

[powder]: https://github.com/rodreegez/powder
[PullRequest]: https://github.com/rodreegez/powder/pull/127
[specific_install]: https://github.com/rdp/specific_install
[Puma-dev]: https://github.com/puma/puma-dev

## インストールと設定

まずは、Powのアンインストール

    % curl get.pow.cx/uninstall.sh | sh

そして、Puma-devのインストール

    % brew install puma/puma/puma-dev
    % sudo puma-dev -setup
    % puma-dev -install

{% image how-to-replace-pow-to-puma-dev1.png %}

途中、システム証明書信頼設定のダイアログがでる。
/etc/resolver というのが作成されている。

Railsのディレクトリに移動して、`puma-dev link`を実行すればOK

    % cd ~/dev/rails-app
    % puma-dev link
    % open http://rails-app.dev/

上手く動かなかった場合などは、ログを確認する。`~/Library/Logs/puma-dev.log` がそのログになる。毎回打つのは面倒なのでaliasでも作っておく。.zshrcにでも入れておく。

```
% alias puma-log='tail -f ~/Library/Logs/puma-dev.log'
```

試しに、開発環境に残っていたRails3.2の環境でもGemfileにpumaを追加したら動作した。

```
group :development do
  gem 'puma'
end
```

---

{% amazon B016WKJQVK detail %}
