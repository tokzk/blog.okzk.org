---
layout: post
title:  SELinuxの無効化
date:   2009-03-31 12:00:00 +0900
categories: tech
---

SELinuxの無効にするための設定を記録しておきます。

SELinuxの状態確認

	# getenforce
	Enforcing
	
SELinux無効化

	# setenforce 0

	# getenforce
	Permissive

SELinux設定ファイル編集

	# vi /etc/sysconfig/selinux
	SELINUX=enforcing
	↓
	SELINUX=disabled


iptables の停止

    # /etc/init.d/iptables stop

iptables を停止せず、httpを通す設定を追加する場合。
/etc/sysconfig/iptables を編集

	-A RH-Firewall-1-INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT 
	-A RH-Firewall-1-INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT 
	-A RH-Firewall-1-INPUT -j REJECT --reject-with icmp-host-prohibited 

真ん中の行を追加する。

