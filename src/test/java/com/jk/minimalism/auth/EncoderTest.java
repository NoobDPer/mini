package com.jk.minimalism.auth;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.junit4.SpringRunner;

/**
 * @author admin-jk
 * @date 19-9-23
 */
@RunWith(SpringRunner.class)
@SpringBootTest
public class EncoderTest {

    @Autowired
    private BCryptPasswordEncoder passwordEncoder;

    @Test
    public void generatePass() {
        String encode = passwordEncoder.encode("jk1qaz@WSX");
        System.out.println(encode);
    }
}
