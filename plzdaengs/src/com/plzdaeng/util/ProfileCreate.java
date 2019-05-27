package com.plzdaeng.util;

import java.io.*;

public class ProfileCreate {
	public static void profileRegister(File file, String id, String type) {
		byte[] buf = new byte[1024];
		FileInputStream fin = null;
		FileOutputStream fout = null;
		
		int read = 0;
		String path = SiteConstance.IMG_PATH;
		String newFileName= "";
		switch (type) {
		case "user":
			path += "\\user\\"+id;
			File temp = new File(path);
			if(!temp.exists()) {
				temp.mkdir();
			}
			path += "\\user_profile.";
			break;
		case "pet":
			path += "\\user\\"+id;
			break;
		default:
			break;
		}
		
		try {
			fin = new FileInputStream(file);
			fout = new FileOutputStream(path + file.getName().substring(file.getName().lastIndexOf(".")+1));
			
			while((read = fin.read(buf, 0, buf.length)) != -1) {
				fout.write(buf, 0, read);
			}	
			
		
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(fin != null) {
				try {
					fin.close();
					file.delete();
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
