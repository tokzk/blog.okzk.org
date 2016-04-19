---
layout: post
title:  VirtualBoxのゲストOSにアクセスするためのネットワーク設定
date:   2010-02-24 12:00:00 +0900
categories: tech
---

VirtualBoxをインストールしたあとのネットワーク設定の記録をメモしてきます。

ネットワークアダプタ
--------------------

ゲストOSの設定＞ネットワークからネットワークアダプタの設定をし、
ホストとゲスト間の通信を許可し、ゲストから外部への通信を許可する設定を行う。

  * アダプタ1に「ホストオンリーネットワーク」を割り当てる。
  * アダプタ2に「NAT」を割り当てる。


IPアドレスを固定する
--------------------

アダプタの設定

	# vi /etc/sysconfig/network-scripts/ifcfg-eth0

IPを固定にする

	DEVICE=eth0
	BOOTPROTO=static
	HWADDR=08:00:27:2C:06:13
	ONBOOT=yes
	IPADDR=192.168.56.102
	NETMASK=255.255.255.0

アダプタの再起動

	# ifdown eth0
	# ifup eth0
