-- =====================================================
-- DATA CODEGYM DATABASE
-- =====================================================

USE codegym;

-- -----------------------------------------------------
-- 1. ROLES
-- -----------------------------------------------------
INSERT INTO roles (role_name) VALUES
                                  ('Admin'),
                                  ('Teacher'),
                                  ('Student'),
                                  ('Academic Staff');

-- -----------------------------------------------------
-- 2. USERS
-- -----------------------------------------------------
INSERT INTO users (email, password_hash, role_id, is_delete) VALUES
                                                                 ('admin@codegym.vn', '$2a$10$Tu0wN9GJtHDuduATlS0.H.csPPmCRfLTSMMIZgb6QmLx/h0HE0Sni', 1, 0),
                                                                 ('teacher1@codegym.vn', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 2, 0),
                                                                 ('teacher2@codegym.vn', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 2, 0),
                                                                 ('nguyen.van.a@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('tran.thi.b@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('le.van.c@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('pham.thi.d@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('hoang.van.e@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('vo.thi.f@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('do.van.g@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('bui.thi.h@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('ngo.van.i@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('dang.thi.k@gmail.com', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 3, 0),
                                                                 ('coordinator@codegym.vn', '$2a$10$4pX7QtExImjuSsUyGhMV8OUzuuGhLz3ikbe0jp0zPrIVhdIHz2sui', 4, 0);

-- -----------------------------------------------------
-- 3. STUDENTS
-- -----------------------------------------------------
INSERT INTO students (user_id, full_name, phone, dob, position, address) VALUES
                                                                             (4, 'Nguyễn Văn A', '0901234567', '2000-05-15', 'Học viên', '123 Lê Lợi, Quận 1, TP.HCM'),
                                                                             (5, 'Trần Thị B', '0902234567', '1999-08-20', 'Học viên', '456 Nguyễn Huệ, Quận 1, TP.HCM'),
                                                                             (6, 'Lê Văn C', '0903234567', '2001-03-10', 'Học viên', '789 Trần Hưng Đạo, Quận 5, TP.HCM'),
                                                                             (7, 'Phạm Thị D', '0904234567', '2000-11-25', 'Học viên', '321 Võ Văn Tần, Quận 3, TP.HCM'),
                                                                             (8, 'Hoàng Văn E', '0905234567', '1998-07-08', 'Học viên', '654 Điện Biên Phủ, Quận Bình Thạnh, TP.HCM'),
                                                                             (9, 'Võ Thị F', '0906234567', '2001-12-30', 'Học viên', '987 Lý Thường Kiệt, Quận 10, TP.HCM'),
                                                                             (10, 'Đỗ Văn G', '0907234567', '2000-02-14', 'Học viên', '147 Hai Bà Trưng, Quận 1, TP.HCM'),
                                                                             (11, 'Bùi Thị H', '0908234567', '1999-09-18', 'Học viên', '258 Pasteur, Quận 1, TP.HCM'),
                                                                             (12, 'Ngô Văn I', '0909234567', '2001-06-22', 'Học viên', '369 Cách Mạng Tháng 8, Quận 3, TP.HCM'),
                                                                             (13, 'Đặng Thị K', '0910234567', '2000-04-05', 'Học viên', '741 Nguyễn Thị Minh Khai, Quận 1, TP.HCM');

-- -----------------------------------------------------
-- 4. STAFF
-- -----------------------------------------------------
INSERT INTO staff (user_id, full_name, phone, dob, position, address) VALUES
                                                                          (1, 'Trần Minh Quân', '0911111111', '1985-01-15', 'Quản trị hệ thống', '100 Lê Duẩn, Quận 1, TP.HCM'),
                                                                          (2, 'Lê Thị Hằng', '0922222222', '1988-06-20', 'Giảng viên Java', '200 Nguyễn Văn Linh, Quận 7, TP.HCM'),
                                                                          (3, 'Phạm Văn Bình', '0933333333', '1990-03-12', 'Giảng viên Python', '300 Xa lộ Hà Nội, Quận 9, TP.HCM'),
                                                                          (14, 'Nguyễn Thị Mai', '0944444444', '1987-09-25', 'Điều phối viên', '400 Nam Kỳ Khởi Nghĩa, Quận 3, TP.HCM');

-- -----------------------------------------------------
-- 5. COURSES
-- -----------------------------------------------------
INSERT INTO courses (course_name, description) VALUES
                                                   ('Lập trình Java Full-stack', 'Khóa học toàn diện về lập trình Java từ cơ bản đến nâng cao, bao gồm Spring Boot, Database, RESTful API'),
                                                   ('Lập trình Python', 'Khóa học Python cho người mới bắt đầu, bao gồm Django, Flask và Data Science'),
                                                   ('Web Development với JavaScript', 'Học HTML, CSS, JavaScript, React, Node.js để trở thành Full-stack Developer'),
                                                   ('Mobile App Development', 'Phát triển ứng dụng di động với React Native và Flutter'),
                                                   ('Data Science & Machine Learning', 'Khóa học về khoa học dữ liệu và machine learning với Python'),
                                                   ('DevOps Engineering', 'Học về CI/CD, Docker, Kubernetes, AWS'),
                                                   ('UI/UX Design', 'Thiết kế giao diện người dùng và trải nghiệm người dùng'),
                                                   ('Database Administration', 'Quản trị cơ sở dữ liệu MySQL, PostgreSQL, MongoDB'),
                                                   ('Cyber Security', 'Bảo mật thông tin và an ninh mạng'),
                                                   ('Cloud Computing', 'Điện toán đám mây với AWS, Azure, Google Cloud');

-- -----------------------------------------------------
-- 6. MODULES
-- -----------------------------------------------------
INSERT INTO modules (course_id, module_name, sort_order) VALUES
                                                             (1, 'Java Basics', 1),
                                                             (1, 'OOP với Java', 2),
                                                             (1, 'Collections Framework', 3),
                                                             (1, 'JDBC & Database', 4),
                                                             (1, 'Spring Boot', 5),
                                                             (1, 'RESTful API', 6),
                                                             (1, 'Spring Security', 7),
                                                             (1, 'Testing với JUnit', 8),
                                                             (1, 'Deployment', 9),
                                                             (1, 'Final Project', 10);

-- -----------------------------------------------------
-- 7. LESSONS
-- -----------------------------------------------------
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (1, 'Giới thiệu về Java', 1),
                                                             (1, 'Cài đặt môi trường', 2),
                                                             (1, 'Biến và kiểu dữ liệu', 3),
                                                             (1, 'Toán tử trong Java', 4),
                                                             (1, 'Câu lệnh điều kiện', 5),
                                                             (1, 'Vòng lặp', 6),
                                                             (1, 'Mảng (Array)', 7),
                                                             (1, 'Phương thức (Method)', 8),
                                                             (1, 'String trong Java', 9),
                                                             (1, 'Bài tập tổng hợp', 10);

-- -----------------------------------------------------
-- 8. LESSON_CONTENTS
-- -----------------------------------------------------
INSERT INTO lesson_contents (lesson_id, content_type, content_data) VALUES
                                                                        (1, 'video', 'https://youtube.com/watch?v=java-intro-001'),
                                                                        (1, 'text', 'Java là ngôn ngữ lập trình hướng đối tượng phổ biến nhất thế giới...'),
                                                                        (2, 'video', 'https://youtube.com/watch?v=java-setup-002'),
                                                                        (2, 'text', 'Hướng dẫn cài đặt JDK và IntelliJ IDEA...'),
                                                                        (3, 'video', 'https://youtube.com/watch?v=java-variables-003'),
                                                                        (3, 'text', 'Biến là vùng nhớ lưu trữ dữ liệu. Java có các kiểu dữ liệu: int, double, String...'),
                                                                        (3, 'quiz', '{"questions":[{"q":"Khai báo biến số nguyên?","a":"int x = 10;"}]}'),
                                                                        (4, 'video', 'https://youtube.com/watch?v=java-operators-004'),
                                                                        (5, 'video', 'https://youtube.com/watch?v=java-if-005'),
                                                                        (6, 'video', 'https://youtube.com/watch?v=java-loop-006');

-- -----------------------------------------------------
-- 9. CLASSES
-- -----------------------------------------------------
INSERT INTO classes (class_name, course_id, teacher_id, start_date, end_date, status) VALUES
                                                                                          ('C0724G1', 1, 1, '2024-07-01', '2024-12-31', 'studying'),
                                                                                          ('C0824G1', 1, 1, '2024-08-01', '2025-01-31', 'studying'),
                                                                                          ('C0924P1', 2, 2, '2024-09-01', '2025-02-28', 'studying'),
                                                                                          ('C0624G1', 1, 1, '2024-06-01', '2024-11-30', 'completed'),
                                                                                          ('C0524G1', 1, 1, '2024-05-01', '2024-10-31', 'completed'),
                                                                                          ('C1024G1', 1, 1, '2024-10-01', '2025-03-31', 'studying'),
                                                                                          ('C0724W1', 3, 2, '2024-07-15', '2024-12-15', 'studying'),
                                                                                          ('C0824M1', 4, 2, '2024-08-15', '2025-01-15', 'studying'),
                                                                                          ('C0924D1', 5, 2, '2024-09-15', '2025-02-15', 'studying'),
                                                                                          ('C0424G1', 1, 1, '2024-04-01', '2024-09-30', 'completed');

-- -----------------------------------------------------
-- 10. ENROLMENTS
-- -----------------------------------------------------
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (1, 1, 'studying'),
                                                          (2, 1, 'studying'),
                                                          (3, 1, 'studying'),
                                                          (4, 2, 'studying'),
                                                          (5, 2, 'studying'),
                                                          (6, 3, 'studying'),
                                                          (7, 3, 'studying'),
                                                          (8, 1, 'studying'),
                                                          (9, 2, 'studying'),
                                                          (10, 1, 'studying');

-- -----------------------------------------------------
-- 11. SCHEDULES
-- -----------------------------------------------------
INSERT INTO schedules (class_id, lesson_id, time_start, time_end, room) VALUES
                                                                            (1, 1, '2024-07-01 08:00:00', '2024-07-01 10:00:00', 'Room 301'),
                                                                            (1, 2, '2024-07-02 08:00:00', '2024-07-02 10:00:00', 'Room 301'),
                                                                            (1, 3, '2024-07-03 08:00:00', '2024-07-03 10:00:00', 'Room 301'),
                                                                            (1, 4, '2024-07-04 08:00:00', '2024-07-04 10:00:00', 'Room 301'),
                                                                            (1, 5, '2024-07-05 08:00:00', '2024-07-05 10:00:00', 'Room 301'),
                                                                            (2, 1, '2024-08-01 13:00:00', '2024-08-01 15:00:00', 'Room 302'),
                                                                            (2, 2, '2024-08-02 13:00:00', '2024-08-02 15:00:00', 'Room 302'),
                                                                            (3, 1, '2024-09-01 18:00:00', '2024-09-01 20:00:00', 'Room 401'),
                                                                            (3, 2, '2024-09-02 18:00:00', '2024-09-02 20:00:00', 'Room 401'),
                                                                            (1, 6, '2024-07-08 08:00:00', '2024-07-08 10:00:00', 'Room 301');

-- -----------------------------------------------------
-- 12. ATTENDANCE
-- -----------------------------------------------------
INSERT INTO attendance (schedule_id, student_id, status, note) VALUES
                                                                   (1, 1, 'present', NULL),
                                                                   (1, 2, 'present', NULL),
                                                                   (1, 3, 'late', 'Đến muộn 15 phút'),
                                                                   (1, 8, 'present', NULL),
                                                                   (1, 10, 'absent', 'Xin nghỉ phép'),
                                                                   (2, 1, 'present', NULL),
                                                                   (2, 2, 'present', NULL),
                                                                   (2, 3, 'present', NULL),
                                                                   (3, 1, 'present', NULL),
                                                                   (3, 2, 'excused', 'Đi khám bệnh có giấy');

-- -----------------------------------------------------
-- 13. GRADES
-- -----------------------------------------------------
INSERT INTO grades (student_id, module_id, theory_score, practice_score, note) VALUES
                                                                                   (1, 1, 8.5, 9.0, 'Học tốt, tích cực'),
                                                                                   (1, 2, 7.5, 8.0, 'Cần cải thiện OOP'),
                                                                                   (2, 1, 9.0, 9.5, 'Xuất sắc'),
                                                                                   (2, 2, 8.5, 9.0, 'Rất tốt'),
                                                                                   (3, 1, 7.0, 7.5, 'Trung bình khá'),
                                                                                   (3, 2, 6.5, 7.0, 'Cần ôn tập thêm'),
                                                                                   (8, 1, 8.0, 8.5, 'Tốt'),
                                                                                   (8, 2, 7.8, 8.2, 'Khá tốt'),
                                                                                   (10, 1, 9.5, 9.8, 'Xuất sắc, top đầu lớp'),
                                                                                   (10, 2, 9.0, 9.5, 'Rất xuất sắc');

-- -----------------------------------------------------
-- 14. LESSON_PROGRESS
-- -----------------------------------------------------
INSERT INTO lesson_progress (student_id, lesson_id, is_completed, completed_at) VALUES
                                                                                    (1, 1, true, '2024-07-01 11:00:00'),
                                                                                    (1, 2, true, '2024-07-02 11:00:00'),
                                                                                    (1, 3, true, '2024-07-03 11:00:00'),
                                                                                    (1, 4, false, NULL),
                                                                                    (2, 1, true, '2024-07-01 11:30:00'),
                                                                                    (2, 2, true, '2024-07-02 11:30:00'),
                                                                                    (2, 3, true, '2024-07-03 11:30:00'),
                                                                                    (3, 1, true, '2024-07-01 12:00:00'),
                                                                                    (3, 2, true, '2024-07-02 12:00:00'),
                                                                                    (8, 1, true, '2024-07-01 10:45:00');

-- -----------------------------------------------------
-- 15. STUDENT_LOGS
-- -----------------------------------------------------
INSERT INTO student_logs (student_id, author_staff_id, content) VALUES
                                                                    (1, 1, 'Học viên có tiến bộ tốt trong tuần đầu tiên'),
                                                                    (1, 1, 'Hoàn thành bài tập đúng hạn, code chất lượng'),
                                                                    (2, 1, 'Học viên xuất sắc, nhiệt tình giúp đỡ bạn'),
                                                                    (3, 1, 'Cần cải thiện kỹ năng debug'),
                                                                    (3, 1, 'Đã có tiến bộ rõ rệt sau buổi tư vấn'),
                                                                    (4, 2, 'Học viên mới nhập học, cần theo dõi sát'),
                                                                    (5, 2, 'Tham gia tích cực các hoạt động lớp'),
                                                                    (8, 1, 'Code sạch, có tư duy logic tốt'),
                                                                    (10, 1, 'Top học viên xuất sắc tháng 7/2024'),
                                                                    (10, 1, 'Đề xuất làm mentor cho lớp sau');

-- -----------------------------------------------------
-- 16. CLASS_LOGS
-- -----------------------------------------------------
INSERT INTO class_logs (class_id, author_staff_id, content) VALUES
                                                                (1, 1, 'Khai giảng lớp C0724G1, 10 học viên tham gia'),
                                                                (1, 1, 'Tiến độ học tốt, học viên nhiệt tình'),
                                                                (1, 1, 'Tổ chức buổi review code cho lớp'),
                                                                (2, 1, 'Khai giảng lớp C0824G1, 5 học viên đăng ký'),
                                                                (2, 1, 'Lớp học nhỏ, có thể chăm sóc kỹ từng học viên'),
                                                                (3, 2, 'Khai giảng lớp Python C0924P1'),
                                                                (3, 2, 'Học viên có background khác nhau, cần điều chỉnh giảng dạy'),
                                                                (4, 1, 'Lớp C0624G1 hoàn thành khóa học'),
                                                                (4, 1, '8/10 học viên pass, 2 học viên cần học lại'),
                                                                (1, 4, 'Họp phụ huynh học viên vào cuối tháng');