---
layout: post
title:  Emacs22のインストール
date:   2008-11-06 12:00:00 +0900
categories: tech
---

Emacs22をインストールしたので、作業ログを記録しておきます。

## aptから

aptダウンロード先の編集

	# vi /etc/apt/source.list
	deb http://hype.sourceforge.jp/ ./
	deb-src http://hype.sourceforge.jp/ ./

鍵の追加

	# wget http://hype.sourceforge.jp/A7F20B7E.gpg
	# sudo apt-key add A7F20B7E.gpg

インストール

	# aptitude install emacs22 emacs22-el

## ソースから

	$ wget ftp://ftp.gnu.org/pub/gnu/emacs/emacs-22.3.tar.gz
	$ tar xzvf emacs-22.3.tar.gz
	$ cd emacs-22.3
	$ ./configure --prefix=/usr/local/emacs-22.3
	$ make
	$ su
	# make install
	# ln -s /usr/local/emacs-22.3/bin/emacs /usr/local/bin/emacs

