package imcs.training.controller;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import imcs.training.model.Employee;
import imcs.training.service.DepartmentService;
import imcs.training.service.EmployeeService;

@Controller
@RequestMapping("/")
public class EmpController {

	final static Logger logger = Logger.getLogger(EmpController.class);

	@Autowired
	EmployeeService empService;

	@Autowired
	DepartmentService deptService;

	@ModelAttribute("addEmp")
	public Employee getAddEmp() {
		return new Employee();
	}

	@RequestMapping(method = RequestMethod.GET)
	public String defaultPage() {
		logger.debug("default page called");
		return "index";
	}

	@RequestMapping(value = "EmployeeView", method = RequestMethod.GET)
	public String employeePage() {
		logger.debug("Employee page called");
		return "employeeView";
	}

	@InitBinder
	protected void initBinder(WebDataBinder binder) {
		logger.debug("init binder called");
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}

	@RequestMapping(value = "findEmployee", method = RequestMethod.POST)
	public ModelAndView getEmployee(@RequestParam int empNo, @RequestParam String pageType) throws SQLException {
		logger.debug("employee find controller");
		Employee emp = empService.getEmployee(empNo);
		ModelAndView model = new ModelAndView("employeeView");
		model.addObject("pageType", pageType);
		if (null != emp) {
			model.addObject("employee", emp);
			return model;
		} else {
			model.addObject("msg", "Employee not found for Id : " + empNo);
			model.addObject("employee", null);
			return model;
		}
	}

	@RequestMapping(value = "/addEmployee", method = RequestMethod.POST)
	public ModelAndView addEmployee(@ModelAttribute("addEmp") Employee emp) throws SQLException {
		logger.debug("add employee controller");
		emp.setEmpNo(0);
		int id = empService.addEmployee(emp);
		ModelAndView model = new ModelAndView("employee");
		if (id != 0) {
			emp.setEmpNo(id);
			model.addObject("msg", "Employee added successfully");
			model.addObject("employeeAddUpdate", emp);
		} else
			model.addObject("msg", "Unable to add the employee");
		return model;
	}

	@RequestMapping(value = "/updateEmployee", method = RequestMethod.POST)
	public ModelAndView updateEmployee(@ModelAttribute Employee employee, @RequestParam int deptNoUpd,
			@RequestParam String pageType) throws SQLException {
		logger.debug("update employee controler");
		ModelAndView model = new ModelAndView();
		if (empService.updateEmployee(employee)) {
			if (pageType.equals("department")) {
				model = new ModelAndView("department");
				model.addObject("deptMsg", "Employee : " + employee.getEmpNo() + " updated successfully");
				model.addObject("department", deptService.getDepartment(deptNoUpd));
				model.addObject("empList", empService.getEmployees(deptNoUpd));
			} else {
				model = new ModelAndView("employee");
				model.addObject("msg", "Employee : " + employee.getEmpNo() + " updated successfully");
				model.addObject("employeeAddUpdate", employee);
				model.addObject("employee", null);
			}
		} else {
			if (pageType.equals("department")) {
				model = new ModelAndView("department");
				model.addObject("deptMsg", "Unable to update the employee, Try again later");
				model.addObject("department", deptService.getDepartment(deptNoUpd));
				model.addObject("empList", empService.getEmployees(deptNoUpd));
			} else {
				model = new ModelAndView("employee");
				model.addObject("msg", "Unable to update the employee, Try again later");
				model.addObject("employee", null);
			}
		}
		return model;
	}

	@RequestMapping(value = "/deleteEmployee", method = RequestMethod.POST)
	public ModelAndView deletEmployee(@RequestParam("empNo") int empNo, @RequestParam int deptNo,
			@RequestParam String pageType) throws SQLException {
		logger.debug("delete employee controller");
		ModelAndView model = new ModelAndView();
		empService.deleteEmployee(empNo);
		if (pageType.equals("department")) {
			model = new ModelAndView("department");
			model.addObject("deptMsg", "Employee : " + empNo + " deleted successfully");
			model.addObject("department", deptService.getDepartment(deptNo));
			model.addObject("empList", empService.getEmployees(deptNo));
		} else {
			model = new ModelAndView("employee");
			model.addObject("msg", "Employee : " + empNo + " deleted successfully");
			model.addObject("employee", null);
		}

		return model;

	}

	@RequestMapping(value = "/getDeptEmployees", method = RequestMethod.POST)
	public ModelAndView getEmployees(@RequestParam int deptNo) throws SQLException {
		logger.debug("get employees by dept no controller");
		ModelAndView model = new ModelAndView("department");
		List<Employee> emps = new ArrayList<>();
		emps = empService.getEmployees(deptNo);
		if (emps.size() != 0) {
			model.addObject("empList", emps);
			return model;
		} else {
			model.addObject("deptMsg", "No employees in respective Department");
			return model;
		}
	}
}
