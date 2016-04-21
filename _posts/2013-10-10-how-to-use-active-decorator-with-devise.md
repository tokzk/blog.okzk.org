---
layout: post
title: Devise と ActiveDecorator の連携
date: 2013-10-10 18:34:28 +0900
categories: tech
---
[ActiveDecorator](https://github.com/amatsuda/active_decorator) はモデルをとてもスッキリさせてくれるので好き。
ところが、何も考えずに、Deviseのcurrent_userでも使えると思って

```
<% if user_signed_in? %>
  <%= current_user.icon %>
<% end %>
```

とか書いたところ、エラーが。まぁ、そうだよね。 というわけで、ソース見て、こんな感じで、ApplicationController に Deviseのhelperをoverrideしたメソッドを書いた。

```
class ApplicationController < ActionController::Base

  def current_user
    ActiveDecorator::Decorator.instance.decorate(super) unless super.nil?
    super
  end
end
```