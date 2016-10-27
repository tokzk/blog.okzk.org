---
layout: post
title:  SpriteKitで可変サイズのボタンやダイアログを作る方法
date:   2016-10-27 19:30:00 +0900
categories: tech
---
SpriteKitでゲームのUIを作っている時に、ボタンやダイアログ、パネル的なものを作りたいが、画面サイズが色々あるので、その分画像を用意するのは面倒くさい。枠だけ決まっていて、伸縮可能にしてサイズは実行時に決定したいという要求は、ままあると思います。

他のゲームエンジンでもあると思いますが、SpriteKitでもちゃんと対応していました。
しかし、これを実装するに辺り、参考になるものがあまりなく（多分昔からある当たり前の技術なので）、色々試していると、うまくいかないことがありました。
しかしこれは単に自分の勘違いからくるもので、実際は簡単でしたのでハマりごとも踏まえて説明したいと思います。

まずは、この手法の名称について。

- **9 Slice Scaling**
- **9 patch**

などと呼ばれる手法で、テンプレートを9つの分けることで、画像の中で、伸縮する所としない所を分けて、自由なサイズの伸縮に対応します。

Googleなどで、上記の用語で、画像検索すると大量に画像が出てきますので確認してみてください。。

SpriteKitもこの手法に対応していて、ドキュメントにも記載されています。

- [Resizing a Sprite: SpriteKit Programming Gude](https://developer.apple.com/library/ios/documentation/GraphicsAnimation/Conceptual/SpriteKit_PG/Sprites/Sprites.html#//apple_ref/doc/uid/TP40013043-CH9-SW10)

### 基本的な9-sliceの使い方

使い方としては、

1. テクスチャを読み込む
2. 真ん中のエリアを指定することで画像を9分割する
3. 指定のScaleに変更することで、伸縮する

という工程で、極めて簡単に作業が完了します。

まずは、テンプレートなるような、以下のような画像を用意します。

{% image spritekit-9slice.png %}

上記のテンプレートを元に、9-slice画像をSwiftで書いてみると

```swift
let texture = SKTexture(imageNamed: “stretchable_button.png”)
let button = SKSpriteNode(texture: texture)
let rect = CGRect(x: 12.0/28.0, y: 12.0/28.0, width: 4.0/28.0, height: 4.0/28.0)
button.centerRect = rect
button.xScale = 200 / texture.size().width
button.yScale = 100 / texture.size().height
```

このようになります。

重要なのはcenterRectで指定されたCGRectで、これは、縦横28pixelの画像を(12, 12)の位置から4pixelの幅で区切り、その中を伸縮するということを示しています。

ここまでは、ネットで調べても分かる情報でした。

### 非対称テンプレートでの9-slice

しかし、この後、この機能の応用で、パネルにタイトルのエリアを用意して、タイトルエリアを残しつつ、伸縮可能なもの、つまりは上下左右の対称性のないテンプレートを用いた場合に問題が起こりました。

分かってしまえばなんてことないのですが、CGRectに関して、以下のような印象を持っていたために、ドハマリしてしまった自分は、だいぶ時間を費やしてしまいました。

{% image spritekit-9slice-bad.png %}

これはSpriteKitでは間違いになります。
正確には、以下のようになります。

{% image spritekit-9slice-good.png %}

SpriteKitは左下を(0,0)とした座標を持ってますので、width, heightなどは下から上、左から右のベクトルになります。
このため、CGRectを作成する際に、底辺からの位置にしないと問題が起こります。

最初の例の場合は、サイズの取り方が上下左右すべて、12pixelと共通であったため、問題になりませんでしたが、ここではテクスチャの伸縮がおかしくなります。

SpriteKitを始めると、座標は左下が(0,0)だということは最初に学ぶことでもあります。
ここで改めて、頭に刻んでおきましょう。

**SpriteKitの座標は左下が(0,0)**





