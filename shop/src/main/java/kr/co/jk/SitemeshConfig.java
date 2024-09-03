package kr.co.jk;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SitemeshConfig extends ConfigurableSiteMeshFilter {
	
	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.addDecoratorPath("*", "/views/default.jsp");
		
		builder.addExcludedPath("/main/category");
		builder.addExcludedPath("/main/this");
		builder.addExcludedPath("/main/this2");
		builder.addExcludedPath("/product/jusoWrite");
		builder.addExcludedPath("/product/jusoList");
		
		System.out.println("site");
	}
}
