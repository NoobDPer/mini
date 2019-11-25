package com.jk.minimalism.config;

import com.jk.minimalism.util.MinimalismObjectMapper;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.MappingJackson2HttpMessageConverter;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 总配置
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/10/31
 */
@Configuration
public class MinimalismConfig {

    @Bean
    public RestTemplate getRestTemplate() {
        RestTemplate restTemplate = new RestTemplate();
        List<HttpMessageConverter<?>> messageConverters = restTemplate.getMessageConverters();
        List<HttpMessageConverter<?>> messageConvertersUtf8 = messageConverters.stream().peek(httpMessageConverter -> {
            if (httpMessageConverter instanceof StringHttpMessageConverter) {
                ((StringHttpMessageConverter) httpMessageConverter).setDefaultCharset(StandardCharsets.UTF_8);
            }
        }).collect(Collectors.toList());
        restTemplate.setMessageConverters(messageConvertersUtf8);
        return restTemplate;
    }

    @Bean
    public MappingJackson2HttpMessageConverter getConverter() {
        return new MappingJackson2HttpMessageConverter(new MinimalismObjectMapper());
    }
}
