---
layout: post
title:  Apacheの起動スクリプト
date:   2009-03-31 12:00:00 +0900
categories: tech
---

Apacheの起動スクリプトの設定を記録しておきます。


	
	#!/bin/sh
	# chkconfig: 345 98 20
	# description: This shell script tabke care of starting and stopping httpd.
	# processname: httpd
	#
	# httpd         This shell script takes care of starting and stopping
	#               httpd.
	#
	# 
	
	RETVAL=0
	prog="/usr/local/apache2/bin/apachectl"
	
	# See how we were called.
	case "$1" in
	  start)
	        $prog startssl
	        RETVAL=$?
	        ;;
	  stop)
	        $prog stop
	        RETVAL=$?
	        ;;
	  status)
	        $prog status
	        RETVAL=$?
	        ;;
	  restart|reload)
	        $prog restart
	        RETVAL=$?
	        ;;
	  *)
	        echo $"Usage: $0 {start|stop|restart|status}"
	        exit 1
	esac
	
	exit $RETVAL


chkconfigで自作の起動スクリプトを登録
-------------------------------------

	# chkconfig: 345 98 20
	# description: This shell script tabke care of starting and stopping httpd.
	# processname: httpd

起動スクリプトのヘッダにchkconfig用の記述をする。
上から、ランレベル、起動優先順位、停止優先順位

	/sbin/chkconfig --add httpd
	/sbin/chkconfig --level 345 httpd on
	/sbin/chkconfig --list
