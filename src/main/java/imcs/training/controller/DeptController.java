package imcs.training.controller;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import imcs.training.model.Department;
import imcs.training.service.DepartmentService;

@Controller
public class DeptController {
	 
	final static Logger logger=Logger.getLogger(DeptController.class);
	@Autowired
	DepartmentService deptService;
	
	@RequestMapping(value="/DepartmentView",method = RequestMethod.GET)
	public String departmentPage() {
		return "departmentView";
	}
	@RequestMapping(value = "/findDepartment", method = RequestMethod.GET)
	public ModelAndView getDepartment(@RequestParam int deptNo) throws SQLException {
		logger.debug("find department controller");
		Department dept = deptService.getDepartment(deptNo);
		ModelAndView model = new ModelAndView("departmentView");
		if (null != dept) {
			model.addObject("department",dept);
			
		} else {
			model.addObject("deptMsg", "Department not found for Id : "+deptNo);
			model.addObject("department", null);
		}
		return model;
	}
}