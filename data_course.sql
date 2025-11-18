-- -----------------------------------------------------
-- 1. BẢNG KHÔNG PHỤ THUỘC (Độc lập)
-- -----------------------------------------------------

INSERT INTO roles (role_name) VALUES
    ('ADMIN'),
    ('TEACHER'),
    ('STUDENT'),
    ('GIAO_VU');

INSERT INTO courses (course_name, description) VALUES
    ('Fullstack Java Web', 'Khóa học lập trình Java web từ cơ bản đến nâng cao'),
    ('Frontend Fundamentals', 'HTML/CSS/JS cơ bản'),
    ('Backend Java Advanced', 'Tập trung Spring Boot, API, Security'),
    ('Database Mastery', 'SQL nâng cao, tối ưu hóa truy vấn'),
    ('DevOps Foundations', 'Docker, CI/CD cơ bản'),
    ('Python for Beginners', 'Lập trình Python từ A-Z'),
    ('AI Introduction', 'Nhập môn trí tuệ nhân tạo'),
    ('Mobile Android', 'Lập trình Android với Java/Kotlin'),
    ('ReactJS Pro', 'SPA nâng cao với React'),
    ('C# .NET Web', 'Lập trình web với ASP.NET MVC');

-- -----------------------------------------------------
-- 2. TÀI KHOẢN & USERS (10 users cho staff + 13 users cho students = 23 users)
-- -----------------------------------------------------

-- Users cho Staff (10 users: 5 admin/teacher/giaovu + 5 teacher/admin/staff)
INSERT INTO users (email, password_hash, role_id) VALUES
    ('hoang.lv@example.com', 'hashed_password_123', 1),           -- user_id=1, ADMIN
    ('nguyen.tlg@example.com', 'hashed_password_123', 2),         -- user_id=2, TEACHER
    ('giaovu.nt@example.com', 'hashed_password_123', 4),          -- user_id=3, GIAO_VU
    ('teacher.hoa@example.com', 'hashed_password_123', 2),        -- user_id=4, TEACHER
    ('admin2@example.com', 'hashed_password_123', 1),             -- user_id=5, ADMIN
    ('staff.minh@example.com', 'hashed_password_123', 2),         -- user_id=6, TEACHER
    ('giaovu.tran@example.com', 'hashed_password_123', 4),        -- user_id=7, GIAO_VU
    ('assistant.anh@example.com', 'hashed_password_123', 2),      -- user_id=8, TEACHER
    ('teacher.duong@example.com', 'hashed_password_123', 2),      -- user_id=9, TEACHER
    ('staff.linh@example.com', 'hashed_password_123', 4);         -- user_id=10, GIAO_VU

-- Users cho Students (13 users)
INSERT INTO users (email, password_hash, role_id) VALUES
    ('tung.hv@example.com', 'hashed_password_123', 3),            -- user_id=11
    ('khanh.nkq@example.com', 'hashed_password_123', 3),          -- user_id=12
    ('minh.nt@example.com', 'hashed_password_123', 3),            -- user_id=13
    ('thu.tran@example.com', 'hashed_password_123', 3),           -- user_id=14
    ('anh.le@example.com', 'hashed_password_123', 3),             -- user_id=15
    ('hoa.pham@example.com', 'hashed_password_123', 3),           -- user_id=16
    ('tam.nguyen@example.com', 'hashed_password_123', 3),         -- user_id=17
    ('nhatminh.le@example.com', 'hashed_password_123', 3),        -- user_id=18
    ('tan.nguyen@example.com', 'hashed_password_123', 3),         -- user_id=19
    ('han.huynh@example.com', 'hashed_password_123', 3);          -- user_id=20

-- -----------------------------------------------------
-- 3. MODULES & LESSONS
-- -----------------------------------------------------

INSERT INTO modules (course_id, module_name, sort_order) VALUES
    (1, 'Module 1: Java Core', 1),
    (1, 'Module 2: HTML/CSS/JS', 2),
    (1, 'Module 3: SQL Cơ bản', 3),
    (1, 'Module 4: JDBC & Servlet', 4),
    (1, 'Module 5: JSP/JSTL', 5),
    (1, 'Module 6: Spring Core', 6),
    (1, 'Module 7: Spring Boot', 7),
    (1, 'Module 8: REST API', 8),
    (1, 'Module 9: Security', 9),
    (1, 'Module 10: Final Project', 10);

INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
    (1, 'Bài 1: Giới thiệu Java', 1),
    (1, 'Bài 2: Biến và Kiểu dữ liệu', 2),
    (2, 'Bài 3: Flexbox', 3),
    (2, 'Bài 4: DOM cơ bản', 4),
    (3, 'Bài 5: SELECT nâng cao', 1),
    (3, 'Bài 6: JOIN các loại', 2),
    (4, 'Bài 7: Kết nối DB', 1),
    (4, 'Bài 8: CRUD chuẩn', 2),
    (5, 'Bài 9: JSTL Core', 1),
    (5, 'Bài 10: JSTL Format', 2);

