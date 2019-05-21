package com.plzdaeng.board.yugi.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import com.plzdaeng.util.YugiConfig;

public class YugiService {
	
	public StringBuilder getUrl(String cmd)  {
	 	StringBuilder urlBuilder = new StringBuilder(); /*URL*/
	 	
        try {
        	urlBuilder.append(YugiConfig.YUGI_APIURL+cmd);
			urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") +"="+YugiConfig.YUGI_SERVICEKEY);
			urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("20", "UTF-8")); /*페이지당 보여줄 개수*/
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} /*Service Key*/
        
		return urlBuilder;
	}
	
	
	public String getSido(String cmd) throws Exception {
		System.out.println(this.getUrl(cmd).toString());
		URL url = new URL(this.getUrl(cmd).toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        
        System.out.println(sb.toString());
        rd.close();
        conn.disconnect();
        
        
        return sb.toString();
	}

}
