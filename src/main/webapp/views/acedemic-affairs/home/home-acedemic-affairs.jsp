<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <c:import url="../../common/header.jsp"/>
</head>
<body>
<div>


    <!-- Navigation -->
    <div>
        <c:import url="../../common/navbar.jsp"/>
    </div>



    <section>
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
                            <div>
                                <c:import url="form-search-infor-class.jsp"/>
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
