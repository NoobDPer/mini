package com.jk.minimalism.util;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.collections.MapUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * 定义返回结果的代码以及消息等信息
 *
 * @author muchuanwei@yunzhangfang.com
 * @date 2018/11/02
 */
@Component
public class HttpUtil {

    private static RestTemplate restTemplate;

    public HttpUtil(RestTemplate restTemplate) {
        HttpUtil.restTemplate = restTemplate;
    }

    public static String get(String url, JSONObject params) {
        return restTemplate.getForObject(expandURL(url, params.keySet()), String.class, params);
    }

    public static <T> T get(String url, JSONObject params, Class<T> clz) {
        return restTemplate.getForObject(expandURL(url, params.keySet()), clz, params);
    }

    public static String delete(String url, Map<String, ?> uriVariables) {
        return exchange(url, null, MediaType.APPLICATION_JSON, uriVariables, HttpMethod.DELETE);
    }

    public static String delete(String url, JSONObject params, MediaType mediaType, Map<String, ?> uriVariables) {
        return exchange(url, params, mediaType, uriVariables, HttpMethod.DELETE);
    }

    public static String put(String url, Map<String, ?> uriVariables) {
        return put(url, null, MediaType.APPLICATION_JSON, uriVariables);
    }

    public static String put(String url, JSONObject params, MediaType mediaType) {
       return put(url, params, mediaType, null);
    }

    public static String put(String url, JSONObject params, MediaType mediaType, Map<String, ?> uriVariables) {
        return exchange(url, params, mediaType, uriVariables, HttpMethod.PUT);
    }

    public static String post(String url, JSONObject params) {
        return exchange(url, params, MediaType.APPLICATION_JSON, null, HttpMethod.POST);
    }

    public static String post(String url, JSONObject params, MediaType mediaType) {
        return exchange(url, params, mediaType, null, HttpMethod.POST);
    }

    public static String post(String url, JSONObject params, MediaType mediaType, Map<String, ?> uriVariables) {
        return exchange(url, params, mediaType, uriVariables, HttpMethod.POST);
    }

    public static RestTemplate getRestTemplate() {
        return restTemplate;
    }

    private static String expandURL(String url, Set<?> keys) {
        StringBuilder sb = new StringBuilder(url);
        sb.append("?");

        for (Object key : keys) {
            sb.append(key).append("=").append("{").append(key).append("}").append("&");
        }

        return sb.deleteCharAt(sb.length() - 1).toString();
    }

    private static String exchange(String url, JSONObject params, MediaType mediaType, Map<String, ?> uriVariables, HttpMethod httpMethod) {
        String result = null;
        HttpHeaders requestHeaders = new HttpHeaders();
        uriVariables = uriVariables == null ? new HashMap<>() : uriVariables;
        if (MapUtils.isNotEmpty(uriVariables)) {
            url = expandURL(url, uriVariables.keySet());
        }
        if (mediaType == MediaType.APPLICATION_JSON || mediaType == MediaType.APPLICATION_JSON_UTF8) {
            requestHeaders.setContentType(mediaType);
            HttpEntity<JSONObject> requestEntity = new HttpEntity<>(params, requestHeaders);
            result = restTemplate.exchange(url, httpMethod, requestEntity, String.class, uriVariables).getBody();
        } else if (mediaType == MediaType.APPLICATION_FORM_URLENCODED) {
            MediaType type = MediaType.parseMediaType("application/x-www-form-urlencoded; charset=UTF-8");
            requestHeaders.setContentType(type);
            requestHeaders.set("Accept-Encoding", "gzip,deflate");
            HttpEntity<JSONObject> requestEntity = new HttpEntity<>(null, requestHeaders);
            result = restTemplate.exchange(expandURL(url, params.keySet()), httpMethod, requestEntity, String.class, uriVariables).getBody();
        }
        return result;
    }
}