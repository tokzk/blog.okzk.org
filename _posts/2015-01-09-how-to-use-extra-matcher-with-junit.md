---
layout: post
title: JUnitでgreaterThan等の比較マッチャーを使う
date: 2015-01-09 15:53:28 +0900
categories: tech
---

JUnit 4.12はhamcrest-coreに依存しているが、greaterThan等は、hamcrest-libraryににあるので、そちらをpom.xmlに記載する。

```
<dependency>
  <groupId>org.hamcrest</groupId>
  <artifactId>hamcrest-library</artifactId>
  <version>1.3</version>
  <scope>test</scope>
</dependency>

```

```
import static org.hamcrest.Matchers.*;
import static org.junit.Assert.assertThat;
```