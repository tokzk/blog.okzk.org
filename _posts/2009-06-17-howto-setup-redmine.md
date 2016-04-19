---
layout: post
title:  Redmine環境の構築
date:   2009-06-17 12:00:00 +0900
categories: tech
---
RedMine環境の構築したので、記録をとっておきます。

Ruby のインストール
---------------

	# yum install ruby-devel ruby-rdoc ruby-irb
	# yum install rubygems

	# gem update --system
 	# gem install rubygems-update
	# update_rubygems
	# gem install rake

ImageMagick のインストール
--------------------------
新しいのが必要なので、yumだと古かった。

	$ tar xzvf ImageMagick.tar.gz 
	$ cd ImageMagick-6.4.2
	$ ./configure
	$ make 
	# make install

	# gem install rmagick

MySQLのインストール
-------------------

	# yum install mysql-server

Rails のインストール
------------------------

	# gem install -v=2.2.2 rails
	# gem install mysql -- --with-mysql-dir=/usr/lib/mysql --with-mysql-config

RedMineのインストール
---------------------

	$ svn co http://redmine.rubyforge.org/svn/trunk redmine

### 設定のファイルを修正
config/database.yml

	production:
	  adapter: mysql
	  database: redmine
	  host: localhost
	  username: redmine
	  password: 
	  encoding: utf8
	  socket: /var/lib/mysql/mysql.sock

### MySQLにRedMineアカウントを追加

	mysql> GRANT ALL PRIVILEGES ON *.* TO 'redmine'@'%';
	    -> IDENTIFIED BY 'password' WITH GRANT OPTION;
	mysql> GRANT ALL PRIVILEGES ON *.* TO 'redmine'@'localhost';
	    -> IDENTIFIED BY 'password' WITH GRANT OPTION;

### DBの移行
	$ mysqladmin create --default-character-set=utf8 redmine
	$ mysql -u redmine -p redmine < redmine.dump.sql
	
### DBのmigrate
	$ rake db:migrate RAILS_NEW="production"

### fileの移行
	$ scp from.localnet:~redmine/redmine/files/* ./files/


### 起動テスト

	$ ruby script/server -e production
	
	w3m http://localhost:3000/
	
	Internal Server Error とか出たら、log/production.log を確認
	config.action_controller.session = { :session_key => "_myapp_session", :secret => "some secret phrase of at least 30 characters" }
	を config/environment.rb に設定しろとか書いてあったりする。


Passenger のインストール
------------------------

	$ gem install passenger
	 2. fastthread 1.0.1 (ruby)
	
	$ export PATH=$PATH:/usr/local/apache2/bin
	$ export APXS2=/usr/local/apache2/bin/apxs
	$ export APR_CONFIG=/usr/local/apache2/bin/apr-1-config
	$ passenger-install-apache2-module

 1. The Apache 2 module will be installed for you.
	足りないものを入れる。gppとか

Apache の設定
-------------

	  LoadModule passenger_module /usr/lib/ruby/gems/1.8/gems/passenger-2.2.2/ext/apache2/mod_passenger.so
	   PassengerRoot /usr/lib/ruby/gems/1.8/gems/passenger-2.2.2
	   PassengerRuby /usr/bin/ruby
	   <VirtualHost *:80>
	      ServerName redmine.xxxxxxxx.jp
	      DocumentRoot /opt/redmine/redmine/public
	   </VirtualHost>

Apache2 の 403とかだと Deny from allをチェック