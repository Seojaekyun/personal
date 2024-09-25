package com.example.demo;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SitemeshConfig extends ConfigurableSiteMeshFilter{

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder)
	{
	 
        builder.addDecoratorPath("*", "/default.jsp");
		
		//builder.addDecoratorPath("/admin/*", "/views/common/admin.jsp");
		
		// 제외할 폴더와 문서
		//builder.addExcludedPath("/test/*");
        builder.addExcludedPath("/main/category");
        builder.addExcludedPath("/main/this");
        builder.addExcludedPath("/main/this2");
        builder.addExcludedPath("/product/jusoWrite");
        builder.addExcludedPath("/product/jusoWriteOk");
        builder.addExcludedPath("/product/jusoList");
        builder.addExcludedPath("/product/jusoUpdate");
        builder.addExcludedPath("/etc/busList");
        builder.addExcludedPath("/member/eventTest");
        builder.addExcludedPath("/member/jusoWrite");
        builder.addExcludedPath("/member/baeUpdate");
		
		
        super.applyCustomConfiguration(builder);
        
	}
}
