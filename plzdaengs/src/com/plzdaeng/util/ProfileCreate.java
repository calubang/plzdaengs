package com.plzdaeng.util;

import java.io.*;

public class ProfileCreate {
	public static void profileRegister(File file,String path, String id, String type) {
		byte[] buf = new byte[1024];
		FileInputStream fin = null;
		FileOutputStream fout = null;
		int read = 0;
		
		switch (type) {
		case "user":
			path += "//user";
			File temp = new File(path);
			if(!temp.exists()) {
				temp.mkdir();
			}
			path += "//"+id;
			temp = new File(path);
			if(!temp.exists()) {
				temp.mkdir();
			}
			path += "//user_profile.jpg";
			break;
		case "pet":
			path += "//user//"+id;
			break;
		default:
			break;
		}
		
		try {
			if(file == null) {
				//기본 프로필로 설정
				return;
			}
			
			fin = new FileInputStream(file);
			fout = new FileOutputStream(path);
			
			while((read = fin.read(buf, 0, buf.length)) != -1) {
				fout.write(buf, 0, read);
			}	
			
		
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("여기서 에러임?");
		} finally {
			if(fin != null) {
				try {
					fin.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			if(fout != null) {
				try {
					fout.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
	}
}
