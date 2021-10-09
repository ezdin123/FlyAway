package com.simplilearn.util;

import java.util.regex.Pattern;

public class FormValidator {
	
	public static boolean isDateTime(String string) {
		Pattern pat = Pattern.compile("^(0?[1-9]|1[0-2])[\\/](0?[1-9]|[12]\\d|3[01])[\\/](19|20)\\d{2}$");
		if(string!=null) {
			if(pat.matcher(string).matches()&&notBlank(string)) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	public static boolean isAlphanumeric(String string) {
		Pattern pat = Pattern.compile("^([A-Za-z0-9\\u00C0-\\u1FFF\\u2C00-\\uD7FF][-,. ']*[ ]*)+$");
		if(string!=null) {
			if(pat.matcher(string).matches()&&notBlank(string)) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	public static boolean isInt(String string) {
		Pattern pat = Pattern.compile("(^\\d{1,50}$)");
		if(string!=null) {
			if(pat.matcher(string).matches()&&notBlank(string)) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	public static boolean isAlphabet(String string) {
		Pattern pat = Pattern.compile("^([a-zA-Z\\u0080-\\u024F]+(?:. |-| |'))*[a-zA-Z\\u0080-\\u024F]*$");
		if(string!=null) {
			if(pat.matcher(string).matches()&&notBlank(string)) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
	
	public static boolean notBlank(String string) {
		if(string!=null) {
			//string = string.replaceAll("^\s+|\s+$", "");
			if(string.length()>0) {
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}
	}
}
