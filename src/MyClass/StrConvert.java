package MyClass;

public class StrConvert {
	public String chStr(String str) {
		if (str == null){
			str = "";
			return str;
		}
		
		try{
			str = (new String(str.getBytes("ISO-8859-1"), "UTF-8")); //由jsp内在的编码转码为UTF-8
			
		}catch(Exception e){
			System.out.println("StrConvert: " + e.getMessage());
		}
		
		return str;
	}
}
