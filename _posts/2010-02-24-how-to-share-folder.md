---
layout: post
title:  VirtualBoxでのフォルダ共有の設定
date:   2010-02-24 12:00:00 +0900
categories: tech
---

VirtualBoxでゲストOSとホストOSとのフォルダ共有するための設定を記録しておきます。

フォルダ共有
------------

共有するフォルダを作成し、ゲストOSの設定からデバイス＞共有フォルダから追加する。


カーネルのインストール

	# yum install kernel-devel


ゲストOSの設定からデバイス＞Guest Additionsのインストールを選択し、マウントする。

	# cd /mnt/
	# mkdir /cdrom
	# mount /dev/cdrom /mnt/cdrom

VBoxLinuxAdditions-x86.runを実行する。

	# cd /mnt/cdrom
	# ./VBoxLinuxAdditions-x86.run

共有フォルダをマウントする。

	# mkdir /mnt/share
	# mount -t vboxsf VBoxShare /mnt/share

起動時にマウントするように設定する。

	# vi /etc/rc.local

マウントポイントを追加する

	#!/bin/sh
	#
	# This script will be executed *after* all the other init scripts.
	# You can put your own initialization stuff in here if you don't
	# want to do the full Sys V style init stuff.
	
	touch /var/lock/subsys/local

	# 
	mount -t vboxsf share /mnt/share


