package org.example.quan_ly_khoa_hoc.entity;

import org.mindrot.jbcrypt.BCrypt;

public class Test {
    public static void main(String[] args) {
        String pw = "123";
        String hash = BCrypt.hashpw(pw, BCrypt.gensalt());
        System.out.println(hash);
        boolean match = BCrypt.checkpw("123", hash);
        System.out.println("Đúng? " + match);
    }
}
