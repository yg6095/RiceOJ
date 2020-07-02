package com.ricky.Util;

import org.apache.commons.codec.binary.Base64;

import java.io.*;

public class FileUtil {
    public static String readFileAsString(String filePath) throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            throw new FileNotFoundException(filePath);
        }

        if (file.length() > 1024 * 1024 * 1024) {
            throw new IOException("File is too large");
        }

        StringBuilder sb = new StringBuilder((int) (file.length()));
// 创建字节输入流
        FileInputStream fis = new FileInputStream(filePath);
// 创建一个长度为10240的Buffer
        byte[] bbuf = new byte[10240];
// 用于保存实际读取的字节数
        int hasRead = 0;
        while ((hasRead = fis.read(bbuf)) > 0) {
            sb.append(new String(bbuf, 0, hasRead));
        }
        fis.close();
        return sb.toString();
    }

    /**
     * 根据文件路径读取byte[] 数组
     */
    public static byte[] readFileByBytes(String filePath) throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            throw new FileNotFoundException(filePath);
        } else {
            ByteArrayOutputStream bos = new ByteArrayOutputStream((int) file.length());
            BufferedInputStream in = null;

            try {
                in = new BufferedInputStream(new FileInputStream(file));
                short bufSize = 1024;
                byte[] buffer = new byte[bufSize];
                int len1;
                while (-1 != (len1 = in.read(buffer, 0, bufSize))) {
                    bos.write(buffer, 0, len1);
                }

                byte[] var7 = bos.toByteArray();
                return var7;
            } finally {
                try {
                    if (in != null) {
                        in.close();
                    }
                } catch (IOException var14) {
                    var14.printStackTrace();
                }

                bos.close();
            }
        }
    }

    public static File base64ToFile(String base64str, String prefix, String path) throws Exception{
        if (base64str == null || "".equals(base64str)) {
            return null;
        }
        byte[] buff = Base64.decodeBase64(base64str);
        File file = null;
        FileOutputStream fout = null;
        file = File.createTempFile(prefix, ".jpg", new File(path));
        fout = new FileOutputStream(file);
        fout.write(buff);
        if (fout != null) {
            fout.close();
        }
        return file;
    }

    public static File saveImage(String strPath, File file) throws Exception{
        File myfile = new File(strPath);
        System.out.println(file);
        if (myfile.exists()) // 目录下有文件就删除
            myfile.delete();
        if (!myfile.getParentFile().exists()) // 文件夹不存在创建文件夹
            myfile.getParentFile().mkdirs();
        FileInputStream fin = new FileInputStream(file);
        FileOutputStream fout = new FileOutputStream(myfile);
        byte[] myByteArray = new byte[(int) file.length()];
        int n = 0;
        while ((n = fin.read(myByteArray)) != -1)
            fout.write(myByteArray, 0, n);
        fout.close();
        fin.close();
        return myfile;
    }

    public static void deleteImage(String filePath) {
        File myfile = new File(filePath);
        if (myfile.exists()) // 目录下有文件就删除
            myfile.delete();
    }
    public static void delAllFile(File directory) {
        if (!directory.isDirectory()) {
            directory.delete();
        } else {
            File[] files = directory.listFiles();
            // 空文件夹
            if (files.length == 0) {
                directory.delete();
                return;
            }
            // 删除子文件夹和子文件
            for (File file : files) {
                if (file.isDirectory()) {
                    delAllFile(file);
                } else {
                    file.delete();
                }
            }
            // 删除文件夹本身
            directory.delete();
        }
    }
}
