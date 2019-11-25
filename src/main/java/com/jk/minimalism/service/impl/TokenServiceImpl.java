package com.jk.minimalism.service.impl;

import com.jk.minimalism.bean.dto.LoginUser;
import com.jk.minimalism.bean.dto.Token;
import com.jk.minimalism.service.TokenService;
import io.jsonwebtoken.ExpiredJwtException;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;

import javax.crypto.spec.SecretKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.Key;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * token存到redis的实现类<br>
 * jwt实现的token
 *
 * @author jiaokai
 */
@Primary
@Service
public class TokenServiceImpl implements TokenService {

    private static final Logger log = LoggerFactory.getLogger("adminLogger");

    /**
     * token过期秒数
     */
    @Value("${token.expire.seconds}")
    private Integer expireSeconds;
    private final RedisTemplate<String, LoginUser> redisTemplate;
    /**
     * 私钥
     */
    @Value("${token.jwt-secret}")
    private String jwtSecret;

    private static Key KEY = null;
    private static final String LOGIN_USER_KEY = "LOGIN_USER_KEY";
    private static final String LOGIN_TIME = "LOGIN_TIME";

    @Autowired
    public TokenServiceImpl(RedisTemplate<String, LoginUser> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }

    @Override
    public Token saveToken(LoginUser loginUser) {
        loginUser.setToken(loginUser.getUsername());
        cacheLoginUser(loginUser);
        String jwtToken = createJWTToken(loginUser);
        return new Token(jwtToken, loginUser.getLoginTime(), loginUser.getId(), loginUser.getRoleId());
    }

    /**
     * 生成jwt
     *
     * @param loginUser 登录用户
     * @return jwtToken
     */
    private String createJWTToken(LoginUser loginUser) {
        Map<String, Object> claims = new HashMap<>(1);
        // 放入一个随机字符串，通过该串可找到登陆用户
        claims.put(LOGIN_USER_KEY, loginUser.getToken());
        claims.put(LOGIN_TIME, String.valueOf(System.currentTimeMillis()));
//        claims.put(LOGIN_TYPE, loginUser.getLoginType());
        return Jwts.builder().setClaims(claims).signWith(SignatureAlgorithm.HS256, getKeyInstance())
                .compact();
    }

    private void cacheLoginUser(LoginUser loginUser) {
        loginUser.setLoginTime(System.currentTimeMillis());
        loginUser.setExpireTime(loginUser.getLoginTime() + expireSeconds * 1000);
        // 根据username将loginUser缓存
        redisTemplate.boundValueOps(getTokenKey(loginUser.getToken())).set(loginUser, expireSeconds, TimeUnit.SECONDS);
    }

    /**
     * 更新缓存的用户信息
     */
    @Override
    public void refresh(LoginUser loginUser) {
        cacheLoginUser(loginUser);
    }

    @Override
    public LoginUser getLoginUser(String jwtToken) {
        String username = getClaimFromJWT(jwtToken, LOGIN_USER_KEY);
        if (username != null) {
            return redisTemplate.boundValueOps(getTokenKey(username)).get();
        }
        return null;
    }

    @Override
    public boolean deleteToken(String jwtToken) {
        String username = getClaimFromJWT(jwtToken, LOGIN_USER_KEY);
        return this.deleteTokenByUsername(username);
    }

    @Override
    public boolean deleteTokenByUsername(String username) {
        if (username != null) {
            String key = getTokenKey(username);
            LoginUser loginUser = redisTemplate.opsForValue().get(key);
            if (loginUser != null) {
                redisTemplate.delete(key);
                return true;
            }
        }
        return false;
    }

    private String getTokenKey(String username) {
        return "minimalism:tokens:" + username;
    }

    private Key getKeyInstance() {
        if (KEY == null) {
            synchronized (TokenServiceImpl.class) {
                // 双重锁
                if (KEY == null) {
                    byte[] apiKeySecretBytes = DatatypeConverter.parseBase64Binary(jwtSecret);
                    KEY = new SecretKeySpec(apiKeySecretBytes, SignatureAlgorithm.HS256.getJcaName());
                }
            }
        }

        return KEY;
    }

    private String getClaimFromJWT(String jwtToken, String claimType) {
        if ("null".equals(jwtToken) || StringUtils.isBlank(jwtToken)) {
            return null;
        }
        try {
            Map<String, Object> jwtClaims = Jwts.parser().setSigningKey(getKeyInstance()).parseClaimsJws(jwtToken).getBody();
            return MapUtils.getString(jwtClaims, claimType);
        } catch (ExpiredJwtException e) {
            log.error("{}已过期", jwtToken);
        } catch (Exception e) {
            log.error("{}", e);
        }
        return null;
    }
}
