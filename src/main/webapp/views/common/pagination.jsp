<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${totalPages > 1}">
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">

                <%-- Previous Button --%>
            <c:choose>
                <c:when test="${currentPage > 1}">
                    <li class="page-item">
                        <a class="page-link" href="${paginationUrl}page=${currentPage - 1}" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1" aria-disabled="true" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>

                <%-- Page Number Buttons --%>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${currentPage == i}">
                        <li class="page-item active" aria-current="page">
                            <a class="page-link" href="#">${i}</a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link" href="${paginationUrl}page=${i}">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

                <%-- Next Button --%>
            <c:choose>
                <c:when test="${currentPage < totalPages}">
                    <li class="page-item">
                        <a class="page-link" href="${paginationUrl}page=${currentPage + 1}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item disabled">
                        <a class="page-link" href="#" tabindex="-1" aria-disabled="true" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>

        </ul>
    </nav>
</c:if>
