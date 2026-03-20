package com.shop.db;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class SMS {
	
	public String sendSMS(String mno,String msg) throws Exception
	{
		String url = 
	"http://bulksms.mysmsmantra.com:8080/WebSMS/SMSAPI.jsp?username=citysms&password=167400573&sendername=citsms&mobileno=91"+mno+"&message="+msg;

	//Send GET request thru Java Code and get Response
	URL obj = new URL(url); //URL class object build from url
	//Open Connection
	//URLConnection openConnection();	
	HttpURLConnection con = (HttpURLConnection) obj.openConnection();

	//optional default is GET
	con.setRequestMethod("GET");

	int responseCode = con.getResponseCode(); //Get response 200 Status Code
	
	//It reads response from Input Stream of Connection and returns
	//In form of String
	BufferedReader in = new BufferedReader(
			        new InputStreamReader(con.getInputStream()));
	String inputLine;
	StringBuffer response1 = new StringBuffer();

	while ((inputLine = in.readLine()) != null) {
		response1.append(inputLine);
	}
	in.close();

	//print result
	return response1.toString();

	}


}
