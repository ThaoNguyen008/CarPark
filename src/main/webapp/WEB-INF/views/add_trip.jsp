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
    <title>Trip list</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css"/>
    <link rel="stylesheet" href="./css/dataTables.bootstrap5.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="./css/style.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
</head>

<body>
<%
    UserModel userModel = (UserModel) session.getAttribute("userModel");
    if (userModel != null && userModel.getDepartment().equals("service") ) {
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
                    <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#bookingOfficeManager"
                       aria-expanded="true">
                        <span class="me-2"><i class="fa-solid fa-plane"></i></span>
                        <span>Trip manager</span>
                        <span class="ms-auto">
                <span class="right-icon">
                  <i class="bi bi-chevron-left"></i>
                </span>
              </span>
                    </a>
                    <div class="collapse show" id="bookingOfficeManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="trip-list" class="nav-link px-3 ">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Trip list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-trip" class="nav-link px-3  ${isUpdate == false ? "choosing" : ""}">
                                    <span class="me-2"><i class="fa-solid fa-plus"></i></span>
                                    <span>Add trip</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="my-0">
                    <hr class="dropdown-divider bg-light"/>
                </li>
                <li>
                    <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#parkingLotManager"
                       aria-expanded="false">
                        <span class="me-2"><i class="fa-sharp fa-solid fa-ticket"></i></span>
                        <span>Ticket manager</span>
                        <span class="ms-auto">
                <span class="right-icon">
                  <i class="bi bi-chevron-left"></i>
                </span>
              </span>
                    </a>
                    <div class="collapse" id="parkingLotManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="ticket-list" class="nav-link px-3">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Ticket list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-ticket" class="nav-link px-3">
                                    <span class="me-2"><i class="fa-solid fa-plus"></i></span>
                                    <span>Add ticket </span>
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
                    <%--@elvariable id="tripAddModel" type="com.js.carpark.model.TripAddModel"--%>
                    <form:form class="row g-3 needs-validation" novalidate="true" method="post"
                               modelAttribute="tripAddModel">
                        <form:input type="text" path="id" hidden="true"/>
                        <div class="mb-3 row mt-5 fw-bold">
                            <form:label class="col-sm-2 col-form-label col-2"
                                        style="min-width: 160px; white-space: nowrap;"
                                        path="destination">Destination
                                <span
                                        class="text-danger">(*)</span></form:label>

                            <div class="col-sm-5">
<%--                                <input type="text" maxlength="50" required placeholder="Enter destination"--%>
<%--                                       class="form-control" id="inputDestination" name="destination">--%>
                                <form:input type="text" placeholder="Enter destination" class="form-control "
                                            id="inputDestination" maxlength="50" required="true"
                                            path="destination"/>
                                <div class="invalid-feedback">Please Enter Destination.</div>
                            </div>
                        </div>
                        <div class="mb-3 row mt-3 fw-bold">
<%--                            <label class="col-sm-2 col-form-label col-2" style="min-width: 160px; white-space: nowrap;">Departure--%>
<%--                                time <span class="text-danger">(*)</span></label>--%>
    <form:label class="col-sm-2 col-form-label col-2"
                style="min-width: 160px; white-space: nowrap; "
                path="departureTime">Departure time <span
            class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">
<%--                                <input type="time" maxlength="50" required placeholder="Enter full name"--%>
<%--                                       class="form-control" id="inputDepatureTime">--%>
                                <form:input type="time" placeholder="Enter Departure time" class="form-control"
                                            id="inputDepatureTime" required="true" maxlength="50"
                                            path="departureTime"/>
                                <div class="invalid-feedback">Please Enter departure time.</div>
                            </div>
                        </div>
                        <div class="mb-3 row mt-3 fw-bold">
<%--                            <label class="col-sm-2 col-form-label col-2" style="min-width: 160px; white-space: nowrap;">Driver--%>
<%--                                <span class="text-danger">(*)</span></label>--%>
                            <form:label class="col-sm-2 col-form-label col-2"
                                        style="min-width: 160px; white-space: nowrap;"
                                        path="driver">Driver<span
                                    class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">
<%--                                <input type="text" maxlength="50" required placeholder="Enter driver"--%>
<%--                                       class="form-control" id="inputDriver">--%>
                                <form:input type="text" class="form-control" id="inputDriver" required="true"
                                            path="driver"/>
                                <div class="invalid-feedback">Please Enter Driver.</div>
                            </div>
                        </div>
                        <div class="mb-3 row mt-3 fw-bold">
<%--                            <label class="col-sm-2 col-form-label col-2" style="min-width: 160px; white-space: nowrap;">Car--%>
<%--                                type <span class="text-danger">(*)</span></label>--%>
                            <form:label class="col-sm-2 col-form-label col-2"
                                        style="min-width: 160px; white-space: nowrap;"
                                        path="carType">Car
                                type<span
                                class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">
<%--                                <input type="text" maxlength="50" required placeholder="Enter car type"--%>
<%--                                       class="form-control" id="inputCarType">--%>
                                <form:input type="text" class="form-control" id="inputCarType" required="true"
                                            path="carType"/>
                                <div class="invalid-feedback">Please Enter Car type.</div>
                            </div>
                        </div>
                        <div class="mb-3 row mt-3 fw-bold">
<%--                            <label class="col-sm-2 col-form-label col-2" style="min-width: 160px; white-space: nowrap;">Maximum--%>
<%--                                online<br/> ticket number <span class="text-danger">(*)</span></label>--%>
                            <form:label class="col-sm-2 col-form-label col-2"
                                        style="min-width: 160px; white-space: nowrap;"
                                        path="maximumOnlineTicketNumber">Maximum online
                                <span
                                class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">
<%--                                <input type="text" required placeholder="0" class="form-control" id="inputMax">--%>
                                <form:input type="number" class="form-control" id="inputMax" required="true"
                                            path="maximumOnlineTicketNumber" placeholder="0" />
                                <div class="invalid-feedback">Please Enter Maximum online ticket number.</div>
                            </div>
                        </div>
                        <div class="mb-3 row mt-3 fw-bold">
<%--                            <label class="col-sm-2 col-form-label col-2" style="min-width: 160px; white-space: nowrap;">Departure--%>
<%--                                Date <span class="text-danger">(*)</span></label>--%>
    <form:label class="col-sm-2 col-form-label col-2"
                style="min-width: 160px; white-space: nowrap;"
                path="departureDate">Departure Date
        <span
                class="text-danger">(*)</span></form:label>
                            <div class="col-sm-5">
<%--                                <input type="date" required placeholder="Enter full name" class="form-control"--%>
<%--                                       id="inputFullName">--%>
                                <form:input type="date" class="form-control" id="inputDepartureDate" required="true"
                                            path="departureDate"/>
                                <div class="invalid-feedback">Please Enter Departure Date.</div>
                            </div>
                        </div>

                        <div class="row mt-5 mb-3">
                            <div class="col-sm-8 text-center">
                                <!-- reset -->
                                <button type="reset" class="btn btn-warning me-2">
                                    <i class="bi bi-arrow-counterclockwise"></i> Reset
                                </button>
                                <c:if test="${isUpdate == true}">
                                    <!-- update -->
                                    <button type="submit" class="btn btn-success">
                                        <i class="fa fa-floppy-disk"></i> Save
                                    </button>
                                </c:if>
                                <!-- add -->
                                <c:if test="${isUpdate == false}">
                                    <!-- add -->
                                    <button type="submit" class="btn btn-success">
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