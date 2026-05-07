package com.hotely5d.config;



import com.hotely5d.interceptor.JWTInterceptor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.io.File;

@Configuration
public class MyWebAppConfigurer implements WebMvcConfigurer {

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {//静态资源放行
        String currentPath = "";//当前项目目录
        try {
            currentPath = new File(".").getCanonicalPath();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String savePath = "file:" + currentPath + File.separator+ "upload" + File.separator; //文件保存路径,末尾要有分隔符否则配置无效
//        System.out.println("addResourceHandlers - savePath: "+savePath);
        registry.addResourceHandler("/images/**").addResourceLocations(savePath); //通过http://localhost:8600/images/xxx.png访问图片
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new JWTInterceptor())//注册jwt拦截器
                .addPathPatterns("/**") //拦截
                .excludePathPatterns(//放行
                        "/system/login"
                        ,"/system/register"
                        ,"/images/**"
                        ,"/notice/**"
                        ,"/message/**"
                        ,"/room/**"
                        ,"/category/**"
                        ,"/file/**");
    }

}

