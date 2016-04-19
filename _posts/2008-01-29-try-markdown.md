---
layout: post
title:  Mark Up 2 Down
date:   2008-01-29 12:00:00 +0900
categories: tech
---

仕事で、インストールマニュアルを作ることが多々あるのだが、
バージョン管理に入れるものはなるべくテキストフォーマットでありたい。
しかし、Wiki記法などでは他人(プログラマ外の人間)にわかりづらいので
出来るだけシンプルなものがいい。そしてなるべく簡単に他のフォーマットへ
変換できるものが欲しい。  
[Markdown] というのがいいらしいので、その記法を採用することにした。

[Markdown]: http://daringfireball.net/projects/markdown/

## コンバータの導入
早速、インストールマニュアル等を書き直して、HTML に変換することに。
まずは、Windows用に簡単に変換できるコンバータを探したところ、
[Pandoc] なるものを発見。早速導入する。LinuxなりMacOSなりはもっと簡単に導入できそう。
文字コードが UTF-8 しか通らないようなので [KaoriYa.net] 
で配布している Windows 版の iconv を使用させてもらうことに。

- [Pandoc - Windows binary package](http://code.google.com/p/pandoc/downloads/detail?name=pandoc-0.46.zip)
- [iconv.exe](http://www.kaoriya.net/dist/iconv-1.10-20060516-dll.tar.bz2)

上記の二つを展開し、`pandoc.exe`, `iconv.exe`, `iconv.dll` をPATHの通ったディレクトリに。  
(自分の場合は、`c:\opt\bin` に配置)

[Pandoc]: http://johnmacfarlane.net/pandoc/
[KaoriYa.net]: http://www.kaoriya.net/

## バッチファイルの作成
1つのファイルに全てを書いてしまうと、後々管理が面倒なので
表示順に番号を振り、バッチ処理で一気に変換することに。
かなり適当ですが、以下を `mark2html.bat` として `c:\opt\bin` に配置。


	@ECHO OFF
	IF (%1)==() GOTO NoParams
	IF (%2)==() GOTO ConvertAll
	:ConvertOne
	
	iconv -t UTF-8 %2 | pandoc.exe -s -S --toc -A footer.html -c pandoc.css -o %1
	
	GOTO Bottom
	
	:ConvertAll
	CD . > tmptmp
	FOR %%B IN (*.txt) DO copy /A tmptmp + %%B tmptmp
	
	iconv -t UTF-8 tmptmp | pandoc.exe -s -S --toc -A footer.html -c pandoc.css -o %1
	
	DEL tmptmp
	
	GOTO Bottom
	:NoParams
	ECHO 使用方法  mark2html [作成するファイル名] [入力するファイル名]
	ECHO.
	ECHO  例 - mark2html output.html
	ECHO    カレントディレクトリにある全ての .txt ファイルを
	ECHO    指定されたファイルに変換します。
	ECHO  例 - mark2html output.html input.txt
	ECHO    input.txt を 指定されたファイルに変換します。
	ECHO.
	:Bottom

