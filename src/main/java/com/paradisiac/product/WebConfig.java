package com.paradisiac.product;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")  // 允許所有的URL路徑
                .allowedOrigins("http://localhost:63342")  // 允許這個來源的跨域請求
                .allowedMethods("GET", "POST", "PUT", "DELETE")  // 允許的HTTP方法
                .allowCredentials(true)  // 允許cookies
                .maxAge(3600);  // 預檢請求的緩存時間（秒）
    }
}
