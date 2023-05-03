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
  <title>Car List</title>
  <link rel="stylesheet" href="./css/bootstrap.min.css"/>
  <link rel="stylesheet" href="./css/dataTables.bootstrap5.min.css"/>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" />
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

  <link rel="stylesheet" href="./css/style.css" />


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
          <hr class="dropdown-divider bg-light" />
        </li>
        <li>
          <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#carManager" aria-expanded="true">
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
                <a href="car-list" class="nav-link px-3 choosing">
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
          <hr class="dropdown-divider bg-light" />
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
          <hr class="dropdown-divider bg-light" />
        </li>
        <li>
          <a class="nav-link px-3 sidebar-link" data-bs-toggle="collapse" href="#parkingLotManager"
             aria-expanded="false">
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
          <hr class="dropdown-divider bg-light" />
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
            <div class="col-md-12 fs-2">Car list</div>
          </div>
          <div class="card-body">
            <div class="card-text">
              <%--@elvariable id="carSearchModel" type="com.js.carpark.model.car.CarSearchModel"--%>
              <form:form modelAttribute="carSearchModel" method="post"
                         class="row gx-3 gy-2 align-items-center pb-3 justify-content-end">
                <div class="col-sm-3">
                  <form:label class="visually-hidden" for="specificSizeInputGroupUsername" path="text">Car</form:label>
                  <div class="input-group">
                    <div class="input-group-text"><i class="bi bi-search"></i></div>
                    <form:input type="text" class="form-control" id="specificSizeInputGroupUsername"
                                placeholder="Car Search" path="text"/>
                  </div>
                </div>
                <div class="col-sm-4">
                  <form:label class="visually-hidden" for="Filter" path="type">Name</form:label>
                  <div class="input-group">
                    <div class="input-group-text">
                        <span class="me-2">
                          <i class="bi bi-funnel-fill"></i>
                        </span>
                      <span> Filter By </span>
                    </div>
                    <form:select class="form-select" id="filter" name="filter" path="type">
                      <option value="1" ${carSearchModel.type == 1 ? "selected" : ""}>License Plate</option>
                      <option value="2" ${carSearchModel.type == 2 ? "selected" : ""}>Car type</option>
                      <option value="3" ${carSearchModel.type == 3 ? "selected" : ""}>Car color</option>
                      <option value="4" ${carSearchModel.type == 4 ? "selected" : ""}>Company</option>
                      <option value="5" ${carSearchModel.type == 5 ? "selected" : ""}>Parking Lot</option>
                    </form:select>
                  </div>
                </div>
                <div class="col-auto">
                  <button type="submit" class="btn btn-primary">Search</button>
                </div>
              </form:form>


              <table id="pager" class="table table-bordered table-striped">
                <thead class="table-secondary">
                <tr class="table-secondary">
                  <th scope="col">License Plate</th>
                  <th scope="col">Car type</th>
                  <th scope="col">Car color</th>
                  <th scope="col">Company</th>
                  <th scope="col">Parking lot</th>
                  <th scope="col">Action</th>
                </tr>

                </thead>
                <tbody class="page-data">
                <c:forEach items="${cars}" var="car">
                  <tr>
                    <td>${car.id}</td>
                    <td>${car.carType}</td>
                    <td>${car.carColor}</td>
                    <td>${car.company}</td>
                    <td>
                      <a href="view-parking-lot-${car.park.getId()}"
                         class="text-decoration-none">${car.park.getName()}</a>
                    </td>
                    <td>
                      <a href="view-car-${car.id}" style="text-decoration: none" class="edit" data-toggle="modal"><i
                              class="fa fa-pencil-square-o" aria-hidden="true"></i>Edit</a>
                      <a href="delete-car-${car.id}" style="text-decoration: none" class="delete" data-toggle="modal"><i
                              class="fa fa-trash" aria-hidden="true"></i>Delete</a>
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


</body>

</html>