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
                    <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#tripManager"
                       aria-expanded="false">
                        <span class="me-2"><i class="fa-solid fa-plane"></i></span>
                        <span>Trip manager</span>
                        <span class="ms-auto">
                <span class="right-icon">
                  <i class="bi bi-chevron-left"></i>
                </span>
              </span>
                    </a>
                    <div class="collapse" id="tripManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="trip-list" class="nav-link px-3 ">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Trip list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-trip" class="nav-link px-3">
                                    <span class="me-2"><i class="fa-solid fa-plus"></i></span>
                                    <span>Add Trip</span>
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
                       aria-expanded="true">
                        <span class="me-2"><i class="fa-sharp fa-solid fa-ticket"></i></span>
                        <span>Ticket manager</span>
                        <span class="ms-auto">
                <span class="right-icon">
                  <i class="bi bi-chevron-left"></i>
                </span>
              </span>
                    </a>
                    <div class="collapse show" id="parkingLotManager">
                        <ul class="navbar-nav ps-3">
                            <li>
                                <a href="ticket-list" class="nav-link px-3 ">
                                    <span class="me-2"><i class="bi bi-list-ul"></i></span>
                                    <span>Ticket list</span>
                                </a>
                            </li>
                            <li>
                                <a href="add-ticket" class="nav-link px-3  ${isUpdate == false ? "choosing" : ""}">
                                    <span class="me-2"><i class="fa-solid fa-plus"></i></span>
                                    <span>Add Ticket </span>
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
                            <%--@elvariable id="ticketAddModel" type="com.js.carpark.model.ticket.TicketAddModel"--%>
                            <form:form method="post" modelAttribute="ticketAddModel"
                                       class="row g-3 needs-validation" novalidate="true">
                                <div class="mb-3 row mt-5">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;" path="customerName" maxlength="11" >Customer
                                        <span class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:input type="text" placeholder="Enter customer name " class="form-control"
                                                    id="inputCustomer" required="true" path="customerName"/>
                                        <div class="invalid-feedback">Please Enter a Customer Name and contain up to 11 characters</div>
                                    </div>
                                </div>
                                <div class="mb-3 row fw-bold">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;" path="bookingTime">Booking
                                        time <span class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:input type="time" class="form-control" id="inputDepatureTime"
                                                    required="true" path="bookingTime"/>
                                        <div class="invalid-feedback">Please Booking Time.</div>
                                    </div>
                                </div>
                                <div class="mb-3 row mt-3">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;" path="tripId">Trip <span
                                            class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:select class="form-select" aria-label="Default select example"
                                                     required="true" path="tripId">
                                            <c:forEach items="${ticketTripModels}" var="model">
                                                <option value="${model.id}" ${ticketAddModel.tripId == model.id ? "selected" : ""}>${model.destination}</option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="mb-3 row mt-3">
                                    <form:label class="col-sm-2 col-form-label col-2"
                                                style="min-width: 160px; white-space: nowrap;" path="licensePlate">License
                                        plate <span class="text-danger">(*)</span></form:label>
                                    <div class="col-sm-5">
                                        <form:select class="form-select" aria-label="Default select example"
                                                     required="true" path="licensePlate">
                                            <c:forEach items="${licensePlateModels}" var="lp">
                                                <option value="${lp}" ${ticketAddModel.licensePlate.equals(lp) ? "selected" : ""}>${lp}</option>
                                            </c:forEach>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="mb-3 row mt-3">
                                    <div class="col-sm-7" style="display: flex; justify-content: center;">
                                        <div class="text-center" style="padding-left: 10px;">
                                            <button type="button" name="" class="btn btn-warning submit-btn"
                                                    onclick="this.form.reset();">
                                                <i class="bi bi-arrow-counterclockwise"></i> Reset
                                            </button>
                                        </div>
                                        <div class="text-center" style="padding-left: 20px;">
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