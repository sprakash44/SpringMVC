<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Organisation Management</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<style>
/* Remove the navbar's default margin-bottom and rounded borders */
.navbar {
	margin-bottom: 0;
	border-radius: 0;
}
/* Set height of the grid so .sidenav can be 100% (adjust as needed) */
.row.content {
	height: 600px;
	background-color: #f1f1f1;
}
.sidenav {
	padding-top: 20px;
	background-color: #696969;
	height: 100%;
}
footer {
	background-color: #555;
	color: white;
	padding: 15px;
}
</style>
</head>
<body>

	<nav role="navigation" class="navbar navbar-default">
	<div class="">
		<a href="#" class="navbar-brand">IMCS</a>
	</div>
	<div class="navbar-collapse">
		<ul class="nav navbar-nav">
			<li><a id="homeTab" href="/">Home</a></li>
			<li><a id="todosTab" href="/list-todos">Todos</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="/logout">Logout</a></li>
		</ul>
	</div>
	</nav>

	<div class="container-fluid text-center">
		<div class="row content">
			<div class="col-sm-2 sidenav"></div>
			<div class="col-sm-8">
				<br>
				<div class="row" style="width:70%;margin: 0 auto;">
					<form method="get" action="/findDepartment">
						<div class="col-sm-6">
							<input type="number" name="deptNo" class="form-control"
								placeholder="Enter Department Number" required />
						</div>
						<div class="col-sm-6">
							<button  type="submit">
								<span class="glyphicon glyphicon-search"></span>Search
								Department
							</button>
						</div>
					</form>
				</div>
				<br>
				<div class="row" id="deptMessage">
					<c:if test="${not empty deptMsg}">
					${deptMsg}
				</c:if>
				</div>
				<br>
				<div class="row" id="displayDept" style="width:70%;margin: 0 auto;">
				<c:if test="${not empty department}">
					
						<form method="post" action="/getDeptEmployees">
							<input
								type="hidden" name="deptNo" value="${department.deptNo}" />
							<table class="table">
								<tr>
									<td>Department ID :</td>
									<td>${department.deptNo}</td>
								</tr>
								<tr>
									<td>Department Name :</td>
									<td>${department.deptName}</td>
								</tr>
								<tr>
									<td colspan="2"><button type="submit" >View
											Employees</button></td>
											 
								</tr>
							</table>
						</form>
					
				</c:if>
				</div>
					<br>
				<c:if test="${not empty empList}">
					<form id="departmentUD" method="post">
						<input type="hidden" name="empNo" id="empNoUpdDel" />
						<input type="hidden" name="deptNo" id="deptNoDept" />
						 <input type="hidden" name="pageType" value="department" /> 
						<table class="table">
						
							<tr>
								<th>Employee No</th>
								<th>Employee Name</th>
								<th>Department No</th>
								<th>Date of Birth</th>
								<th>Date of Joining</th>
								<th>Salary</th>
								<th></th>
								<th></th>
							</tr>
							<c:forEach items="${empList}" var="emp">
								<tr>

									<td>${emp.empNo}</td>
									<td>${emp.empName}</td>
									<td>${emp.deptNo}</td>
									<td>${emp.dob}</td>
									<td>${emp.doj}</td>
									<td>${emp.salary}</td>
									<td><button 
											onclick="updateEmp(${emp.empNo})">Update</button></td>
									<td><button 
											onclick="deleteEmp(${emp.empNo},${emp.deptNo})">Delete</button></td>
								</tr>
							</c:forEach>


						</table>
					</form>

				</c:if>
			</div>
			<div class="col-sm-2 sidenav"></div>
		</div>
	</div>
	<footer class="container-fluid text-center">
	<p>Cp.</p>
	</footer>
</body>
<script type="text/javascript">
	
	function updateEmp(id, deptNo) {
		$("#empNoUpdDel").val(id);
		$("#departmentUD").attr("action","/findEmployee");
		$("#departmentUD").submit();
	}
	function deleteEmp(id, deptNo) {
		$("#empNoUpdDel").val(id);
		$("#deptNoDept").val(deptNo);
		$("#departmentUD").attr("action","/deleteEmployee");
		$("#departmentUD").submit();
	}
	
</script>
</html>