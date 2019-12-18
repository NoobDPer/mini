package com.jk.minimalism.aspect;

import com.alibaba.fastjson.JSON;
import com.jk.minimalism.bean.dto.LoginUser;
import com.jk.minimalism.bean.entity.User;
import com.jk.minimalism.util.SourceIpUtil;
import com.jk.minimalism.util.UserUtil;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang3.exception.ExceptionUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.util.Objects;

import static com.jk.minimalism.bean.constant.SysConstants.DEFAULT_USER;

/**
 * @author jasonLu
 * @date 2017/10/26 9:57
 * @Description:获取请求的入参和出参
 */
@Component
@Aspect
public class RequestAspect {

    private static final Logger logger = LoggerFactory.getLogger("request.log");

    @Pointcut("@within(org.springframework.stereotype.Controller) || @within(org.springframework.web.bind.annotation.RestController)")
    public void pointcut()
    {
        // 空方法
    }


    @Around("pointcut()")
    public Object handle(ProceedingJoinPoint joinPoint) throws Throwable {
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        //IP地址
        String ipAddr = SourceIpUtil.getClientIpAddress(request);
        String url = request.getRequestURL().toString();
        String reqParam = preHandle(joinPoint,request);
        //logger.info("请求源IP:【{}】,请求URL:【{}】,请求参数:【{}】,用户信息【{}】",ipAddr,url,reqParam,JSON.toJSONString(userinfo));
        LoginUser user = null;
        if (UserUtil.getUserId() != DEFAULT_USER) {
            user = UserUtil.getLoginUser();
        }
        String  respParam = "";
        Object result;
        long start = System.currentTimeMillis();
        try{
            result = joinPoint.proceed();
            respParam = postHandle(result);
        }catch (Exception e){
            respParam = "Excepiton:"+ ExceptionUtils.getStackTrace(e);
            throw e ;
        }finally {
            logger.info("请求源IP:【{}】,Method【{}】,请求URL:【{}】,耗时:【{}】,用户信息【{}】,请求参数【{}】,返回参数:【{}】,",
                ipAddr,request.getMethod(),url,System.currentTimeMillis()-start, Objects.isNull(user) ? "none" :JSON.toJSONString(user),reqParam,respParam);
        }

        return result;
    }

    /**
     * 入参数据
     * @param joinPoint
     * @param request
     * @return
     */
    private String preHandle(ProceedingJoinPoint joinPoint, HttpServletRequest request) {

        String reqParam = "";
        Signature signature = joinPoint.getSignature();
        MethodSignature methodSignature = (MethodSignature) signature;
        Method targetMethod = methodSignature.getMethod();
        Annotation[] annotations = targetMethod.getAnnotations();
        for (Annotation annotation : annotations) {
            if (annotation.annotationType().equals(RequestMapping.class)) {
                if(MapUtils.isNotEmpty(request.getParameterMap())){
                    reqParam = JSON.toJSONString(request.getParameterMap());
                }
                break;
            }
        }
        return reqParam;
    }

    /**
     * 返回数据
     * @param retVal
     * @return
     */
    private String postHandle(Object retVal) {
        if(null == retVal){
            return "";
        }
        return JSON.toJSONString(retVal);
    }


}
