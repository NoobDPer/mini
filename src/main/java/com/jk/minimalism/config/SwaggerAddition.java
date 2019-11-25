package com.jk.minimalism.config;

import com.fasterxml.classmate.TypeResolver;
import com.google.common.collect.Sets;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Component;
import springfox.documentation.builders.OperationBuilder;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.builders.ResponseMessageBuilder;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiDescription;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spi.service.ApiListingScannerPlugin;
import springfox.documentation.spi.service.contexts.DocumentationContext;
import springfox.documentation.spring.web.readers.operation.CachingOperationNameGenerator;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

/**
 * @author admin-jk
 * @date 19-8-13
 */
@Component
public class SwaggerAddition implements ApiListingScannerPlugin {
    @Override
    public List<ApiDescription> apply(DocumentationContext documentationContext) {
        return new ArrayList<>(
                Arrays.asList(new ApiDescription(
                                //url
                                "/login",
                                //描述
                                "登录",
                                Collections.singletonList(
                                        new OperationBuilder(
                                                new CachingOperationNameGenerator())
                                                //http请求类型
                                                .method(HttpMethod.POST)
                                                .produces(Sets.newHashSet(MediaType.APPLICATION_JSON_VALUE))
                                                .summary("登录")
                                                //方法描述
                                                .notes("登录")
                                                //归类标签
                                                .tags(Sets.newHashSet("登录接口"))
                                                .parameters(
                                                        Arrays.asList(
                                                                new ParameterBuilder()
                                                                        .description("用户名")
                                                                        .type(new TypeResolver().resolve(String.class))
                                                                        .name("username")
                                                                        .parameterType("query")
                                                                        .parameterAccess("access")
                                                                        .required(true)
                                                                        //<5>
                                                                        .modelRef(new ModelRef("string"))
                                                                        .build(),
                                                                new ParameterBuilder()
                                                                        //参数描述
                                                                        .description("密码鉴权password")
                                                                        //参数数据类型
                                                                        .type(new TypeResolver().resolve(String.class))
                                                                        //参数名称
                                                                        .name("password")
                                                                        //参数默认值
                                                                        .defaultValue("123456")
                                                                        //参数类型
                                                                        .parameterType("query")
                                                                        .parameterAccess("access")
                                                                        //是否必填
                                                                        .required(false)
                                                                        //参数数据类型
                                                                        .modelRef(new ModelRef("string"))
                                                                        .build()
                                                        ))
                                                .responseMessages(Collections.singleton(new ResponseMessageBuilder().code(200).build()))
                                                .build()),
                                false),
                        new ApiDescription(
                                //url
                                "/logout",
                                //描述
                                "登出",
                                Collections.singletonList(
                                        new OperationBuilder(
                                                new CachingOperationNameGenerator())
                                                //http请求类型
                                                .method(HttpMethod.GET)
                                                .summary("登出")
                                                //方法描述
                                                .notes("登出")
                                                //归类标签
                                                .tags(Sets.newHashSet("登出接口"))
                                                .parameters(
                                                        Arrays.asList(
                                                                new ParameterBuilder()
                                                                        .description("header参数")
                                                                        .parameterType("header")
                                                                        .type(new TypeResolver().resolve(String.class))
                                                                        .name("token")
                                                                        .required(true)
                                                                        .modelRef(new ModelRef("string"))
                                                                        .build()

                                                        ))
                                                .responseMessages(Collections.singleton(new ResponseMessageBuilder().code(200).build()))
                                                .build()),
                                false)
                        ));

    }

    @Override
    public boolean supports(DocumentationType documentationType) {
        return DocumentationType.SWAGGER_2.equals(documentationType);

    }
}
