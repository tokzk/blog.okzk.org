---
layout: post
title:  Install of CentOS5
date:   2008-12-04 12:00:00 +0900
categories: tech
---

CentOS5のインストールメモを記録しておきます。

## インストール時設定

  * linux text<enter>
  * Choose a Language --> English
  * Keyboard Type --> us
  * Installation Method --> HTTP
  * Configure TCP/IP --> Enable IPv4 support Dynamic IP configuration (DHCP)
  * HTTP Setup --> ftp.riken.jp / Linux/centos/5/os/i386
  * Welcome to CentOS
  * Warning --> Yes
  * Partitioning Type --> Remove all partitions on selected drives and create default layout.
  * Warning --> Yes
  * Review Partition Layout --> Yes
  * Partitioning --> OK
  * Low Memory --> Yes
  * Boot Loader Configuration --> Use GRUB Boot Loader
  * Boot Loader Configuration --> OK
  * Boot Loader Configuration --> OK
  * Boot Loader Configuration --> OK
  * Boot Loader Configuration --> OK
  * Configure Network Interface --> No
  * Hostname Configuration --> automatically via DHCP / manually 
  * Time Zone Selection --> Asia/Tokyo
  * Root Password --> ********
  * Package selection --> [*] Customize software selection
  * Package Group selection --> [*] Editors
  * Installation to begin --> OK
  * Complete --> Reboot (デバイス->CD/DVD-ROMのマウント解除後)
  * shutdown -h now
  * ネットワーク -> アダプタ1 -> ホストインターフェース
