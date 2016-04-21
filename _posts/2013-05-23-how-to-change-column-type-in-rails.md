---
layout: post
title: Rails のマイグレーションでカラムのtypeを変更する。ついでにデータも調整する
date: 2013-05-23 19:47:28 +0900
categories: tech
---

Railsのmigration便利やなーって話なんですけど。

とあるシステムのソースコードを見ていたら、気持ち悪いなと思ったところがあったんですよ。
どうみてもbooleanなのに、文字列で扱ってる部分がある。

まぁ、これはよくある話で、特にこのシステムは古いシステムの仕様を引き継いで、Railsで作り直してるもんだから、データ構造がRailsぽくない。（それ以前によくない部分も）

直したい！直したいよ！とまぁ、思うわけです。
んで、まぁ、どこまで影響あるか見てみるわけです。
ところが、気づくんです。なんか変だと。
modelの中では、"true","false"という文字列で判定している。
しかし、viewの選択肢の値は、"0"と"1"。
しかも、"0"と"true"が対応している。
なんだこれはと。

だもんで、データを見てみるわけです。

| id | member |
|:-|:-|
| 1 | 1 |
| 2 | 0 |
| 3 | 1 |
| 4 | true |
| 5 | 1 |
| 6 | false |
| 7 | 1 |
| 8 | true |

これはひどい！

というわけで、これをUI部分を修正し、テーブルもbooleanに変更、データも修正するというリファクタリングを行おうと思い手をつけます。

UIやモデルの変更は簡単に済むのですが、既存のデータをどうするか？

SQLでデータを変更してから、migrationして変更することを考えました。
しかし、実際ローカルでテストしている人にいちいちSQLを実行させるのは面倒。
capistranoでデプロイしてるので、いちいちサーバにつないでSQLを実行してからというのも面倒。

んじゃどうやるのが一番面倒がないか？

となれば、migrationの中でやるのが便利。
（migrationの中ではActiveRecordのModelは使わないでSQL使うのがいいという話もありますが…）

というわけで、できたコードがこちら！

```ruby
class ConvertMemberToBoolean < ActiveRecord::Migration
  def self.up
    # 最終的に変更したいカラムにconvert_と付けて作成
    add_column :seminar_entry, :convert_member, :boolean, :default => false

    # カラム情報のリセット、上記の変更を反映する。
    SeminarEntry.reset_column_information

    # データを変換してセーブ、タイムスタンプを更新したくない場合は以下コメントアウト
    # ActiveRecord::Base.record_timestamps = false
    SeminarEntry.all.each do |e|
      e.convert_member = (e.member == '0') || (e.member == 'true')
      e.save
    end
    # ActiveRecord::Base.record_timestamps = true

    # 旧カラム削除
    remove_column :seminar_entries, :member
    # convert_カラムを対象のカラム名に変更
    rename_column :seminar_entries, :convert_member, :member
  end

  def self.down
    change_column :seminar_entries, :member, :string
  end
end
```

とまぁ、こんな風に書いてmigrationでやっちゃうのが楽でしたという話でした。
