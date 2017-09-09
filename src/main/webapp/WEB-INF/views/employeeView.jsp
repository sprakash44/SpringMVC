<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

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
	<div class="row content">
		<div class="col-sm-2 sidenav"></div>
		<div class="col-sm-8">

			<div class="container" style="width:100%">
				<br>
				<div class="row" id="firstRow" style="width:80%;margin:0 auto;">
					<div class="col-sm-8">
						<form:form method="post" action="findEmployee">
							<input type="hidden" name="pageType" value="employee" />
							<div class="col-xs-8">
								<input type="number" name="empNo"
									class="form-control" placeholder="Enter Employee number"
									required />
							</div>
							<button type="submit">
								<span class="glyphicon glyphicon-search"></span>Search Employee
							</button>
						</form:form>
					</div>
					<div class="col-sm-4">
						<button id="add1">Add Employee</button>
					</div>
				</div>
				<br>
				<div class="row" id="secondRow" style="width:50%;margin:0 auto;">
					<c:if test="${not empty msg}">${msg}</c:if>
				</div>
				<div class="row" id="thirdRow" style="width:50%;margin:0 auto;">
					<c:if test="${not empty employee}">
							<form method="post" id="formDelUpd">
								<input type="hidden" name="pageType" value="${pageType}" />
								<input type="hidden" name="deptNoUpd" value="${employee.deptNo}" />
								<table class="table">
									<c:choose>
										<c:when test="${pageType eq 'department'}">

											

											<tr>
												<td>Employee ID :</td>
												<td><input class="form-control" type="number"
													 id="empNoUpd"  disabled="disabled" value="${employee.empNo}" />
													 <input type="hidden" value="${employee.empNo}" name="empNo"/>
													</td>
											</tr>
											<tr>
												<td>Employee Name :</td>
												<td><input class="form-control" type="text"
													 id="empNameUpd" name="empName" value="${employee.empName}"/>
													</td>
											</tr>
											<tr>
												<td>Department No :</td>
												<td><select name="deptNo" id="deptNoUpd"
													class="form-control" required>
														<c:choose>
															<c:when test="${1 eq employee.deptNo}">
																<option value="1" selected="selected">Sales</option>
															</c:when>
															<c:otherwise>
																<option value="1">Sales</option>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${2 eq employee.deptNo}">
																<option value="2" selected="selected">Marketing</option>
															</c:when>
															<c:otherwise>
																<option value="2">Quality</option>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${3 eq employee.deptNo}">
																<option value="3" selected="selected">IT</option>
															</c:when>
															<c:otherwise>
																<option value="3">IT</option>
															</c:otherwise>
														</c:choose>

												</select></td>
											</tr>
											<tr>
												<td>Date of Birth :</td>
												<td><input class="form-control" type="date"
													value=<fmt:formatDate pattern='yyyy-MM-dd' value='${employee.dob}'/> id="dobUpd" name="dob"
													 required /></td>
											</tr>
											<tr>
												<td>Date of Joining :</td>
												<td><input class="form-control" type="date"
													value=<fmt:formatDate pattern='yyyy-MM-dd' value='${employee.dob}'/>  id="dojUpd" name="doj"
													required /></td>
											</tr>
											
											<tr>
												<td>Salary :</td>
												<td><input class="form-control" type="number"
													value="${employee.salary}" id="salaryUpd" name="salary"
													required /></td>
											</tr>
											<tr>
												<td>Salary Grade :</td>
												<td><input class="form-control" type="number"
													value="${employee.salGrade}" id="salGradeUpd"
													name="salGrade" required /></td>
											</tr>
											<tr>
												<td></td>
												<td>
													<button class="btn btn-success" id="updateBtn">Save</button>
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											
											<tr>
												<td>Employee ID :</td>
												<td><input class="form-control" type="number"
													value="${employee.empNo}" id="empNoUpd"
													disabled="disabled" required />
													<input type="hidden" value="${employee.empNo}" name="empNo"/>
													</td>
											</tr>
											<tr>
												<td>Employee Name :</td>
												<td><input class="form-control" type="text"
													 id="empNameUpd" name="empName" value="${employee.empName}" disabled="disabled"/>
													</td>
											</tr>
											<tr>
												<td>Department No :</td>
												<td><select name="deptNo" id="deptNoUpd"
													class="form-control" disabled="disabled" required>
														<c:choose>
															<c:when test="${1 eq employee.deptNo}">
																<option value="1" selected="selected">Sales</option>
															</c:when>
															<c:otherwise>
																<option value="1">Sales</option>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${2 eq employee.deptNo}">
																<option value="2" selected="selected">Marketing</option>
															</c:when>
															<c:otherwise>
																<option value="2">Marketing</option>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${3 eq employee.deptNo}">
																<option value="3" selected="selected">HR</option>
															</c:when>
															<c:otherwise>
																<option value="3">HR</option>
															</c:otherwise>
														</c:choose>
														<c:choose>
															<c:when test="${4 eq employee.deptNo}">
																<option value="4" selected="selected">IT</option>
															</c:when>
															<c:otherwise>
																<option value="4">IT</option>
															</c:otherwise>
														</c:choose>

												</select></td>
											</tr>
											<tr>
												<td>Date of Birth :</td>
												<td><input class="form-control" type="date"
													value=<fmt:formatDate pattern='yyyy-MM-dd' value='${employee.dob}'/> id="dobUpd" name="dob"
													disabled="disabled" required /></td>
											</tr>
											<tr>
												<td>Date of Joining :</td>
												<td><input class="form-control" type="date"
													value=<fmt:formatDate pattern='yyyy-MM-dd' value='${employee.dob}'/>  id="dojUpd" name="doj"
													disabled="disabled" required /></td>
											</tr>
											<tr>
												<td>Salary :</td>
												<td><input class="form-control" type="number"
													value="${employee.salary}" id="salaryUpd" name="salary"
													disabled="disabled" required /></td>
											</tr>
											<tr>
												<td>Salary Grade :</td>
												<td><input class="form-control" type="number"
													value="${employee.salGrade}" id="salGradeUpd"
													name="salGrade" disabled="disabled" required /></td>
											</tr>
											<tr>
												<td><label class="btn btn-success" id="enableUpd">Edit
												</label></td>
												<td>

													<button class="btn btn-success" id="updateBtn"
														disabled="disabled">Save</button>
													<button class="btn btn-success" id="deleteBtn" disabled="disabled">Delete</button>
													<a class="btn btn-success" href='/'>Cancel</a>
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
								</table>
							</form>
						<br>
					</c:if>
				</div>
				<br>
				<div class="row" id="fourthRow" style="width:60%;margin:0 auto;">

					<c:if test="${not empty employeeAddUpdate}">

						<table class="table">
							<tr>
								<td>Employee ID :</td>
								<td>${employeeAddUpdate.empNo}</td>
							</tr>
							<tr>
								<td>Department No :</td>
								<td>${employeeAddUpdate.deptNo}</td>
							</tr>
							<tr>
								<td>Date of Birth :</td>
								<td><fmt:formatDate pattern='dd-MMM-yyyy' value='${employeeAddUpdate.dob}'/></td>
							</tr>
							<tr>
								<td>Date of Joining :</td>
								<td><fmt:formatDate pattern='dd-MMM-yyyy' value='${employeeAddUpdate.doj}'/></td>
							</tr>
							<tr>
								<td>Salary :</td>
								<td>$${employeeAddUpdate.salary}</td>
							</tr>
							<tr>
								<td>Salary Grade :</td>
								<td>${employeeAddUpdate.salGrade}</td>
							</tr>
							<tr>
								<td colspan="2"><</td>
							</tr>
						</table>

					</c:if>
				</div>
				<br>
				<div class="fifthRow">
					<div id="addEmp" class="panel panel-info padding-top-20"
						style="display: none;width:70%;margin: 0 auto;">
						<div class="panel-heading">Add Employee</div>
						<div class="panel-body">
							<form:form commandName="addEmp" method="post" id="addEmpForm"
								action="/addEmployee">
								<form:errors path="*" cssClass="errorblock" element="div" />

								<input type="hidden" name="hidden" value="addEmp" />

								<div class="row" style="padding-top: 10px">
									<label for="empName" class="col-md-4 control-label">Name
										: </label>
									<div class="col-md-8">
										<input type="text" id="empName" name="empName"
											class="form-control" placeholder="Name"  />
									</div>
								</div>
								<div class="row" style="padding-top: 10px">
									<label for="deptNo" class="col-md-4 control-label">Department
										Number : </label>
									<div class="col-md-8">
										<select name="deptNo" id="deptNo" class="form-control">
											<option value="4" selected="selected">Select a
												department</option>
											<option value="1">Sales</option>
											<option value="2">Marketing</option>
											<option value="3">HR</option>
											<option value="4">IT</option>
										</select>
									</div>
								</div>
								<div class="row" style="padding-top: 10px">
									<label for="dob" class="col-md-4 control-label">Date of
										Birth : </label>
									<div class="col-md-8">
										<form:input type="date" id="dob" path="dob"
											class="form-control" placeholder="Date of Birth"  />
									</div>
								</div>
								<div class="row" style="padding-top: 10px">
									<label for="doj" class="col-md-4 control-label">Date of
										Joining : </label>
									<div class="col-md-8">
										<form:input type="date" id="doj" path="doj"
											class="form-control" placeholder="Date of Joining"  />
									</div>
								</div>
								<div class="row" style="padding-top: 10px">
									<label for="salary" class="col-md-4 control-label">Salary
										: </label>
									<div class="col-md-8 ">
										<form:input type="number" id="salary" path="salary"
											class="form-control" placeholder="Enter Salary"  />
									</div>
								</div>
								<div class="row" style="padding-top: 10px">
									<label for="salGrade" class="col-md-4 control-label">Salary
										Grade : </label>
									<div class="col-md-8">
									//made changes
										<select path="salGrade" id="salGrade" name="salGrade" class="form-control">
											<option value="1">$12k-$15k</option>
											<option value="2">$15k-$30k</option>
											<option value="3">$30k-$45k</option>
											<option value="4">$45k-$60k</option>
										</select>
									</div>
								</div>

								<div class="row" style="padding-top: 10px">
									<div class="col-md-offset-4 col-md-8">
										<div class="col-md-4">
											<button class="btn btn-success" type="submit" id="addEmpBtn">Add
												Employee</button>
										</div>
										<div class="col-md-4">
											<button class="btn btn-danger" id="cancelAdd">Cancel</button>
										</div>
										<div class="col-md-4">
											<button class="btn btn-warning" type="reset">Reset</button>
										</div>
									</div>
								</div>
							</form:form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-sm-2 sidenav"></div>
	</div>
	<footer class="container-fluid text-center">
	<p>Cp.</p>
	</footer>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		$("#add1").click(function() {
			$("#addEmp").show();
			$("#secondRow").hide();
			$("#fourthRow").hide();
		});
		$("#firstRow").click(function() {
			$("#thirdRow").hide();
			$("#fourthRow").hide();
			$("#secondRow").hide();
		});
		$("#cancelAdd").click(function() {
			$("#addEmp").hide();
		});
		$("#enableUpd").click(function() {
			$('#deleteBtn').removeAttr('disabled');
			$('#deptNoUpd').removeAttr('disabled');
			$('#dobUpd').removeAttr('disabled');
			$('#dojUpd').removeAttr('disabled');
			$('#salaryUpd').removeAttr('disabled');
			$('#salGradeUpd').removeAttr('disabled');
			$('#updateBtn').removeAttr('disabled');
			$('#empNameUpd').removeAttr('disabled');
		});
		$("#deleteBtn").click(function() {
			$("#formDelUpd").attr("action","/deleteEmployee");
			$("#formDelUpd").submit();
		});
		$("#updateBtn").click(function() {
			$("#formDelUpd").attr("action","/updateEmployee");
			$("#formDelUpd").submit();
		});
	});
	function updateEmp(id, deptNo) {
		$("#empNo").val(id);
		$("#action").val("searchEmpDept");
		$("#deptNo").val(deptNo);
		$("#departmentUD").submit();
	}
	function deleteEmp(id, deptNo) {
		$("#empNoDel").val(id);
		$("#action").val("deleteEmpDept");
		$("#deptNo").val(deptNo);
		$("#departmentUD").submit();
	}
	
</script>
</html>