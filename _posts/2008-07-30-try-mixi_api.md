---
layout: post
title:  MixiAPIの実験
date:   2008-07-30 12:00:00 +0900
categories: tech
---
MixiAPIの実験をしたので、記録をとっておきます。

atom/MixiTest.java

	package atom;
	
	import java.io.IOException;
	import java.io.UnsupportedEncodingException;
	import java.security.MessageDigest;
	import java.security.NoSuchAlgorithmException;
	import java.security.SecureRandom;
	import java.text.SimpleDateFormat;
	import java.util.Calendar;
	import java.util.TimeZone;
	
	import org.apache.commons.codec.binary.Base64;
	import org.apache.commons.httpclient.Header;
	import org.apache.commons.httpclient.HttpClient;
	import org.apache.commons.httpclient.HttpException;
	import org.apache.commons.httpclient.methods.PostMethod;
	import org.apache.commons.httpclient.methods.StringRequestEntity;
	
	public class MixiTest {
	
	    private HttpClient client;
	
	    public MixiTest() {
	        this.client = new HttpClient();
	    }
	
	    public void post(String url, String username, String password)
	            throws HttpException, IOException {
	        PostMethod method = new PostMethod(url);
	        method.addRequestHeader("X-WSSE",
	                getWsseHeaderValue(username, password));
	        String body = ""
	                        + "<?xml version='1.0' encoding='utf-8'?>"
	                        + "<entry xmlns='http://purl.org/atom/ns#'>"
	                        + "  <title>Test</title>"
	                        + "  <summary>Post diary from Mixi API</summary>"
	                        + "</entry>";
	
	        StringRequestEntity re =
	                new StringRequestEntity(body, "application/atom+xml", "UTF-8");
	        method.setRequestEntity(re);
	        this.client.executeMethod(method);
	        System.out.println(method.getStatusLine().toString());
	        Header[] headers = method.getResponseHeaders();
	        int len = headers.length;
	        for (int i = 0; i < len; i++) {
	            System.out.print(headers[i].toString());
	        }
	        System.out.println(method.getResponseBodyAsString());
	    }
	
	    protected final String getWsseHeaderValue(String username, String password) {
	        try {
	            byte[] nonceB = new byte[8];
	            SecureRandom.getInstance("SHA1PRNG").nextBytes(nonceB);
	
	            SimpleDateFormat zulu =
	                    new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
	            zulu.setTimeZone(TimeZone.getTimeZone("GMT"));
	            Calendar now = Calendar.getInstance();
	            now.setTimeInMillis(System.currentTimeMillis());
	            String created = zulu.format(now.getTime());
	            byte[] createdB = created.getBytes("utf-8");
	            byte[] passwordB = password.getBytes("utf-8");
	
	            byte[] v = new byte[nonceB.length
	                    + createdB.length + passwordB.length];
	            System.arraycopy(nonceB, 0, v, 0, nonceB.length);
	            System.arraycopy(createdB, 0, v, nonceB.length, createdB.length);
	            System.arraycopy(passwordB, 0, v, nonceB.length
	                    + createdB.length, passwordB.length);
	
	            MessageDigest md = MessageDigest.getInstance("SHA1");
	            md.update(v);
	            byte[] digest = md.digest();
	
	            StringBuffer buf = new StringBuffer();
	            buf.append("UsernameToken Username=\"");
	            buf.append(username);
	            buf.append("\", PasswordDigest=\"");
	            buf.append(new String(Base64.encodeBase64(digest)));
	            buf.append("\", Nonce=\"");
	            buf.append(new String(Base64.encodeBase64(nonceB)));
	            buf.append("\", Created=\"");
	            buf.append(created);
	            buf.append('"');
	            return buf.toString();
	        } catch (NoSuchAlgorithmException e) {
	            throw new RuntimeException(e);
	        } catch (UnsupportedEncodingException e) {
	            throw new RuntimeException(e);
	        }
	    }
	
	    public static void main(String[] args) throws Exception {
	        MixiTest test = new MixiTest();
	        test.post("http://mixi.jp/atom/diary/member_id=xxxx", "xxx@xxxxxxx",
	                "xxxxxxxxxxxx");
	    }
	}

