package imcs.training.service;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import imcs.training.model.Department;
@Service
public class DepartmentServiceImpl implements DepartmentService{
	
	final static Logger logger=Logger.getLogger(DepartmentServiceImpl.class);
	
	@Autowired
	private RestTemplate rt;
	
	private final String url="http://localhost:8080/department";

	@Override
	public Department getDepartment(int deptNo) throws SQLException {
		logger.debug("service method for get department");
		ResponseEntity<Department> response=rt.getForEntity(url+"/"+deptNo, Department.class);
		if(response.getStatusCodeValue()!=200 || response.getBody()==null){
			return null;
		}
		return response.getBody();
	}
	
}