package kr.co.jk;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class SitemeshConfig extends ConfigurableSiteMeshFilter {
	
	@Override
	protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
		builder.addDecoratorPath("*", "/views/common/default.jsp");
		
		builder.addExcludedPath("/member/usForm");
		builder.addExcludedPath("/member/psForm");
		builder.addExcludedPath("/member/reForm");
		
		System.out.println("site");
	}
}
