<%@ page import="com.js.carpark.model.auth.UserModel" %>
<%@ page import="com.js.carpark.model.employee.EmployeeAddModel" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>${title}</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css"/>
    <link rel="stylesheet" href="./css/dataTables.bootstrap5.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="./css/style.css"/>
</head>

<body>

<%
    UserModel userModel = (UserModel) session.getAttribute("userModel");
    EmployeeAddModel employeeAddModel = (EmployeeAddModel) session.getAttribute("employeeAddModel");
    if (userModel != null) {
%>
<!-- navbar -->
<nav class="navbar navbar-expand-lg bg-light fixed-top border-bottom">
    <div class="container-fluid">
        <!-- offcanvas trigger -->
        <button class="navbar-toggler me-2" type="button" data-bs-toggle="offcanvas"
                data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
            <i class="bi bi-" data-bs-target="#offcanvasExample"></i>
        </button>
        <!-- offcanvas trigger -->
        <a class="navbar-brand me-auto text-black-50" href="#">
                <span class="me-2">
                    <i class="fa fa-users" aria-hidden="true"></i>
                </span>
            <span style="text-transform: capitalize"> ${sessionScope.userModel.department} </span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation"><i class="bi bi-list"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav nav d-flex ms-auto mb-2 mb-lg-0">
                <li class="nav-item accordion">
                    <a class="nav-link" href="view-employee-${sessionScope.userModel.id}">Welcome <c:out value="${sessionScope.userModel.name}"/></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="logout">
                            <span class="me-2">
                                <i class="fa fa-sign-out" aria-hidden="true"></i>
                            </span>
                        <span> Logout </span>
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- navbar -->



<!-- offcanvas -->
<div class="offcanvas offcanvas-start bg-light sidebar-nav" tabindex="-1" id="offcanvasExample"
     aria-labelledby="offcanvasExampleLabel">
    <div class="offcanvas-body p-0">
        <nav class="navbar-light">
            <ul class="navbar-nav">
                <c:if test="${sessionScope.userModel.department.equals('employee')}">
                <li>
                    <a href="#" class="nav-link px-3">
                        <span class="me-2"><i class="fa fa-tachometer" aria-hidden="true"></i></span>
                        <span> Dashboard </span>
                    </a>
                </li>
                <li class="my-0">
                    <hr class="dropdown-divider bg-light"/>
                </li>
                <li>
                    <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#carManager">
                        <span class="me-2"><i class="fa fa-bar-chart" aria-hidden="true"></i></span>
                        <span>Employee manager</span>
                        <span class="ms-auto">
                                <span class="right-icon">
                                    <i class="bi bi-chevron-left"></i>
                                </span>
                            </span>
                    </a>
                    <div class="collapse show" id="carManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="employee-list" class="nav-link px-3">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Employee list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-employee" class="nav-link px-3 ${isUpdate == false ? "choosing" : ""}">
                                    <span class="me-2"><i class="bi bi-plus"></i></span>
                                    <span>Add Employee</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="my-0">
                    <hr class="dropdown-divider bg-light"/>
                </li>
                <li>
                    </c:if>
            </ul>
        </nav>
    </div>
</div>
<!-- offcanvas -->

<!-- main -->
<main class="mt-5 pt-3">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12">
                <div class=" mb-12">
                    <div class="card-header bg-body">
                        <div class="col-md-12 fs-2">${title}</div>
                    </div>
                    <div class="card-body">
                        <div class="card-text">
                            <%--@elvariable id="employeeAddModel" type="com.js.carpark.model.employee.EmployeeAddModel"--%>
                            <form:form class="row g-3 needs-validation" novalidate="true" method="post"
                                       modelAttribute="employeeAddModel">
                                <c:if test="${error != null}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                        ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <div class="mb-3 row mt-5 fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;"
                                                path="employeeName">Full Name
                                        <span
                                                class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:input type="text" placeholder="Enter full name" class="form-control "
                                                    id="inputFullName" maxlength="50" required="true"
                                                    path="employeeName"/>
                                        <div class="invalid-feedback">Please Enter a Full name.</div>
                                    </div>
                                </div>
                                <div class="mb-3 row fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap; "
                                                path="employeePhone">Phone Number <span
                                            class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:input type="text" placeholder="Enter phone number" class="form-control"
                                                    id="inputPhoneNumber" required="true" maxlength="50"
                                                    path="employeePhone"/>
                                        <div class="invalid-feedback">Please Enter a Phone Number.</div>
                                    </div>
                                </div>
                                <div class="mb-3 row fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;"
                                                path="employeeBirthdate">Date of birth <span
                                            class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:input type="date" class="form-control" id="inputDate" required="true"
                                                    path="employeeBirthdate"/>
                                        <div class="invalid-feedback">Please Choose a Date of Birth.</div>
                                        <p class="dob_error"></p>
                                    </div>
                                </div>
                                <div class="mb-3 row fw-bold">
                                    <label class="col-sm-2 col-form-label col-2"
                                           style="min-width: 160px; white-space: nowrap;">Sex <span
                                            class="text-danger">(*)</span></label>

                                    <div class="col-sm-5">
                                        <div class="form-check form-check-inline">
                                            <form:radiobutton class="form-check-input" name="sex"
                                                              id="m" value="m" checked="true" path="sex"/>
                                            <label class="form-check-label" for="m">Male</label>

                                        </div>
                                        <div class="form-check form-check-inline">
                                            <form:radiobutton class="form-check-input" name="sex"
                                                              id="f" value="f" path="sex"/>
                                            <label class="form-check-label" for="f">Female</label>

                                        </div>

                                    </div>
                                    <div class="invalid-feedback">Please Enter a Sex.</div>
                                </div>
                                <div class="mb-3 row fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;"
                                                path="employeeAddress">Address </form:label>
                                    <div class="col-sm-5">
                                        <form:input type="text" placeholder="Enter address" class="form-control"
                                                    id="inputAddress" path="employeeAddress"/>
                                    </div>
                                </div>
                                <div class="mb-3 row fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;"
                                                path="employeeEmail">Email </form:label>
                                    <div class="col-sm-5">
                                        <form:input type="email" placeholder="Enter Email" class="form-control"
                                                    id="inputEmail"
                                                    required="true" maxlength="50" path="employeeEmail"/>
                                    </div>
                                </div>
                                <div class="mb-3 row fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;" path="account">Account
                                        <span
                                                class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:input type="text" placeholder="Enter Account" class="form-control"
                                                    id="inputAccount" required="true" maxlength="50" path="account"/>
                                        <div class="invalid-feedback">Please Enter Account.</div>
                                    </div>
                                </div>
                                <div class="mb-3 row fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;" path="password">Password
                                        <span
                                                class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <%
                                            if (userModel.getId()==employeeAddModel.getId()){
                                        %>
                                        <form:input type="password" placeholder="Enter password" class="form-control"
                                                    id="inputPassword" name="inputPassword"
                                                    pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"
                                                    title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
                                                    required="true" path="password" readonly="false"/>
                                        <%
                                        }else{
                                        %>
                                        <form:input type="password" placeholder="Enter password" class="form-control"
                                                    id="inputPassword" name="inputPassword"
                                                    pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"
                                                    title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters"
                                                    required="true" path="password" readonly="true"/>
                                        <%
                                            }
                                        %>
                                        <div class="invalid-feedback">Please Enter Password.</div>
                                        <div class="invalid-feedback">Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters</div>
                                        <div id="messagesss" name="messagesss" style="display:none ;">
                                            <p>Password must contain the following:</p>
                                            <p id="letter" class="invalid">A <b>lowercase</b> letter</p>
                                            <p id="capital" class="invalid">A <b>capital (uppercase)</b> letter</p>
                                            <p id="number" class="invalid">A <b>number</b></p>
                                            <p id="length" class="invalid">Minimum <b>6 characters</b></p>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    if (userModel.getDepartment().equals("employee")){
                                %>
                                <div class="mb-3 row fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;" path="department">Department
                                        <span
                                                class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:select class="form-select" path="department" disabled="false">
                                            <option value="employee" selected>employee</option>
                                            <option value="parking">parking</option>
                                            <option value="service">service</option>
                                        </form:select>
                                        <div class="invalid-feedback">Please Choose Department.</div>
                                    </div>
                                </div>
                                <%
                                    }else{
                                %>
                                <div class="mb-3 row fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;" path="department">Department
                                        <span
                                                class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:input type="hidden" path ="department" value="${employeeAddModel.department}"/>
                                        <form:select class="form-select" path="department" disabled="true">
                                            <option value="employee" selected>${employeeAddModel.department}</option>
                                        </form:select>
                                        <div class="invalid-feedback">Please Choose Department.</div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                                <div class="row mt-5 mb-3">
                                    <div class="col-sm-8 text-center">
                                        <!-- back -->
                                        <a onCLick="history.back()" id="backBtn" type="button"
                                           class="btn btn-info me-2">
                                            <i class="bi bi-skip-backward-fill"> </i> Back
                                        </a>

                                        <!-- reset -->
                                        <button type="reset" class="btn btn-warning me-2">
                                            <i class="bi bi-arrow-counterclockwise"></i> Reset
                                        </button>

                                        <c:if test="${isUpdate == true}">
                                            <!-- update -->
                                            <button type="submit" class="btn btn-success me-2">
                                                <i class="fa fa-floppy-disk"></i> Save
                                            </button>
                                        </c:if>
                                        <c:if test="${isUpdate == false}">
                                            <!-- add -->
                                            <button type="submit" class="btn btn-success me-2">
                                                <i class="fa fa-plus" aria-hidden="true"></i> Add
                                            </button>
                                        </c:if>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
<!-- main -->
<%
}
else {
%>
<h2 style="color: #000000;font-weight: bold">Sorry either you are logged out or no session
    exists for you !!!...</h2>
<a href="logout">Click here to Login</a>
<%
    }
%>
<script src="./js/bootstrap.bundle.min.js"></script>
<script src="./js/jquery-3.5.1.js"></script>
<script src="./js/jquery.dataTables.min.js"></script>
<script src="./js/dataTables.bootstrap5.min.js"></script>
<script src="./js/script.js"></script>


</body>

</html>