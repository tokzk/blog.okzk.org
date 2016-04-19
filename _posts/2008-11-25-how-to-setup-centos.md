---
layout: post
title:  Configuration of CentOS5
date:   2008-11-25 12:00:00 +0900
categories: tech
---

CentOSをインストールした時の設定メモです。

インストール時設定
------------------

  * text install
  * Server 

インストール後設定
------------------

  * SELinux と Firewall は無効化する。

以下のサービスは停止。

  * apmd
  * auditd
  * autofs
  * bluetooth
  * cups
  * firstboot
  * gpm
  * haldaemon
  * hidd
  * ip6tables
  * kudzu
  * mcstrans
  * netfs
  * nfslock
  * pcscd
  * portmap
  * restorecond
  * rpcgssd
  * rpcidmapd
  * xfs
  * yum-updatesd

以下のパッケージをインストール。

	# yum install yum-fastestmirror
  
yum updateする。

	# yum check-update
	# yum update

さらに以下のパッケージをインストール。

    # yum install yum-utils
    # yum install ntp
    
日付設定

	# ntpdate ntp.nict.jp

cronで定期実行

	# vi /etc/cron.daily/ntpdate.cron

以下のファイルを作る

	#!/bin/sh
	/usr/sbin/ntpdate ntp.nict.jp

実行権限の付与

	# chmod 755 /etc/cron.daily/ntpdate.cron

一般ユーザを追加。

	# useradd -m -p xxxxxxxx <username>

Software Install

	# yum install gcc
	# yum install cvs
	# yum install lynx

NcFTPはCentOS5は入っていないので、ソースから。(lftpは入ってる)

	# wget ftp://ftp.ncftp.com/ncftp/ncftp-3.2.2-src.tar.gz	

CentOSのデフォルトのyum repositoryは少ないので dag 追加

	# vi /etc/yum.repos.d/dag.repo

以下のファイルを作成

	[dag]
	name=Dag RPM Repository for RHEL5/CentOS5
	baseurl=http://ftp.riken.jp/Linux/dag/redhat/el5/en/$basearch/dag/
	enabled=0
	gpgcheck=1

鍵の登録

	# rpm --import http://dag.wieers.com/rpm/packages/RPM-GPG-KEY.dag.txt

確認

	# yum --enablerepo=dag list | grep git
