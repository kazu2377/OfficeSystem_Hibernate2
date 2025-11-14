package G_T.OfficeSystem.config;

import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.core.env.Environment;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;

@EnableTransactionManagement
@PropertySources({ @PropertySource("classpath:ds/datasource-cfg.properties") })
@Configuration
@ComponentScan("G_T.OfficeSystem.*")
public class ApplicationContextConfig {

	@Autowired
	private Environment env;

	/*
	@Bean(name = "viewResolver")
	public InternalResourceViewResolver getViewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setPrefix("/WEB-INF/pages/");
		viewResolver.setSuffix(".jsp");

		return viewResolver;
	}
	*/

	@Bean(name = "viewResolver")
	public ViewResolver getViewResolver() {
		UrlBasedViewResolver viewResolver = new UrlBasedViewResolver();

		// TilesView 3
		viewResolver.setViewClass(TilesView.class);
		return viewResolver;
	}

	@Bean(name = "tilesConfigurer")
	public TilesConfigurer getTilesConfigurer() {
		TilesConfigurer tilesConfigurer = new TilesConfigurer();

		// TilesView 3
		tilesConfigurer.setDefinitions("/WEB-INF/tiles.xml");
		return tilesConfigurer;
	}


	@Bean(name = "dataSource")
	public DataSource getDataSource() {
		DriverManagerDataSource dataSource = new DriverManagerDataSource();
		dataSource.setDriverClassName(env.getProperty("ds.database-driver"));
		dataSource.setUrl(env.getProperty("ds.url"));
		dataSource.setUsername(env.getProperty("ds.username"));
		dataSource.setPassword(env.getProperty("ds.password"));

		return dataSource;
	}

	@Bean(name = "transactionManager")
	public DataSourceTransactionManager getTransactionManager() {
		DataSourceTransactionManager txManager = new DataSourceTransactionManager();
		DataSource dataSource = this.getDataSource();
		txManager.setDataSource(dataSource);

		return txManager;
	}

	//ユーザー検索画面お検索結果一覧の列名とUserInfoModelクラスのフィールドとのマッピング
	@Bean(name = "mapProperties")
	public Map<String, Method> getMapProperties() {
		Map<String, Method> mapProperties = new HashMap<String, Method>();
		Class<?> userInfoModelClass;
		try {
			userInfoModelClass = Class.forName("G_T.OfficeSystem.model.UserInfoModel");
			mapProperties.put("ユーザーID", userInfoModelClass.getMethod("getUserId"));
			mapProperties.put("氏名", userInfoModelClass.getMethod("getUserName"));
			mapProperties.put("性別", userInfoModelClass.getMethod("getSex"));
			mapProperties.put("電話番号", userInfoModelClass.getMethod("getTel"));
			mapProperties.put("郵便番号", userInfoModelClass.getMethod("getPostCode"));
			mapProperties.put("住所", userInfoModelClass.getMethod("getAddress"));
		} catch (NoSuchMethodException | SecurityException | ClassNotFoundException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
		return mapProperties;
	}
}

