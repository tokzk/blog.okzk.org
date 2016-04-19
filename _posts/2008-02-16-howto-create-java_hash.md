---
layout: post
title:  Javaで簡単なHashの作り方
date:   2008-02-16 12:00:00 +0900
categories: tech
---
Rubyのように早くて簡単に作れるHashをJavaで実現できないか書いてみました。


まずはRuby
	name = {"title", "mr", "first", "craig", "last", "davidson"}

Javaでは通常以下のようになる。

	public void testBuildAHashNormally(){
	
	     Map slow = new HashMap();
	     slow.put("title", "mr");
	     slow.put("first", "craig");
	     slow.put("last", "davidson");
	
	     assertEquals("mr", slow.get("title"));
	     assertEquals("craig", slow.get("first"));
	     assertEquals("davidson", slow.get("last"));
	}

それを以下のようにしてみたい。

	public void testBuildAHashQuickly(){
	
	     Map quick = new Hash("title", "mr",
	                "first", "craig", "last", "davidson");
	
	     assertEquals("mr", slow.get("title"));
	     assertEquals("craig", slow.get("first"));
	     assertEquals("davidson", slow.get("last"));
	}

それは以下のようにHashを拡張すればいい。

	public class Hash extends HashMap {
	   public Hash(Object ... keyValuePairs) {
	     for (int i=0; i<keyValuePairs.length; i++)
	       put(keyValuePairs[i], keyValuePairs[++i]);
	   }
	}

