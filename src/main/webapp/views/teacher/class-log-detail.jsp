<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="classLog" value="${requestScope.classLog}"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Nhật ký Lớp học #${classLog.logId}</title>
    <!-- Thêm CSS cơ bản hoặc Tailwind CSS nếu có -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7f9;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #007bff;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-size: 1.8rem;
        }
        .detail-group {
            margin-bottom: 15px;
            padding: 10px 0;
            border-bottom: 1px dashed #eee;
        }
        .detail-group label {
            font-weight: bold;
            display: block;
            color: #555;
            margin-bottom: 5px;
        }
        .detail-group p {
            margin: 0;
            font-size: 1rem;
            word-wrap: break-word;
        }
        .content-box {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #ddd;
            white-space: pre-wrap; /* Giữ định dạng xuống dòng và khoảng trắng */
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            padding: 8px 15px;
            background-color: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .back-link:hover {
            background-color: #5a6268;
        }
    </style>
</head>
<body>

<div class="container">
    <c:choose>
        <c:when test="${empty classLog}">
            <h1>Lỗi: Không tìm thấy Nhật ký Lớp học</h1>
            <p>Vui lòng kiểm tra lại ID Nhật ký.</p>
        </c:when>
        <c:otherwise>
            <h1>Chi tiết Nhật ký Lớp học #${className}</h1>

            <div class="detail-group">
                <label>Người Viết (Staff ID):</label>
                <p>${classLog.authorStaffName}</p>
            </div>

            <div class="detail-group">
                <label>Thời gian Ghi nhận:</label>
                <p>
                    <fmt:formatDate value="${classLog.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                </p>
            </div>

            <div class="detail-group">
                <label>Nội dung:</label>
                <div class="content-box">
                    <p>${classLog.content}</p>
                </div>
            </div>

            <%-- Nút Quay lại - Chuyển về danh sách nhật ký của lớp đó --%>
            <a href="${pageContext.request.contextPath}/class-log?classId=${classLog.classId}" class="back-link">
                &larr; Quay lại Danh sách Nhật ký
            </a>
        </c:otherwise>
    </c:choose>
</div>

</body>
</html>