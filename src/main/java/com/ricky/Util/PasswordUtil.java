package com.ricky.Util;

import org.apache.commons.codec.digest.DigestUtils;

public class PasswordUtil {

	/**
	 * 使用commons-codec 下的MD5加密
	 * @param inputStr
	 * @return
	 */
	public static  String  getResult(String inputStr){
		return DigestUtils.md5Hex(inputStr);
	}

}
