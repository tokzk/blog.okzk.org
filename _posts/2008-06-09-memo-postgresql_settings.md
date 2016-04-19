---
layout: post
title:  PostgreSQLの初期設定
date:   2008-06-09 12:00:00 +0900
categories: tech
---
いつもやるPostgreSQLの初期設定を記録しておきます。

$PGDATA/postgresql.conf を書き換える。

### オートバキュームの設定

	# AUTO VACUUM SETTING
	autovacuum = on
	stats_row_level = on

### ログファイルの設定

	# LOG FILE SETTING
	redirect_stderr = on
	log_line_prefix = '<%t %u %d %p>'
	log_min_duration_statement = 3s

