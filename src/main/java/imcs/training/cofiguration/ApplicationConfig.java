package imcs.training.cofiguration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import imcs.training.service.EmployeeService;
import imcs.training.service.EmployeeServiceImpl;

@Configuration
@EnableWebMvc
public class ApplicationConfig {
	@Bean
	RestTemplate getRestTemplate(){
		return new RestTemplate();
	}
	
	@Bean 
	EmployeeService getEmployeeService(){
		return new EmployeeServiceImpl();
	}
	@Bean
	public InternalResourceViewResolver jspViewResolver() {
	    InternalResourceViewResolver resolver= new InternalResourceViewResolver();
	    resolver.setPrefix("/WEB-INF/views/");
	    resolver.setSuffix(".jsp");
	    return resolver;
	}
}