package com.jk.minimalism.config;

import com.google.common.collect.Lists;
import com.jk.minimalism.auth.TokenFilter;
import org.springframework.boot.autoconfigure.condition.ConditionalOnExpression;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.ParameterBuilder;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.schema.ModelRef;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * swagger配置
 *
 * @author Promise.H
 * @date 2018/10/12
 */
@Configuration
@EnableSwagger2
@ConditionalOnExpression("${minimalism.enable-swagger}")
public class Swagger2Config {

    @Bean
    public Docket createRestApi() {

        ParameterBuilder builder = new ParameterBuilder();
        // 在swagger里显示header
        builder.parameterType("header").name(TokenFilter.TOKEN_KEY)
                .description("header参数")
                .required(false)
                .modelRef(new ModelRef("string"));
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .globalOperationParameters(Lists.newArrayList(builder.build()))
                .select()
                .apis(RequestHandlerSelectors.basePackage("com.jk.minimalism"))
                .paths(PathSelectors.any())
                .build();
    }

    private ApiInfo apiInfo() {
        return new ApiInfoBuilder()
                .title("万众企服swagger")
                .version("1.0")
                .build();
    }

}
