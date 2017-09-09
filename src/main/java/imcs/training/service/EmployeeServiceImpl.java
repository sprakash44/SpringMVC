package imcs.training.service;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import imcs.training.model.Employee;
public class EmployeeServiceImpl implements EmployeeService{
	
	final static Logger logger=Logger.getLogger(EmployeeServiceImpl.class);
	
	@Autowired
	private RestTemplate rt;
	
	private final String url="http://localhost:8080/employee";
	
	public List<Employee> getEmployees(int deptNo) throws SQLException{
		logger.debug("get employees service");
		ResponseEntity response=rt.getForEntity(url+"/"+deptNo, List.class);
		return (List<Employee>) response.getBody();
		//rt.getForObject(url,Employee.class,deptNo);
		//return (List<Employee>)rt.getForObject(url+"?deptNo="+deptNo,List.class);
		//return null;
	}

	@Override
	public Employee getEmployee(int empId) throws SQLException{
		logger.debug("get employee service");
		ResponseEntity<Employee> response=rt.getForEntity(url+"/"+empId, Employee.class);
		logger.debug("get employee service code"+response.getStatusCodeValue());
		if(response.getStatusCodeValue()==200 && response.getBody()==null){
			return null;
		}
		return response.getBody();
	}
	@Override
	public int addEmployee(Employee emp) throws SQLException{
		ResponseEntity<Integer> response=rt.postForEntity(url, emp,Integer.class);
		logger.debug("add employee service code"+response.getStatusCodeValue()+" "+response.getBody());
		return response.getBody();
	}

	@Override
	public void deleteEmployee(int empId) throws SQLException{
		logger.debug("delete employee service");
		rt.delete(url + "/" + empId);
		
	}

	@Override
	public boolean updateEmployee(Employee emp) throws SQLException{
		logger.debug("update employee service");
		HttpEntity<Employee> request = new HttpEntity<>(emp);
		ResponseEntity res=  rt.exchange(url, HttpMethod.PUT, request, Employee.class);
		if(res.getStatusCodeValue()==200)
			return true;
		else
			return false;
	}
}