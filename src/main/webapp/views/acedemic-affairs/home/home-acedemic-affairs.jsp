<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <c:import url="../../common/header.jsp"/>

    <!-- Navigation -->
    <div>
        <c:import url="../navaber-acedemic-affairs.jsp"/>
    </div>



    <section class="py-5 mt-5">
        <div class="container" style="margin-top: 50px">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card border-0 shadow">
                        <div class="card-body p-4 p-md-5">
                            <div class="text-center mb-4">
                                <i
                                        class="bi bi-person-gear text-black"
                                        style="font-size: 4rem"></i>
                                <h3 class="mt-3">HOME</h3>
                                </div>

                            <!-- Class List Table -->
                            <c:import url="table-list-class.jsp"/>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <c:import url="../../common/footer.jsp"/>

</body>
</html>
