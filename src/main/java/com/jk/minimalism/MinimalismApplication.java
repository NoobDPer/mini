package com.jk.minimalism;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import tk.mybatis.spring.annotation.MapperScan;

@SpringBootApplication
@MapperScan(basePackages = {"com.jk.minimalism.dao"})
public class MinimalismApplication {

	public static void main(String[] args) {
		SpringApplication.run(MinimalismApplication.class, args);
	}

}