INSERT INTO lesson_contents (lesson_id, content_type, content_data) VALUES
    (1, 'text', 'Java là một ngôn ngữ lập trình đa nền tảng...'),
    (1, 'video', 'https://www.youtube.com/watch?v=some_video_id'),
    (2, 'text', 'Biến trong Java...'),
    (3, 'video', 'https://youtube.com/example?v=abc1'),
    (4, 'text', 'DOM là gì?'),
    (5, 'text', 'SELECT nâng cao gồm HAVING...'),
    (6, 'video', 'https://youtube.com/example?v=abc2'),
    (7, 'text', 'Kết nối DB với JDBC'),
    (8, 'video', 'https://yt.com/video_crud'),
    (9, 'markdown', '# JSTL Core hướng dẫn');

-- -----------------------------------------------------
-- 4. STAFF & STUDENTS
-- -----------------------------------------------------

INSERT INTO staff (user_id, full_name, position) VALUES
    (1, 'Lê Văn Hoàng', 'System Admin'),
    (2, 'Trần Lê Gia Nguyên', 'Lead Teacher'),
    (3, 'Nguyễn Thị Giáo Vụ', 'Giáo vụ'),
    (4, 'Phan Văn Hòa', 'Teacher'),
    (5, 'Admin Phụ', 'System Admin'),
    (6, 'Ngô Thanh Minh', 'Giáo viên'),
    (7, 'Trần Thu Thúy', 'Giáo vụ'),
    (8, 'Lê Chí Anh', 'Trợ giảng'),
    (9, 'Dương Văn Nam', 'Teacher'),
    (10, 'Phạm Thị Linh', 'Giáo vụ');

INSERT INTO students (user_id, full_name, phone, dob) VALUES
    (11, 'Hồ Viết Tùng', '0905111222', '2003-06-15'),
    (12, 'Nguyễn Kim Quốc Khánh', '0905333444', '2004-03-20'),
    (13, 'Ngô Thanh Minh', '0911222333', '2003-05-10'),
    (14, 'Trần Thu Thúy', '0933444555', '2004-08-22'),
    (15, 'Lê Chí Anh', '0988777666', '2002-12-15'),
    (16, 'Phan Văn Hòa', '0977333555', '2003-11-01'),
    (17, 'Nguyễn Hữu Tâm', '0909888777', '2000-07-22'),
    (18, 'Lê Nhật Minh', '0911666777', '2004-02-11'),
    (19, 'Nguyễn Hữu Tấn', '0933777999', '2002-04-19'),
    (20, 'Huỳnh Ngọc Hân', '0966888444', '2004-01-30');

-- -----------------------------------------------------
-- 5. CLASSES & ENROLMENTS
-- -----------------------------------------------------

INSERT INTO classes (class_name, course_id, teacher_id, start_date, end_date) VALUES
    ('C07', 1, 2, '2025-11-15', '2026-03-15'),
    ('C08', 1, 2, '2025-11-20', '2026-03-01'),
    ('C09', 1, 2, '2025-12-01', '2026-04-10'),
    ('C10', 2, 4, '2025-10-01', '2026-02-10'),
    ('C11', 3, 4, '2025-09-10', '2026-01-20'),
    ('C12', 1, 6, '2026-01-15', '2026-05-30'),
    ('C13', 1, 8, '2026-02-02', '2026-06-18'),
    ('C14', 4, 9, '2026-03-01', '2026-07-15'),
    ('C15', 5, 6, '2026-04-12', '2026-08-20'),
    ('C16', 1, 2, '2026-05-01', '2026-09-30');

INSERT INTO enrolments (student_id, class_id, status) VALUES
    (1, 1, 'dropped'),     -- Tùng - C07 (dropped)
    (2, 1, 'studying'),    -- Khánh - C07
    (3, 1, 'studying'),    -- Minh - C07
    (4, 1, 'studying'),    -- Thúy - C07
    (5, 2, 'completed'),   -- Anh - C08 (completed)
    (6, 2, 'studying'),    -- Hòa - C08
    (7, 3, 'studying'),    -- Tâm - C09
    (8, 3, 'studying'),    -- Nhật Minh - C09
    (9, 4, 'studying'),    -- Tấn - C10
    (10, 4, 'studying'),   -- Hân - C10
    (1, 5, 'studying'),    -- Tùng - C11
    (2, 5, 'studying'),    -- Khánh - C11
    (3, 6, 'studying'),    -- Minh - C12
    (4, 6, 'studying'),    -- Thúy - C12
    (5, 7, 'studying'),    -- Anh - C13
    (6, 7, 'studying'),    -- Hòa - C13
    (7, 8, 'studying'),    -- Tâm - C14
    (8, 8, 'studying'),    -- Nhật Minh - C14
    (9, 9, 'studying'),    -- Tấn - C15
    (10, 9, 'studying');   -- Hân - C15

