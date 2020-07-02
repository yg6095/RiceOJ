package com.ricky.Util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class HtmlUtil {

	public static String txtToHtml(String s) {
		StringBuilder builder = new StringBuilder();
		boolean previousWasASpace = false;
		for (char c : s.toCharArray()) {
			if (c == ' ') {
				if (previousWasASpace) {
					builder.append(" ");
					previousWasASpace = false;
					continue;
				}
				previousWasASpace = true;
			} else {
				previousWasASpace = false;
			}
			switch (c) {
			case '<':
				builder.append("<");
				break;
			case '>':
				builder.append(">");
				break;
			case '&':
				builder.append("&");
				break;
			case '"':
				builder.append('"');
				break;
			case '\n':
				builder.append("<br>");
				break;
			case '\t':
				builder.append(" ");
				break;
			default:
				builder.append(c);
			}
		}
		String converted = builder.toString();
		String str = "(?i)\\b((?:https?://|www\\d{0,3}[.]|[a-z0-9.\\-]+[.][a-z]{2,4}/)(?:[^\\s()<>]+|\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\))+(?:\\(([^\\s()<>]+|(\\([^\\s()<>]+\\)))*\\)|[^\\s`!()\\[\\]{};:\'\".,<>?«»“”‘’]))";
		Pattern patt = Pattern.compile(str);
		Matcher matcher = patt.matcher(converted);
		converted = matcher.replaceAll("<a href=\"$1\">$1</a>");
		return converted;
	}

	public static String readStr(String oldStr)
    {
    	if(oldStr == null) oldStr = "";
        oldStr = oldStr.replace("&nbsp;", "   ");
        oldStr = oldStr.replace("<", "&lt;");
        oldStr = oldStr.replace(">", "&gt;");
        oldStr = oldStr.replace(" ", "&nbsp;");
        oldStr = oldStr.replace("\"", "&quot;");
        return oldStr;
    }

	public static String score_to_html(int result, float pass_rate){
		String Score_error = "<p class='text-danger'>";
		String Score_seccess = "<p class='text-success'>";
		String html_score = "";
		switch (result) {
			case 0:
				break;
			case 1:
				break;
			case 2:
				break;
			case 3:
				break;
			case 4:
				html_score = Score_seccess + (int) (pass_rate * 100) + "</p>";
				break;
			case 5:
				html_score = Score_error + (int) (pass_rate * 100) + "</p>";
				break;
			case 6:
				html_score = Score_error + (int) (pass_rate * 100) + "</p>";
				break;
			case 7:
				html_score = Score_error + (int) (pass_rate * 100) + "</p>";
				break;
			case 8:
				html_score = Score_error + (int) (pass_rate * 100) + "</p>";
				break;
			case 9:
				html_score = Score_error + (int) (pass_rate * 100) + "</p>";
				break;
			case 10:
				html_score = Score_error + (int) (pass_rate * 100) + "</p>";
				break;
			case 11:
				html_score = Score_error + (int) (pass_rate * 100) + "</p>";
				break;
		}
		return html_score;
	}
	public static String status_to_html(int result){
		String html_status = "";
		String AC = "<p class='text-success'>Accepted</p>";
		String WA = "<p class='text-danger'>Wrong Answer</p>";
		String TLE = "<p class='text-warning'>Time Limit Exceeded</p>";
		String MLE = "<p class='text-warning'>Memory Limit Exceeded</p>";
		String OLE = "<p class='text-warning'>Output Limit Exceeded</p>";
		String CE = "<p class='text-primary'>Compile Error</p>";
		String RE = "<p class='text-special'>Runtime Error</p>";
		String PE = "<p class='text-warning'>Presentation Error</p>";
		String IQ = "<p class='text-muted'>Pending</p>";
		String Runing = "<p class='text-warning'><i class='icon icon-spin icon-spinner'></i> Runing</p>";
		String Compair = "<p class='text-brown'><i class='icon icon-spin icon-spinner'></i> Compiling</p>";
		switch (result){
			case 0:
				html_status = IQ;
				break;
			case 1:
				html_status = IQ;
				break;
			case 2:
				html_status = Compair;
				break;
			case 3:
				html_status = Runing;
				break;
			case 4:
				html_status = AC;
				break;
			case 5:
				html_status = PE;
				break;
			case 6:
				html_status = WA;
				break;
			case 7:
				html_status = TLE;
				break;
			case 8:
				html_status = MLE;
				break;
			case 9:
				html_status = OLE;
				break;
			case 10:
				html_status = RE;
				break;
			case 11:
				html_status = CE;
				break;
		}
		return html_status;
	}
	public static String language_to_html(int language){
		String html_language = "";
		switch(language) {
			case 0:
				html_language = "C";
				break;
			case 1:
				html_language= "C++";
				break;
			case 2:
				html_language= "Pascal";
				break;
			case 3:
				html_language= "Java";
				break;
			case 6:
				html_language= "Python";
				break;
		}
		return html_language;
	}
}
