<%@ page import="com.js.carpark.model.auth.UserModel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <link rel="stylesheet" href="./css/style.css"/>
    <style>


        .btn-success {
            background-color: #5CB85C;
            --bs-btn-border-color: #92A992;
        }

        label span {
            color: red;
        }

        
        invalid-feedback {
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875em;
            color: #dc3545;
        }
    </style>


</head>
<body>
<%
    UserModel userModel = (UserModel) session.getAttribute("userModel");
    if (userModel != null && userModel.getDepartment().equals("parking") ) {
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
                <li>
                    <a href="#" class="nav-link px-3 active">
                        <span class="me-2"><i class="bi bi-speedometer2"></i></span>
                        <span>Car park manager</span>
                    </a>
                </li>
                <li class="my-0">
                    <hr class="dropdown-divider bg-light"/>
                </li>
                <li>
                    <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#carManager"
                       aria-expanded="true">
                        <span class="me-2"><i class="bi bi-car-front-fill"></i></span>
                        <span>Car manager</span>
                        <span class="ms-auto">
                <span class="right-icon">
                  <i class="bi bi-chevron-left"></i>
                </span>
              </span>
                    </a>
                    <div class="collapse show" id="carManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="car-list" class="nav-link px-3">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Car list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-car" class="nav-link px-3 ${isUpdate == false ? "choosing" : ""}">
                                    <span class="me-2"><i class="bi bi-plus"></i></span>
                                    <span>Add car</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="my-0">
                    <hr class="dropdown-divider bg-light"/>
                </li>
                <li>
                    <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#bookingOfficeManager"
                       aria-expanded="false">
                        <span class="me-2"><i class="bi bi-cart-fill"></i></span>
                        <span>Booking office manager</span>
                        <span class="ms-auto">
                             <span class="right-icon">
                                 <i class="bi bi-chevron-left"></i>
                             </span>
                         </span>
                    </a>
                    <div class="collapse" id="bookingOfficeManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="booking-office-list" class="nav-link px-3">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Booking office list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-booking-office" class="nav-link px-3">
                                    <span class="me-2"><i class="bi bi-plus"></i></span>
                                    <span>Add booking office</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="my-0">
                    <hr class="dropdown-divider bg-light"/>
                </li>
                <li>
                    <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#parkingLotManager">
                        <span class="me-2"><i class="bi bi-geo-alt-fill"></i></span>
                        <span>Parking lot manager</span>
                        <span class="ms-auto">
                             <span class="right-icon">
                                 <i class="bi bi-chevron-left"></i>
                             </span>
                         </span>
                    </a>
                    <div class="collapse" id="parkingLotManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="parking-lot-list" class="nav-link px-3">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Parking lot list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-parking-lot" class="nav-link px-3">
                                    <span class="me-2"><i class="bi bi-plus"></i></span>
                                    <span>Add parking lot</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="my-0">
                    <hr class="dropdown-divider bg-light"/>
                </li>
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
                            <%--@elvariable id="carAddModel" type="com.js.carpark.model.car.CarAddModel"--%>
                            <form:form method="post" modelAttribute="carAddModel" class="row g-3 needs-validation"
                                       novalidate="true">
                                <c:if test="${error != null}">
                                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                            ${error}
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <!-- License Plate -->
                                <div class="mb-3 row mt-5 fw-bold">
                                    <form:label for="license_plate" class="col-sm-2 col-form-label fw-bold"
                                                path="id">License Plate
                                        <span class="text-danger">(*)</span>
                                    </form:label>
                                    <div class="col-sm-10">
                                        <div class="row g-3">
                                            <div class="col-sm-10">
                                                <form:input type="text" class="form-control" id="license_plate"
                                                            name="license_plate" readonly="${isUpdate == true ? 'true' : 'false'}"
                                                            placeholder="Enter License Plate" maxlength="50"
                                                            required="true"
                                                            path="id"/>
                                                <div class="invalid-feedback">
                                                    Please input License Plate.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Car Type -->
                                <div class="row mb-3">
                                    <form:label for="car_type" class="col-sm-2 col-form-label fw-bold"
                                                path="carType">Car type
                                    </form:label>
                                    <div class="col-sm-10">
                                        <div class="row g-3">
                                            <div class="col-sm-10">
                                                <form:input type="text" class="form-control" id="car_type"
                                                            name="car_type"
                                                            placeholder="Enter Car Type" maxlength="5" path="carType"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Car Color -->
                                <div class="row mb-3">
                                    <form:label for="car_color" class="col-sm-2 col-form-label fw-bold"
                                                path="carColor"> Car color
                                    </form:label>
                                    <div class="col-sm-10">
                                        <div class="row g-3">
                                            <div class="col-sm-10">
                                                <form:input type="text" class="form-control" id="car_color"
                                                            name="car_color"
                                                            placeholder="Enter Car color" maxlength="50"
                                                            path="carColor"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Company -->
                                <div class="row mb-3">
                                    <form:label for="company" class="col-sm-2 col-form-label fw-bold" path="company">Company
                                        <span class="text-danger">(*)</span>
                                    </form:label>
                                    <div class="col-sm-10">
                                        <div class="row g-3">
                                            <div class="col-sm-10">
                                                <form:select class="form-select" name="company" id="company"
                                                             required="true"
                                                             path="company">
                                                    <option value="Phuong dong" ${carAddModel.company.equals("Phuong dong") ? "selected" : ""}>Phuong dong</option>
                                                    <option value="Phuong tay" ${carAddModel.company.equals("Phuong tay") ? "selected" : ""}>Phuong tay</option>
                                                    <option value="Phuong nam" ${carAddModel.company.equals("Phuong nam") ? "selected" : ""}>Phuong nam</option>
                                                    <option value="Phuong bac" ${carAddModel.company.equals("Phuong bac") ? "selected" : ""}>Phuong bac</option>
                                                </form:select>
                                                <div class="invalid-feedback">
                                                    Please select a valid state.
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Parking lot -->
                                <div class="row mb-3">
                                    <form:label for="parkId" class="col-sm-2 col-form-label fw-bold" path="parkId">Parking lot
                                        <span class="text-danger">(*)</span>
                                    </form:label>
                                    <div class="col-sm-10">
                                        <div class="row g-3">
                                            <div class="col-sm-10">
                                                <form:select class="form-select" name="parkId" id="parkId" required="true" path="parkId">
                                                    <c:forEach items="${parkingLotModels}" var="model">
                                                        <option value="${model.id}" ${carAddModel.parkId.equals(model.id) ? "selected" : ""}>${model.name}</option>
                                                    </c:forEach>
                                                </form:select>
                                                <div class="invalid-feedback">
                                                    Please select a valid state.
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-center">
                                    <button type="reset" class="btn btn-warning pe-3 me-3">
                                    <span class="me-2">
                                        <i class="bi bi-arrow-counterclockwise"></i>Reset
                                    </span>
                                    </button>
                                    <c:if test="${isUpdate == true}">
                                        <!-- update -->
                                        <button type="submit" class="btn btn-success">
                                            <i class="fa fa-floppy-disk"></i> Save
                                        </button>
                                    </c:if>
                                    <c:if test="${isUpdate == false}">
                                        <!-- add -->
                                        <button type="submit" class="btn btn-success">
                                            <i class="fa fa-plus" aria-hidden="true"></i> Add
                                        </button>
                                    </c:if>
                                </div>
                            </form:form>
                        </div>
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