INSERT INTO schedules (class_id, lesson_id, time_start, time_end, room) VALUES
    (1, 1, '2025-11-15 08:00:00', '2025-11-15 11:30:00', 'Phòng A101'),
    (1, 2, '2025-11-17 08:00:00', '2025-11-17 11:30:00', 'P101'),
    (2, 3, '2025-11-20 08:00:00', '2025-11-20 11:00:00', 'P102'),
    (2, 4, '2025-11-22 08:00:00', '2025-11-22 11:00:00', 'P102'),
    (3, 5, '2025-12-01 13:00:00', '2025-12-01 16:00:00', 'P201'),
    (3, 6, '2025-12-03 13:00:00', '2025-12-03 16:00:00', 'P201'),
    (4, 7, '2025-12-05 18:00:00', '2025-12-05 21:00:00', 'P301'),
    (4, 8, '2025-12-07 18:00:00', '2025-12-07 21:00:00', 'P301'),
    (5, 9, '2025-12-10 08:00:00', '2025-12-10 11:00:00', 'P101'),
    (5, 10, '2025-12-12 08:00:00', '2025-12-12 11:00:00', 'P101');

-- -----------------------------------------------------
-- 6. ATTENDANCE & GRADES
-- -----------------------------------------------------

INSERT INTO attendance (schedule_id, student_id, status, note) VALUES
    (1, 1, 'present', 'Đi học đúng giờ'),
    (1, 2, 'absent', 'Xin nghỉ phép'),
    (2, 3, 'present', ''),
    (2, 4, 'late', 'Đến trễ 10 phút'),
    (3, 5, 'present', ''),
    (3, 6, 'absent', 'Bị ốm'),
    (4, 7, 'present', ''),
    (4, 8, 'present', ''),
    (5, 7, 'late', ''),
    (5, 8, 'present', ''),
    (6, 9, 'present', ''),
    (6, 10, 'present', ''),
    (7, 9, 'absent', 'Có việc nhà'),
    (7, 10, 'present', ''),
    (8, 1, 'present', ''),
    (8, 2, 'present', ''),
    (9, 1, 'present', ''),
    (9, 2, 'absent', ''),
    (10, 3, 'present', ''),
    (10, 4, 'present', '');

INSERT INTO grades (student_id, module_id, score, note) VALUES
    (1, 1, 8.5, ''),
    (2, 1, 8.0, ''),
    (3, 1, 7.5, ''),
    (4, 1, 8.0, ''),
    (5, 1, 8.5, ''),
    (6, 1, 6.8, ''),
    (7, 1, 9.0, ''),
    (8, 1, 7.2, ''),
    (9, 1, 7.0, ''),
    (10, 1, 8.8, ''),
    (1, 2, 7.0, ''),
    (2, 2, 7.8, ''),
    (3, 2, 8.0, ''),
    (4, 2, 6.5, ''),
    (5, 2, 9.2, ''),
    (6, 2, 7.3, ''),
    (7, 2, 6.9, ''),
    (8, 2, 8.9, ''),
    (9, 2, 8.1, ''),
    (10, 2, 9.0, '');

INSERT INTO lesson_progress (student_id, lesson_id, is_completed, completed_at) VALUES
    (1, 1, true, NOW()),
    (2, 1, true, NOW()),
    (3, 1, true, NOW()),
    (4, 1, true, NOW()),
    (5, 1, false, NULL),
    (6, 1, true, NOW()),
    (7, 1, true, NOW()),
    (8, 1, false, NULL),
    (9, 1, true, NOW()),
    (10, 1, true, NOW()),
    (1, 2, true, NOW()),
    (2, 2, false, NULL),
    (3, 2, true, NOW()),
    (4, 2, false, NULL),
    (5, 2, true, NOW()),
    (6, 2, true, NOW()),
    (7, 2, false, NULL),
    (8, 2, true, NOW()),
    (9, 2, true, NOW()),
    (10, 2, false, NULL);

-- -----------------------------------------------------
-- 7. LOGS
-- -----------------------------------------------------

INSERT INTO class_logs (class_id, author_staff_id, content) VALUES
    (1, 2, 'Lớp C07 buổi đầu sĩ số đầy đủ'),
    (1, 3, 'Cần cải thiện kỷ luật'),
    (2, 2, 'Buổi học đầu đủ sĩ số'),
    (3, 2, 'Một số học viên vắng'),
    (4, 2, 'Tiết học hiệu quả'),
    (5, 3, 'Lớp học nghiêm túc'),
    (6, 3, 'Tinh thần lớp tốt'),
    (7, 3, 'Nhiều câu hỏi hay'),
    (8, 2, 'Bài tập giao nhiều'),
    (9, 2, 'Lớp hơi ồn');

INSERT INTO student_logs (student_id, author_staff_id, content) VALUES
    (1, 2, 'Tiến bộ tốt'),
    (2, 3, 'Giáo vụ đã liên hệ HV Khánh xác nhận lý do vắng. OK'),
    (3, 2, 'Cần làm bài tập thêm'),
    (4, 3, 'Chậm tiến độ'),
    (5, 3, 'Ổn định'),
    (6, 2, 'Tham gia đầy đủ'),
    (7, 2, 'Đi trễ nhiều'),
    (8, 3, 'Gặp khó trong SQL'),
    (9, 3, 'Hiểu bài tốt'),
    (10, 2, 'Tinh thần học tốt');