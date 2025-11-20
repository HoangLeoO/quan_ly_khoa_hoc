<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 18/11/2025
  Time: 10:16 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nội Dung Bài Học: Giới Thiệu HTML</title>
    <c:import url="../common/header.jsp"/>
    <style>
        body {
            background-color: #f8f9fa; /* Light background */
        }
        .lesson-header {
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 1rem;
            margin-bottom: 2rem;
        }
        .video-container {
            margin-bottom: 2rem;
            border-radius: .5rem;
            overflow: hidden; /* Ensures border-radius applies to iframe */
        }
        .content-section p {
            line-height: 1.8;
            font-size: 1.1rem;
            color: #495057;
        }
        .content-section h4 {
            margin-top: 2rem;
            margin-bottom: 1rem;
            color: #343a40;
        }
    </style>
</head>
<body>
<%-- Thanh điều hướng (Navbar) --%>
<c:import url="../common/navbar.jsp"/>

<section class="py-5">
    <div class="container" style="margin-top: 50px">
        <div class="row justify-content-center">
            <div class="col-md-10 col-lg-8"> <%-- Điều chỉnh độ rộng cột để nội dung dễ đọc --%>
                <div class="card border-0 shadow rounded-3">
                    <div class="card-body p-4 p-md-5">

                        <div class="lesson-header text-center mb-5">
                            <h1 class="display-5 fw-bold text-primary">Giới Thiệu Về HTML Cơ Bản</h1>
                            <p class="lead text-muted">Module 1: Cấu trúc Website</p>
                            <span class="badge bg-success">Trạng thái: Đã hoàn thành</span>
                        </div>

                        <div class="video-container">
                            <h4 class="mb-3">Video bài giảng: HTML là gì?</h4>
                            <div class="ratio ratio-16x9 shadow-sm rounded-3">
                                <iframe
                                        src="https://www.youtube.com/embed/dQw4w9WgXcQ?rel=0"
                                        title="YouTube video player"
                                        frameborder="0"
                                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                                        allowfullscreen>
                                </iframe>
                            </div>
                            <small class="text-muted mt-2 d-block">Nguồn: Kênh YouTube CodeGym Việt Nam</small>
                        </div>

                        <div class="content-section">
                            <h4 class="mb-3">Khái niệm và Cấu trúc cơ bản của HTML</h4>
                            <p>
                                HTML (HyperText Markup Language) là ngôn ngữ đánh dấu tiêu chuẩn để tạo các trang web. HTML mô tả cấu trúc của một trang web theo ngữ nghĩa, và ban đầu được nhúng các tín hiệu để hiển thị tài liệu.
                            </p>
                            <p>
                                Với HTML, bạn có thể sắp xếp nội dung của mình bằng cách sử dụng các tiêu đề, đoạn văn, danh sách và liên kết. Nó cho phép bạn tạo ra một khung xương cho trang web, sau đó CSS sẽ giúp bạn tạo kiểu và JavaScript sẽ thêm tương tác.
                            </p>

                            <h4 class="mt-4 mb-3">Các thẻ HTML cơ bản</h4>
                            <ul>
                                <li><code>&lt;!DOCTYPE html&gt;</code>: Khai báo loại tài liệu, giúp trình duyệt hiểu phiên bản HTML.</li>
                                <li><code>&lt;html&gt;</code>: Thẻ gốc của mọi trang HTML.</li>
                                <li><code>&lt;head&gt;</code>: Chứa các thông tin meta về trang web (tiêu đề, CSS, JS, charset...).</li>
                                <li><code>&lt;body&gt;</code>: Chứa toàn bộ nội dung hiển thị trên trang web.</li>
                                <li><code>&lt;h1&gt;</code> đến <code>&lt;h6&gt;</code>: Các thẻ tiêu đề.</li>
                                <li><code>&lt;p&gt;</code>: Thẻ đoạn văn.</li>
                                <li><code>&lt;a&gt;</code>: Thẻ liên kết (anchor).</li>
                                <li><code>&lt;img&gt;</code>: Thẻ hình ảnh.</li>
                                <li><code>&lt;div&gt;</code>: Thẻ khối (block-level), thường dùng để nhóm các phần tử.</li>
                                <li><code>&lt;span&gt;</code>: Thẻ nội tuyến (inline-level), dùng để áp dụng kiểu cho một phần nhỏ văn bản.</li>
                            </ul>

                            <h4 class="mt-4 mb-3">Ví dụ về cấu trúc HTML đơn giản</h4>
                            <pre class="bg-light p-3 rounded border"><code>
&lt;!DOCTYPE html&gt;
&lt;html lang="vi"&gt;
&lt;head&gt;
    &lt;meta charset="UTF-8"&gt;
    &lt;meta name="viewport" content="width=device-width, initial-scale=1.0"&gt;
    &lt;title&gt;Trang web đầu tiên của tôi&lt;/title&gt;
&lt;/head&gt;
&lt;body&gt;
    &lt;h1&gt;Chào mừng đến với CodeGym!&lt;/h1&gt;
    &lt;p&gt;Đây là một đoạn văn bản giới thiệu về HTML.&lt;/p&gt;
    &lt;a href="https://codegym.vn" target="_blank"&gt;Truy cập CodeGym Việt Nam&lt;/a&gt;
&lt;/body&gt;
&lt;/html&gt;
                            </code></pre>
                            <p class="mt-4">
                                Bằng cách kết hợp các thẻ này, bạn có thể xây dựng bất kỳ bố cục trang web nào, từ đơn giản đến phức tạp. Hãy thực hành viết mã HTML để làm quen với chúng!
                            </p>
                        </div>

                        <div class="d-flex justify-content-between mt-5 pt-3 border-top">
                            <button class="btn btn-outline-primary"><i class="bi bi-arrow-left"></i> Bài học trước</button>
                            <button class="btn btn-primary">Bài học tiếp theo <i class="bi bi-arrow-right"></i></button>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%-- Footer --%>
<c:import url="../common/footer.jsp"/>

</body>
</html>