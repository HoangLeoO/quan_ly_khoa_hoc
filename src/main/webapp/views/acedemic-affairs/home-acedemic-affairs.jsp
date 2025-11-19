<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Hi
  Date: 18/11/2025
  Time: 2:50 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
</head>
<body>
<div>
  <c:import url="../common/header.jsp"/>

  <!-- Navigation -->
<div>
  <c:import url="navaber-acedemic-affairs.jsp"/>
</div>

  <!-- Admin Section -->
  <section class="py-5 mt-5">
    <div class="container" style="margin-top: 50px">
      <div class="row justify-content-center">
        <div class="col-md-10">
          <div class="card border-0 shadow">
            <div class="card-body p-4 p-md-5">


              <!-- Class List Table -->
              <c:import url="table-acedemic-affairs.jsp"/>

            </div>
          </div>
        </div>
      </div>
    </div>
  </section>

  <c:import url="../common/footer.jsp"/>
</body>
</html>
