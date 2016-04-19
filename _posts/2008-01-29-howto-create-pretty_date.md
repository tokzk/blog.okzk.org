---
layout: post
title:  Java Pretty Dateの作り方
date:   2008-01-29 12:00:00 +0900
categories: tech
---
John Resigの記事のJavaScriptで書かれたPretty DateをJavaに移植した。

John Resig の記事のJavaScriptを移植した、ISO8601:2004の日付をParseするけれども、commons-langを使うのが素直。

	
	import java.text.ParseException;
	import java.text.SimpleDateFormat;
	import java.util.Calendar;
	import java.util.Date;
	
	//import org.apache.commons.lang.time.DateFormatUtils
	
	public class PrettyDate {
	    public static String prettyDate(String dateString) throws ParseException {
	        if (dateString == null)
	            return null;
	
	        // Date date = DateFormatUtils.ISO_DATETIME_TIME_ZONE_FORMAT.format(date);
	        Date date = parse(dateString);
	        return prettyDate(date);
	        
	    }
	    
	    public static String prettyDate(Date date) throws ParseException {
	        if (date == null) return null;
	        Calendar cal = Calendar.getInstance();
	        long diff = (cal.getTime().getTime() - date.getTime()) / 1000;
	        double dayDiff = Math.floor(diff / 86400);
	
	        if (dayDiff < 0 || dayDiff >= 31)
	            return null;
	
	        if (dayDiff == 0) {
	            if (diff < 60   ) return "just now";
	            if (diff < 120  ) return "1 minute ago";
	            if (diff < 3600 ) return (int) Math.floor(diff / 60) + " minutes ago";
	            if (diff < 7200 ) return "1 hour ago";
	            if (diff < 86400) return (int) Math.floor(diff / 3600) + " hours ago";
	        } else if (dayDiff == 1) {
	            return "Yesterday";
	        } else if (dayDiff < 7) {
	            return (int) dayDiff + " days ago";
	        } else if (dayDiff < 31) {
	            return (int) Math.ceil(dayDiff / 7) + " weeks ago";
	        }
	        return null;
	
	    }
	
	    private static final SimpleDateFormat DATE_FORMAT_MILLIS_ISO8601 
	            = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
	    private static final String        REGEX_DATE_FORMAT_MILLIS_ISO8601 
	    = "\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\.\\d{3}[-+]\\d{2}:\\d{2}";
	
	    public static Date parse(String dateString) throws ParseException {
	        Date date = null;
	        if (dateString.matches(REGEX_DATE_FORMAT_MILLIS_ISO8601)) {
	            int index = dateString.lastIndexOf(":");
	            StringBuffer sb = new StringBuffer(dateString).deleteCharAt(index);
	            date = DATE_FORMAT_MILLIS_ISO8601.parse(sb.toString());
	        }
	        return date;
	    }
	
	    public static void main(String[] args) {
	        String[] dateStrings = { "2008-01-29T20:38:17.123+09:00",
	                "2008-01-29T20:28:17.123+09:00",
	                "2008-01-29T10:28:17.123+09:00",
	                "2008-01-28T10:28:17.123+09:00",
	                "2008-01-25T10:28:17.123+09:00",
	                "2008-01-20T10:28:17.123+09:00", };
	        try {
	            for (String dateString : dateStrings) {
	                System.out.println(PrettyDate.prettyDate(dateString));
	            }
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
	    }
	}

以下実行結果

	prettyDate("2008-01-29T20:38:17.123+09:00")// =>21 minutes ago
	prettyDate("2008-01-29T20:28:17.123+09:00")// =>31 minutes ago
	prettyDate("2008-01-29T10:28:17.123+09:00")// =>10 hours ago
	prettyDate("2008-01-28T10:28:17.123+09:00")// =>Yesterday
	prettyDate("2008-01-25T10:28:17.123+09:00")// =>4 days ago
	prettyDate("2008-01-20T10:28:17.123+09:00")// =>2 weeks ago
