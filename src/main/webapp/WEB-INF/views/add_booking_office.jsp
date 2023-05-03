<%@ page import="com.js.carpark.model.auth.UserModel" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 12/12/2022
  Time: 10:06 AM
  To change this template use File | Settings | File Templates.
--%>
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
                    <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#carManager">
                        <span class="me-2"><i class="bi bi-car-front-fill"></i></span>
                        <span>Car manager</span>
                        <span class="ms-auto">
                                <span class="right-icon">
                                    <i class="bi bi-chevron-left"></i>
                                </span>
                            </span>
                    </a>
                    <div class="collapse" id="carManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="car-list" class="nav-link px-3">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Car list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-car" class="nav-link px-3">
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
                       aria-expanded="true">
                        <span class="me-2"><i class="bi bi-cart-fill"></i></span>
                        <span>Booking office manager</span>
                        <span class="ms-auto">
                                <span class="right-icon">
                                    <i class="bi bi-chevron-left"></i>
                                </span>
                            </span>
                    </a>
                    <div class="collapse show" id="bookingOfficeManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="booking-office-list" class="nav-link px-3">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Booking office list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-booking-office" class="nav-link px-3 ${isAdd == true ? "choosing" : ""}">
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
                        <p class="card-text">
                            <%--@elvariable id="bookingAddModel" type="com.js.carpark.model.booking.BookingAddModel"--%>
                            <form:form class="row g-3 needs-validation" novalidate="true" method="post"
                                       modelAttribute="bookingAddModel">

                            <!--Booking office name -->
                        <div class="mb-3 row mt-5 fw-bold">
                            <form:label class="col-sm-3 col-form-label col-2"
                                        style="min-width: 160px; white-space: nowrap;"
                                        path="officeName">Booking office name <br/><span
                                    class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">

                                <form:input type="text" placeholder="Enter booking office name" class="form-control"
                                            id="inputBookingOfficeName" maxlength="50" required="true"
                                            path="officeName" readonly="${isAdd == false?'true':'false'}"/>

                                <div class="invalid-feedback">Please Enter booking office name.</div>
                            </div>
                        </div>
                        <!--Trip -->

                        <div class="mb-3 row fw-bold">
                            <form:label class="col-sm-3 col-form-label col-2"
                                        style="min-width: 160px; white-space: nowrap;" path="tripId">Trip <span
                                    class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">
                                <form:select class="form-select" required="true" path="tripId" readonly="${isAdd == false?'true':'false'}">


                                    <c:forEach items="${listModels}" var="list">


                                            <option value="${list.id}" ${bookingAddModel.tripId == list.id ? "selected" : ""}>${list.destination}</option>


                                    </c:forEach>
                                </form:select>
                                <div class="invalid-feedback">Please Choose Trip.</div>
                            </div>
                        </div>

                        <!--PhoneNumber -->
                        <div class="mb-3 row  fw-bold">
                            <form:label class="col-sm-3 col-form-label col-2"
                                        style="min-width: 160px; white-space: nowrap; " path="officePhone">Phone Number
                                <span
                                        class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">
                                <form:input type="text" placeholder="Enter phone number" class="form-control"
                                            id="inputPhoneNumber" required="true" maxlength="50" path="officePhone" readonly="${isAdd == false?'true':'false'}"/>
                                <div class="invalid-feedback">Please Enter a Phone Number.</div>
                            </div>
                        </div>

                        <!--Place -->

                        <div class="mb-3 row fw-bold">
                            <form:label class="col-sm-3 col-form-label col-2"
                                        style="min-width: 160px; white-space: nowrap;" path="officePlace">Place <span
                                    class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">
                                <form:select class="form-select" id="inputPlace" path="officePlace" readonly="${isAdd == false?'true':'false'}">

                                    <c:forEach items="${bookingPlaceModels}" var="book">

                                        <option>${book.officePlace}</option>

                                    </c:forEach>
                                </form:select>
                                <div class="invalid-feedback">Please Choose Place.</div>
                            </div>
                        </div>

                        <!--Price -->

                        <div class="mb-3 row  fw-bold">
                            <form:label class="col-sm-3 col-form-label col-2"
                                        style="min-width: 160px; white-space: nowrap; " path="officePrice">Price <span
                                    class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">
                                <form:input type="number" placeholder="Enter Price" class="form-control"
                                            id="inputPrice" required="true" maxlength="50" path="officePrice" readonly="${isAdd == false?'true':'false'}"/>

                                <div class="invalid-feedback">Please Enter Price.</div>
                            </div>
                            <div class="col-sm fw-bold align-self-center">(VND)</div>
                        </div>
                        <!--Contract deadline -->
                        <div class="mb-3 row  fw-bold">
                            <label class="col-sm-3 col-form-label col-2"
                            >Contract deadline <span
                                    class="text-danger">(*)</span></label>

                            <div class="col-sm-6">
                                <div class="row g-3">
                                    <div class="col-sm-10">
                                        <div class="input-group mb-3">
                                            <form:label class="input-group-text" id="from-date"
                                                        style="width: 25%;"
                                                        path="startContractDeadline">From date</form:label>
                                            <form:input type="date" class="form-control" aria-label="From date"
                                                        required="true"  aria-describedby="from-date" path="startContractDeadline" readonly="${isAdd == false?'true':'false'}"/>
                                            <div class="invalid-feedback">Please date.</div>
                                        </div>
                                    </div>

                                </div>

                                <div class="row g-3">
                                    <div class="col-sm-10">
                                        <div class="input-group mb-3">
                                            <form:label class="input-group-text" id="to-date" style="width: 25%;"
                                                        path="endContractDeadline">To
                                                date</form:label>
                                            <form:input type="date" class="form-control" aria-label="To date"
                                                        required="true"   aria-describedby="to-date" path="endContractDeadline" readonly="${isAdd == false?'true':'false'}"/>
                                            <div class="invalid-feedback">Please date.</div>

                                        </div>

                                    </div>

                                </div>

                            </div>
                        </div>

                        <div class="d-flex justify-content-center">
                            <c:if test="${isAdd == true}">
                            <button type="reset" class="btn btn-warning pe-3 me-3">
                                        <span class="me-2">
                                            <i class="bi bi-arrow-counterclockwise"></i>
                                        </span>
                                <span> Reset </span></button>
                            </c:if>

                            <c:if test="${isAdd == true}">
                            <button type="submit" class="btn btn-success pe-3 me-3">
                                        <span class="me-2">
                                            <i class="bi bi-plus"></i>
                                        </span>
                                <span> Add </span>
                            </button>
                            </c:if>
                        </div>


                        </form:form>
                    </div>
                </div>
                </p>
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
