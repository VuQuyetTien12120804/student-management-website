package util;

import java.security.MessageDigest;
import java.util.Base64;

public class encryption {
    //md5
    //sha-1
    
    public static String toSHA1(String str) {
        String salt = "asjasfhdsadghgaghdfgjkiuygrajjahdfsjl";
        String result = null;
        str += salt;
        try {
            byte[] dataBytes = str.getBytes("UTF-8");
            MessageDigest md = MessageDigest.getInstance("SHA-1");
            byte[] digestBytes = md.digest(dataBytes);
            result = Base64.getEncoder().encodeToString(digestBytes);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

//    public static void main(String[] args) {
//        System.out.println(toSHA1("nguyen99"));
//    }
}
