package com.example.demo;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SitemeshConfig extends ConfigurableSiteMeshFilter{

	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		// 제외할 폴더와 문서
		builder.addExcludedPath("/admin/proWrite");
		builder.addExcludedPath("/member/usForm");
		builder.addExcludedPath("/member/useridSearch");
		builder.addExcludedPath("/member/psForm");
		builder.addExcludedPath("/member/pwdSearch");
		
		builder.addDecoratorPath("*", "/default.jsp");
		
		super.applyCustomConfiguration(builder);
		
	}
	
	
}