<%@ page import="com.js.carpark.model.auth.UserModel" %><%--
  Created by IntelliJ IDEA.
  User: dell
  Date: 12-Dec-22
  Time: 9:58 AM
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
    <title>Trip list</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css"/>
    <link rel="stylesheet" href="./css/dataTables.bootstrap5.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css"/>
    <link rel="stylesheet" href="./css/style.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css">
    <link rel="stylesheet" href="./css/pagination.css"/>

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
                                <a href="trip-list" class="nav-link px-3 choosing">
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
                                    <span>Add ticket</span>
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
                        <div class="col-md-12 fs-2">Trip list</div>
                    </div>
                    <div class="card-body">
                        <div class="card-text">
                            <%--@elvariable id="tripSearchModel" type=""--%>
                            <form:form class="row gx-3 gy-2 align-items-center pb-3 justify-content-end"
                                       method="post" modelAttribute="tripSearchModel">
                                <div class="col-sm-3">
                                    <form:label class="visually-hidden" for="text" path="text">Text</form:label>
                                    <div class="input-group">
                                        <div class="input-group-text"><i class="bi bi-search"></i></div>
                                        <form:input type="text" class="form-control" id="text" name="name"
                                                    placeholder="User search" path="text"/>
                                    </div>
                                </div>
                                <div class="col-sm-4">
                                    <form:label class="visually-hidden" for="filter" path="type">Filter</form:label>
                                    <div class="input-group">
                                        <div class="input-group-text">
                                          <span class="me-2">
                                            <i class="bi bi-funnel-fill"></i>
                                          </span>
                                            <span> Filter By </span>
                                        </div>
                                        <form:select onchange="typeChanging()" class="form-select" id="filter"
                                                     name="filter" path="type">
                                            <option value="1" ${tripSearchModel.type == 1 ? "selected" : ""}>
                                                Destination
                                            </option>
                                            <option value="2" ${tripSearchModel.type == 2 ? "selected" : ""}>Departure
                                                time
                                            </option>
                                            <option value="3" ${tripSearchModel.type == 3 ? "selected" : ""}>Driver
                                            </option>
                                            <option value="4" ${tripSearchModel.type == 4 ? "selected" : ""}>Car type
                                            </option>
                                            <option value="5" ${tripSearchModel.type == 5 ? "selected" : ""}>Booked
                                                ticket number
                                            </option>
                                        </form:select>
                                    </div>
                                </div>
                                <div class="col-auto">
                                    <button type="submit" class="btn btn-primary">Search</button>
                                </div>
                            </form:form>

                            <table id="pager" class="table table-bordered table-striped">
                                <thead class="table-secondary">
                                <tr>
                                    <th scope="col">No</th>
                                    <th scope="col">Destination</th>
                                    <th scope="col">Departure time</th>
                                    <th scope="col">Driver</th>
                                    <th scope="col">Car type</th>
                                    <th scope="col">Booked ticket number</th>
                                    <th scope="col">Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${trip}" var="trip">
                                    <tr>
                                        <th scope="row">${trip.id}</th>
                                        <td>${trip.destination}</td>
                                        <td>${trip.departureTime}</td>
                                        <td>${trip.driver}</td>
                                        <td>${trip.carType}</td>
                                        <td>${trip.bookedTicketNumber}</td>
                                            <%--xử lý phần booked sau khi add va edit--%>

                                        <td>
                                            <a href="/edit-trip-${trip.id}" class="text-decoration-none">
                        <span class="me-2">
                          <i class="fa-regular fa-pen-to-square"></i>
                        </span>
                                                <span> Edit </span>
                                            </a>

                                            <a href="/delete-${trip.id}" class="text-decoration-none m-lg-2">
                        <span class="me-2">
                          <i class="fa-solid fa-trash-can"></i>
                        </span>
                                                <span> Delete </span>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>


                                </tbody>
                            </table>
                            <div id="pageNavPosition" class="pager-nav"></div>
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
<script src="./js/pagging.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.css">

<script>
    function daysInMonth(month, year) {
        return new Date(year, month, 0).getDate();
    }

    function fillDays() {
        var month = $("#inputMonth").val();
        var year = $("#inputYear").val();
        var days = daysInMonth(month, year); // 31

        var selectHtml = '';
        for (var i = 1; i <= days; i++) {
            selectHtml += `<option value="${i}">${i}</option>`
        }

        $("#inputDay").html(selectHtml);
    }


    function typeChanging() {
        let x = document.getElementById("filter").value;
        switch (x) {
            case "1":
                document.getElementById('text').type = 'text';
                break;
            case "2":
                document.getElementById('text').type = 'time';
                break;
            case "3":
                document.getElementById('text').type = 'text';
                break;
            case "4":
                document.getElementById('text').type = 'text';
                break;
            case "5":
                document.getElementById('text').type = 'number';
                break;
        }
    }


</script>
</body>

</html>
