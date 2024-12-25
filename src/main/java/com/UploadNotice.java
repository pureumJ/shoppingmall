package com;
import java.io.File;
 
public class UploadNotice {
 
    // Windows, VMWare, AWS cloud 절대 경로 설정
    public static synchronized String getUploadDir() {
        String path = "";
        if (File.separator.equals("\\")) {
            path = "/Users/pureum/Desktop/full stack dev/deploy/notice/storage/";
            System.out.println("Mac : " + path);
            
        } else {
            // System.out.println("Linux");
//            path = "/home/ubuntu/deploy/bbs/storage/";
            path = "/Users/pureum/Desktop/full stack dev/deploy/notice/storage/";
        }
        return path;
    }
    
}