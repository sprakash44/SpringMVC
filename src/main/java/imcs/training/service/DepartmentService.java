package imcs.training.service;
import java.sql.SQLException;

import org.springframework.stereotype.Service;

import imcs.training.model.Department;

@Service
public interface DepartmentService {
	public Department getDepartment(int deptNo) throws SQLException;
}