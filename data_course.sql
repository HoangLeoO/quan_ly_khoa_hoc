
INSERT INTO roles (role_name) VALUES
                                  ('Admin'),
                                  ('Teacher'),
                                  ('Student'),
                                  ('Academic Staff');

-- 1 user Admin
INSERT INTO users (email, password_hash, role_id) VALUES
    ('admin@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 1);
-- 4 Teacher
INSERT INTO users (email, password_hash, role_id) VALUES
                                                      ('teacher1@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 2),
                                                      ('teacher2@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 2),
                                                      ('teacher3@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 2),
                                                      ('teacher4@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 2);

-- 2 Academic Staff
INSERT INTO users (email, password_hash, role_id) VALUES
                                                      ('academic1@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 4),
                                                      ('academic2@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 4);

-- 23 Student (trong đó 10 is_delete = 1)
INSERT INTO users (email, password_hash, role_id, is_delete) VALUES
                                                                 ('student1@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1),
                                                                 ('student2@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1),
                                                                 ('student3@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1),
                                                                 ('student4@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1),
                                                                 ('student5@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1),
                                                                 ('student6@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1),
                                                                 ('student7@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1),
                                                                 ('student8@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1),
                                                                 ('student9@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1),
                                                                 ('student10@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 1);
INSERT INTO users (email, password_hash, role_id) VALUES
                                                      ('student11@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student12@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student13@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student14@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student15@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student16@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student17@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student18@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student19@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student20@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student21@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student22@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3),
                                                      ('student23@codegym.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3);

-- ================== STAFF ==================
INSERT INTO staff (user_id, full_name, phone, dob, position, address) VALUES
                                                                          (2, 'Teacher One', '0901000001', '1980-01-05', 'Teacher', 'Hanoi'),
                                                                          (3, 'Teacher Two', '0901000002', '1982-03-12', 'Teacher', 'Hanoi'),
                                                                          (4, 'Teacher Three', '0901000003', '1985-07-21', 'Teacher', 'Hanoi'),
                                                                          (5, 'Teacher Four', '0901000004', '1983-11-30', 'Teacher', 'Hanoi'),
                                                                          (6, 'Academic Staff One', '0901000011', '1975-05-15', 'Academic Staff', 'Hanoi'),
                                                                          (7, 'Academic Staff Two', '0901000012', '1978-08-10', 'Academic Staff', 'Hanoi');

-- ================== STUDENTS ==================
INSERT INTO students (user_id, full_name, phone, dob, position, address) VALUES
                                                                             (8, 'Student One', '0910000001', '2000-01-01', 'Học viên', 'Hanoi'),
                                                                             (9, 'Student Two', '0910000002', '2000-02-02', 'Học viên', 'Hanoi'),
                                                                             (10, 'Student Three', '0910000003', '2000-03-03', 'Học viên', 'Hanoi'),
                                                                             (11, 'Student Four', '0910000004', '2000-04-04', 'Học viên', 'Hanoi'),
                                                                             (12, 'Student Five', '0910000005', '2000-05-05', 'Học viên', 'Hanoi'),
                                                                             (13, 'Student Six', '0910000006', '2000-06-06', 'Học viên', 'Hanoi'),
                                                                             (14, 'Student Seven', '0910000007', '2000-07-07', 'Học viên', 'Hanoi'),
                                                                             (15, 'Student Eight', '0910000008', '2000-08-08', 'Học viên', 'Hanoi'),
                                                                             (16, 'Student Nine', '0910000009', '2000-09-09', 'Học viên', 'Hanoi'),
                                                                             (17, 'Student Ten', '0910000010', '2000-10-10', 'Học viên', 'Hanoi'),
                                                                             (18, 'Student Eleven', '0910000011', '2000-11-11', 'Học viên', 'Hanoi'),
                                                                             (19, 'Student Twelve', '0910000012', '2000-12-12', 'Học viên', 'Hanoi'),
                                                                             (20, 'Student Thirteen', '0910000013', '2001-01-13', 'Học viên', 'Hanoi'),
                                                                             (21, 'Student Fourteen', '0910000014', '2001-02-14', 'Học viên', 'Hanoi'),
                                                                             (22, 'Student Fifteen', '0910000015', '2001-03-15', 'Học viên', 'Hanoi'),
                                                                             (23, 'Student Sixteen', '0910000016', '2001-04-16', 'Học viên', 'Hanoi'),
                                                                             (24, 'Student Seventeen', '0910000017', '2001-05-17', 'Học viên', 'Hanoi'),
                                                                             (25, 'Student Eighteen', '0910000018', '2001-06-18', 'Học viên', 'Hanoi'),
                                                                             (26, 'Student Nineteen', '0910000019', '2001-07-19', 'Học viên', 'Hanoi'),
                                                                             (27, 'Student Twenty', '0910000020', '2001-08-20', 'Học viên', 'Hanoi'),
                                                                             (28, 'Student Twenty-One', '0910000021', '2001-09-21', 'Học viên', 'Hanoi'),
                                                                             (29, 'Student Twenty-Two', '0910000022', '2001-10-22', 'Học viên', 'Hanoi'),
                                                                             (30, 'Student Twenty-Three', '0910000023', '2001-11-23', 'Học viên', 'Hanoi');


-- 1. Courses
-- ----------------------
INSERT INTO courses (course_name, description) VALUES
                                                   ('Java Web Basics', 'Khóa học Java Web cơ bản'),
                                                   ('Spring Boot Advanced', 'Khóa học Spring Boot nâng cao'),
                                                   ('Frontend Development', 'Khóa học phát triển Frontend');

-- ----------------------
-- 2. Modules
-- ----------------------
-- Course 1
INSERT INTO modules (course_id, module_name, sort_order) VALUES
                                                             (1, 'Module 1 - Java Basics', 1),
                                                             (1, 'Module 2 - OOP in Java', 2),
                                                             (1, 'Module 3 - JSP & Servlets', 3);

-- Course 2
INSERT INTO modules (course_id, module_name, sort_order) VALUES
                                                             (2, 'Module 1 - Spring Core', 1),
                                                             (2, 'Module 2 - Spring Boot', 2),
                                                             (2, 'Module 3 - Spring Data JPA', 3);

-- Course 3
INSERT INTO modules (course_id, module_name, sort_order) VALUES
                                                             (3, 'Module 1 - HTML & CSS', 1),
                                                             (3, 'Module 2 - JavaScript Basics', 2),
                                                             (3, 'Module 3 - React Basics', 3);


-- ----------------------
-- 3. Lessons
-- ----------------------
-- Course 1 Modules
-- Module 1
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (1, 'Lesson 1 - Java Introduction', 1),
                                                             (1, 'Lesson 2 - Variables & Data Types', 2),
                                                             (1, 'Lesson 3 - Operators', 3),
                                                             (1, 'Lesson 4 - Control Flow', 4),
                                                             (1, 'Lesson 5 - Loops', 5);

-- Module 2
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (2, 'Lesson 1 - Classes & Objects', 1),
                                                             (2, 'Lesson 2 - Inheritance', 2),
                                                             (2, 'Lesson 3 - Polymorphism', 3),
                                                             (2, 'Lesson 4 - Abstraction', 4),
                                                             (2, 'Lesson 5 - Encapsulation', 5);

-- Module 3
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (3, 'Lesson 1 - Introduction to JSP', 1),
                                                             (3, 'Lesson 2 - JSP Directives', 2),
                                                             (3, 'Lesson 3 - JSP Scriptlets', 3),
                                                             (3, 'Lesson 4 - Servlets Basics', 4),
                                                             (3, 'Lesson 5 - Servlet Lifecycle', 5);

-- Course 2 Modules
-- Module 1
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (4, 'Lesson 1 - Spring Framework Overview', 1),
                                                             (4, 'Lesson 2 - Beans & Dependency Injection', 2),
                                                             (4, 'Lesson 3 - Spring Context', 3),
                                                             (4, 'Lesson 4 - Application Configuration', 4),
                                                             (4, 'Lesson 5 - Spring Lifecycle', 5);

-- Module 2
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (5, 'Lesson 1 - Spring Boot Introduction', 1),
                                                             (5, 'Lesson 2 - Auto Configuration', 2),
                                                             (5, 'Lesson 3 - Spring Boot Starter', 3),
                                                             (5, 'Lesson 4 - REST API', 4),
                                                             (5, 'Lesson 5 - Exception Handling', 5);

-- Module 3
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (6, 'Lesson 1 - JPA Basics', 1),
                                                             (6, 'Lesson 2 - Entity & Table', 2),
                                                             (6, 'Lesson 3 - Repository', 3),
                                                             (6, 'Lesson 4 - CRUD Operations', 4),
                                                             (6, 'Lesson 5 - JPQL Queries', 5);

-- Course 3 Modules
-- Module 1
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (7, 'Lesson 1 - HTML Basics', 1),
                                                             (7, 'Lesson 2 - CSS Basics', 2),
                                                             (7, 'Lesson 3 - Box Model', 3),
                                                             (7, 'Lesson 4 - Flexbox', 4),
                                                             (7, 'Lesson 5 - CSS Grid', 5);

-- Module 2
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (8, 'Lesson 1 - JS Variables', 1),
                                                             (8, 'Lesson 2 - Functions', 2),
                                                             (8, 'Lesson 3 - DOM Manipulation', 3),
                                                             (8, 'Lesson 4 - Events', 4),
                                                             (8, 'Lesson 5 - ES6 Features', 5);

-- Module 3
INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (9, 'Lesson 1 - React Overview', 1),
                                                             (9, 'Lesson 2 - JSX', 2),
                                                             (9, 'Lesson 3 - Components', 3),
                                                             (9, 'Lesson 4 - State & Props', 4),
                                                             (9, 'Lesson 5 - Event Handling', 5);


-- ----------------------
-- Lesson Contents
-- lesson_id 1 -> 45

INSERT INTO lesson_contents (lesson_id, content_type, content_data) VALUES
                                                                        (1, 'text', 'Nội dung text cho Lesson 1'),
                                                                        (1, 'video', 'Video hướng dẫn cho Lesson 1'),

                                                                        (2, 'text', 'Nội dung text cho Lesson 2'),
                                                                        (2, 'video', 'Video hướng dẫn cho Lesson 2'),

                                                                        (3, 'text', 'Nội dung text cho Lesson 3'),
                                                                        (3, 'video', 'Video hướng dẫn cho Lesson 3'),

                                                                        (4, 'text', 'Nội dung text cho Lesson 4'),
                                                                        (4, 'video', 'Video hướng dẫn cho Lesson 4'),

                                                                        (5, 'text', 'Nội dung text cho Lesson 5'),
                                                                        (5, 'video', 'Video hướng dẫn cho Lesson 5'),

                                                                        (6, 'text', 'Nội dung text cho Lesson 6'),
                                                                        (6, 'video', 'Video hướng dẫn cho Lesson 6'),

                                                                        (7, 'text', 'Nội dung text cho Lesson 7'),
                                                                        (7, 'video', 'Video hướng dẫn cho Lesson 7'),

                                                                        (8, 'text', 'Nội dung text cho Lesson 8'),
                                                                        (8, 'video', 'Video hướng dẫn cho Lesson 8'),

                                                                        (9, 'text', 'Nội dung text cho Lesson 9'),
                                                                        (9, 'video', 'Video hướng dẫn cho Lesson 9'),

                                                                        (10, 'text', 'Nội dung text cho Lesson 10'),
                                                                        (10, 'video', 'Video hướng dẫn cho Lesson 10'),

                                                                        (11, 'text', 'Nội dung text cho Lesson 11'),
                                                                        (11, 'video', 'Video hướng dẫn cho Lesson 11'),

                                                                        (12, 'text', 'Nội dung text cho Lesson 12'),
                                                                        (12, 'video', 'Video hướng dẫn cho Lesson 12'),

                                                                        (13, 'text', 'Nội dung text cho Lesson 13'),
                                                                        (13, 'video', 'Video hướng dẫn cho Lesson 13'),

                                                                        (14, 'text', 'Nội dung text cho Lesson 14'),
                                                                        (14, 'video', 'Video hướng dẫn cho Lesson 14'),

                                                                        (15, 'text', 'Nội dung text cho Lesson 15'),
                                                                        (15, 'video', 'Video hướng dẫn cho Lesson 15'),

                                                                        (16, 'text', 'Nội dung text cho Lesson 16'),
                                                                        (16, 'video', 'Video hướng dẫn cho Lesson 16'),

                                                                        (17, 'text', 'Nội dung text cho Lesson 17'),
                                                                        (17, 'video', 'Video hướng dẫn cho Lesson 17'),

                                                                        (18, 'text', 'Nội dung text cho Lesson 18'),
                                                                        (18, 'video', 'Video hướng dẫn cho Lesson 18'),

                                                                        (19, 'text', 'Nội dung text cho Lesson 19'),
                                                                        (19, 'video', 'Video hướng dẫn cho Lesson 19'),

                                                                        (20, 'text', 'Nội dung text cho Lesson 20'),
                                                                        (20, 'video', 'Video hướng dẫn cho Lesson 20'),

                                                                        (21, 'text', 'Nội dung text cho Lesson 21'),
                                                                        (21, 'video', 'Video hướng dẫn cho Lesson 21'),

                                                                        (22, 'text', 'Nội dung text cho Lesson 22'),
                                                                        (22, 'video', 'Video hướng dẫn cho Lesson 22'),

                                                                        (23, 'text', 'Nội dung text cho Lesson 23'),
                                                                        (23, 'video', 'Video hướng dẫn cho Lesson 23'),

                                                                        (24, 'text', 'Nội dung text cho Lesson 24'),
                                                                        (24, 'video', 'Video hướng dẫn cho Lesson 24'),

                                                                        (25, 'text', 'Nội dung text cho Lesson 25'),
                                                                        (25, 'video', 'Video hướng dẫn cho Lesson 25'),

                                                                        (26, 'text', 'Nội dung text cho Lesson 26'),
                                                                        (26, 'video', 'Video hướng dẫn cho Lesson 26'),

                                                                        (27, 'text', 'Nội dung text cho Lesson 27'),
                                                                        (27, 'video', 'Video hướng dẫn cho Lesson 27'),

                                                                        (28, 'text', 'Nội dung text cho Lesson 28'),
                                                                        (28, 'video', 'Video hướng dẫn cho Lesson 28'),

                                                                        (29, 'text', 'Nội dung text cho Lesson 29'),
                                                                        (29, 'video', 'Video hướng dẫn cho Lesson 29'),

                                                                        (30, 'text', 'Nội dung text cho Lesson 30'),
                                                                        (30, 'video', 'Video hướng dẫn cho Lesson 30'),

                                                                        (31, 'text', 'Nội dung text cho Lesson 31'),
                                                                        (31, 'video', 'Video hướng dẫn cho Lesson 31'),

                                                                        (32, 'text', 'Nội dung text cho Lesson 32'),
                                                                        (32, 'video', 'Video hướng dẫn cho Lesson 32'),

                                                                        (33, 'text', 'Nội dung text cho Lesson 33'),
                                                                        (33, 'video', 'Video hướng dẫn cho Lesson 33'),

                                                                        (34, 'text', 'Nội dung text cho Lesson 34'),
                                                                        (34, 'video', 'Video hướng dẫn cho Lesson 34'),

                                                                        (35, 'text', 'Nội dung text cho Lesson 35'),
                                                                        (35, 'video', 'Video hướng dẫn cho Lesson 35'),

                                                                        (36, 'text', 'Nội dung text cho Lesson 36'),
                                                                        (36, 'video', 'Video hướng dẫn cho Lesson 36'),

                                                                        (37, 'text', 'Nội dung text cho Lesson 37'),
                                                                        (37, 'video', 'Video hướng dẫn cho Lesson 37'),

                                                                        (38, 'text', 'Nội dung text cho Lesson 38'),
                                                                        (38, 'video', 'Video hướng dẫn cho Lesson 38'),

                                                                        (39, 'text', 'Nội dung text cho Lesson 39'),
                                                                        (39, 'video', 'Video hướng dẫn cho Lesson 39'),

                                                                        (40, 'text', 'Nội dung text cho Lesson 40'),
                                                                        (40, 'video', 'Video hướng dẫn cho Lesson 40'),

                                                                        (41, 'text', 'Nội dung text cho Lesson 41'),
                                                                        (41, 'video', 'Video hướng dẫn cho Lesson 41'),

                                                                        (42, 'text', 'Nội dung text cho Lesson 42'),
                                                                        (42, 'video', 'Video hướng dẫn cho Lesson 42'),

                                                                        (43, 'text', 'Nội dung text cho Lesson 43'),
                                                                        (43, 'video', 'Video hướng dẫn cho Lesson 43'),

                                                                        (44, 'text', 'Nội dung text cho Lesson 44'),
                                                                        (44, 'video', 'Video hướng dẫn cho Lesson 44'),

                                                                        (45, 'text', 'Nội dung text cho Lesson 45'),
                                                                        (45, 'video', 'Video hướng dẫn cho Lesson 45');

-- Giả sử 4 teacher có staff_id = 1,2,3,4
-- 3 courses có course_id = 1,2,3

INSERT INTO classes (class_name, course_id, teacher_id, start_date, end_date, status) VALUES
-- 2 class đầu năm 2024 -> cuối 2024, completed
('Class 1 - Java Web Basics', 1, 1, '2024-01-05', '2024-12-20', 'completed'),
('Class 2 - Spring Boot Advanced', 2, 1, '2024-01-10', '2024-12-22', 'completed'),

-- 2 class đầu năm 2025 -> cuối 2025, studying
('Class 3 - Frontend Development', 3, 2, '2025-01-05', '2025-12-20', 'studying'),
('Class 4 - Java Web Basics', 1, 2, '2025-01-10', '2025-12-22', 'studying'),

-- 2 class đầu năm 2025 -> cuối 2025, dropped
('Class 5 - Spring Boot Advanced', 2, 3, '2025-01-05', '2025-12-20', 'dropped'),
('Class 6 - Frontend Development', 3, 3, '2025-01-10', '2025-12-22', 'dropped'),

-- 2 class đầu năm 2026 -> cuối 2026, coming-soon
('Class 7 - Java Web Basics', 1, 4, '2026-01-05', '2026-12-20', 'coming-soon'),
('Class 8 - Spring Boot Advanced', 2, 4, '2026-01-10', '2026-12-22', 'coming-soon');


-- ----------------------------
-- Class 1: status = completed → module status = completed
-- Modules of course 1: module_id = 1,2,3
INSERT INTO class_module_progress (class_id, module_id, status) VALUES
                                                                    (1, 1, 'completed'),
                                                                    (1, 2, 'completed'),
                                                                    (1, 3, 'completed');

-- Class 2: status = completed → module status = completed
-- Modules of course 2: module_id = 4,5,6
INSERT INTO class_module_progress (class_id, module_id, status) VALUES
                                                                    (2, 4, 'completed'),
                                                                    (2, 5, 'completed'),
                                                                    (2, 6, 'completed');

-- Class 3: status = studying → module status = in-progress
-- Modules of course 3: module_id = 7,8,9
INSERT INTO class_module_progress (class_id, module_id, status) VALUES
                                                                    (3, 7, 'in-progress'),
                                                                    (3, 8, 'in-progress'),
                                                                    (3, 9, 'in-progress');

-- Class 4: status = studying → module status = in-progress
-- Modules of course 1: module_id = 1,2,3
INSERT INTO class_module_progress (class_id, module_id, status) VALUES
                                                                    (4, 1, 'in-progress'),
                                                                    (4, 2, 'in-progress'),
                                                                    (4, 3, 'in-progress');

-- Class 5: status = dropped → module status = not-started
-- Modules of course 2: module_id = 4,5,6
INSERT INTO class_module_progress (class_id, module_id, status) VALUES
                                                                    (5, 4, 'not-started'),
                                                                    (5, 5, 'not-started'),
                                                                    (5, 6, 'not-started');

-- Class 6: status = dropped → module status = not-started
-- Modules of course 3: module_id = 7,8,9
INSERT INTO class_module_progress (class_id, module_id, status) VALUES
                                                                    (6, 7, 'not-started'),
                                                                    (6, 8, 'not-started'),
                                                                    (6, 9, 'not-started');

-- Class 7: status = coming-soon → module status = not-started
-- Modules of course 1: module_id = 1,2,3
INSERT INTO class_module_progress (class_id, module_id, status) VALUES
                                                                    (7, 1, 'not-started'),
                                                                    (7, 2, 'not-started'),
                                                                    (7, 3, 'not-started');

-- Class 8: status = coming-soon → module status = not-started
-- Modules of course 2: module_id = 4,5,6
INSERT INTO class_module_progress (class_id, module_id, status) VALUES
                                                                    (8, 4, 'not-started'),
                                                                    (8, 5, 'not-started'),
                                                                    (8, 6, 'not-started');

-- Student 1: is_delete=1 → enrolments.status = dropped
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (1, 1, 'dropped'),
                                                          (1, 3, 'dropped');

-- Student 2: is_delete=1
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (2, 2, 'dropped'),
                                                          (2, 4, 'dropped');

-- Student 3: is_delete=1
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (3, 1, 'dropped'),
                                                          (3, 5, 'dropped');

-- Student 4: is_delete=1
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (4, 2, 'dropped'),
                                                          (4, 6, 'dropped');

-- Student 5: is_delete=1
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (5, 1, 'dropped'),
                                                          (5, 3, 'dropped');

-- Student 6: is_delete=1
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (6, 2, 'dropped'),
                                                          (6, 4, 'dropped');

-- Student 7: is_delete=1
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (7, 1, 'dropped'),
                                                          (7, 5, 'dropped');

-- Student 8: is_delete=1
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (8, 2, 'dropped'),
                                                          (8, 6, 'dropped');

-- Student 9: is_delete=1
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (9, 3, 'dropped'),
                                                          (9, 4, 'dropped');

-- Student 10: is_delete=1
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (10, 5, 'dropped'),
                                                          (10, 6, 'dropped');

-- Student 11: is_delete=0 → chọn class dựa trên class.status
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (11, 3, 'studying'),
                                                          (11, 4, 'studying');

-- Student 12
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (12, 5, 'studying'),
                                                          (12, 6, 'studying');

-- Student 13
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (13, 3, 'studying'),
                                                          (13, 4, 'studying');

-- Student 14
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (14, 5, 'studying'),
                                                          (14, 6, 'studying');

-- Student 15
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (15, 3, 'studying'),
                                                          (15, 5, 'studying');

-- Student 16
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (16, 4, 'studying'),
                                                          (16, 6, 'studying');

-- Student 17
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (17, 3, 'studying'),
                                                          (17, 5, 'studying');

-- Student 18
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (18, 4, 'studying'),
                                                          (18, 6, 'studying');

-- Student 19
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (19, 3, 'studying'),
                                                          (19, 4, 'studying');

-- Student 20
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (20, 5, 'studying'),
                                                          (20, 6, 'studying');

-- Student 21
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (21, 3, 'studying'),
                                                          (21, 5, 'studying');

-- Student 22
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (22, 4, 'studying'),
                                                          (22, 6, 'studying');

-- Student 23
INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (23, 3, 'studying'),
                                                          (23, 4, 'studying');


-- Class 3 (15 lessons, start_date 2025-01-05 → end_date 2025-12-20)
-- Chia 15 lesson ra 12 tháng → một số tháng có 2 lesson
INSERT INTO schedules (class_id, lesson_id, time_start, time_end, room) VALUES
                                                                            (3, 7,  '2025-01-10 08:00:00', '2025-01-10 09:00:00', 'Room A'),
                                                                            (3, 8,  '2025-01-25 08:00:00', '2025-01-25 09:00:00', 'Room A'),
                                                                            (3, 9,  '2025-02-10 08:00:00', '2025-02-10 09:00:00', 'Room A'),
                                                                            (3, 10, '2025-03-10 08:00:00', '2025-03-10 09:00:00', 'Room A'),
                                                                            (3, 11, '2025-04-10 08:00:00', '2025-04-10 09:00:00', 'Room A'),
                                                                            (3, 12, '2025-05-10 08:00:00', '2025-05-10 09:00:00', 'Room A'),
                                                                            (3, 13, '2025-06-10 08:00:00', '2025-06-10 09:00:00', 'Room A'),
                                                                            (3, 14, '2025-07-10 08:00:00', '2025-07-10 09:00:00', 'Room A'),
                                                                            (3, 15, '2025-08-10 08:00:00', '2025-08-10 09:00:00', 'Room A'),
                                                                            (3, 16, '2025-09-10 08:00:00', '2025-09-10 09:00:00', 'Room A'),
                                                                            (3, 17, '2025-10-10 08:00:00', '2025-10-10 09:00:00', 'Room A'),
                                                                            (3, 18, '2025-11-10 08:00:00', '2025-11-10 09:00:00', 'Room A'),
                                                                            (3, 19, '2025-12-05 08:00:00', '2025-12-05 09:00:00', 'Room A'),
                                                                            (3, 20, '2025-12-10 08:00:00', '2025-12-10 09:00:00', 'Room A'),
                                                                            (3, 21, '2025-12-15 08:00:00', '2025-12-15 09:00:00', 'Room A');

-- Class 4 (15 lessons, start_date 2025-01-10 → end_date 2025-12-22)
INSERT INTO schedules (class_id, lesson_id, time_start, time_end, room) VALUES
                                                                            (4, 1,  '2025-01-15 08:00:00', '2025-01-15 09:00:00', 'Room B'),
                                                                            (4, 2,  '2025-02-05 08:00:00', '2025-02-05 09:00:00', 'Room B'),
                                                                            (4, 3,  '2025-03-05 08:00:00', '2025-03-05 09:00:00', 'Room B'),
                                                                            (4, 4,  '2025-04-05 08:00:00', '2025-04-05 09:00:00', 'Room B'),
                                                                            (4, 5,  '2025-05-05 08:00:00', '2025-05-05 09:00:00', 'Room B'),
                                                                            (4, 6,  '2025-06-05 08:00:00', '2025-06-05 09:00:00', 'Room B'),
                                                                            (4, 7,  '2025-07-05 08:00:00', '2025-07-05 09:00:00', 'Room B'),
                                                                            (4, 8,  '2025-08-05 08:00:00', '2025-08-05 09:00:00', 'Room B'),
                                                                            (4, 9,  '2025-09-05 08:00:00', '2025-09-05 09:00:00', 'Room B'),
                                                                            (4, 10, '2025-10-05 08:00:00', '2025-10-05 09:00:00', 'Room B'),
                                                                            (4, 11, '2025-11-05 08:00:00', '2025-11-05 09:00:00', 'Room B'),
                                                                            (4, 12, '2025-12-01 08:00:00', '2025-12-01 09:00:00', 'Room B'),
                                                                            (4, 13, '2025-12-05 08:00:00', '2025-12-05 09:00:00', 'Room B'),
                                                                            (4, 14, '2025-12-10 08:00:00', '2025-12-10 09:00:00', 'Room B'),
                                                                            (4, 15, '2025-12-15 08:00:00', '2025-12-15 09:00:00', 'Room B');

-- ===================== CLASS 3 =====================
-- schedule_id 1 → 13, student_id 11 → 23
-- Xoay vòng trạng thái: present, absent, late, excused

-- Schedule 1
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (1, 11,'present'),(1,12,'absent'),(1,13,'late'),(1,14,'excused'),(1,15,'present'),
                                                             (1,16,'absent'),(1,17,'late'),(1,18,'excused'),(1,19,'present'),(1,20,'absent'),
                                                             (1,21,'late'),(1,22,'excused'),(1,23,'present');

-- Schedule 2
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (2, 11,'absent'),(2,12,'late'),(2,13,'excused'),(2,14,'present'),(2,15,'absent'),
                                                             (2,16,'late'),(2,17,'excused'),(2,18,'present'),(2,19,'absent'),(2,20,'late'),
                                                             (2,21,'excused'),(2,22,'present'),(2,23,'absent');

-- Schedule 3
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (3, 11,'late'),(3,12,'excused'),(3,13,'present'),(3,14,'absent'),(3,15,'late'),
                                                             (3,16,'excused'),(3,17,'present'),(3,18,'absent'),(3,19,'late'),(3,20,'excused'),
                                                             (3,21,'present'),(3,22,'absent'),(3,23,'late');

-- Schedule 4
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (4, 11,'excused'),(4,12,'present'),(4,13,'absent'),(4,14,'late'),(4,15,'excused'),
                                                             (4,16,'present'),(4,17,'absent'),(4,18,'late'),(4,19,'excused'),(4,20,'present'),
                                                             (4,21,'absent'),(4,22,'late'),(4,23,'excused');

-- Schedule 5
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (5, 11,'present'),(5,12,'absent'),(5,13,'late'),(5,14,'excused'),(5,15,'present'),
                                                             (5,16,'absent'),(5,17,'late'),(5,18,'excused'),(5,19,'present'),(5,20,'absent'),
                                                             (5,21,'late'),(5,22,'excused'),(5,23,'present');

-- Schedule 6
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (6, 11,'absent'),(6,12,'late'),(6,13,'excused'),(6,14,'present'),(6,15,'absent'),
                                                             (6,16,'late'),(6,17,'excused'),(6,18,'present'),(6,19,'absent'),(6,20,'late'),
                                                             (6,21,'excused'),(6,22,'present'),(6,23,'absent');

-- Schedule 7
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (7, 11,'late'),(7,12,'excused'),(7,13,'present'),(7,14,'absent'),(7,15,'late'),
                                                             (7,16,'excused'),(7,17,'present'),(7,18,'absent'),(7,19,'late'),(7,20,'excused'),
                                                             (7,21,'present'),(7,22,'absent'),(7,23,'late');

-- Schedule 8
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (8, 11,'excused'),(8,12,'present'),(8,13,'absent'),(8,14,'late'),(8,15,'excused'),
                                                             (8,16,'present'),(8,17,'absent'),(8,18,'late'),(8,19,'excused'),(8,20,'present'),
                                                             (8,21,'absent'),(8,22,'late'),(8,23,'excused');

-- Schedule 9
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (9, 11,'present'),(9,12,'absent'),(9,13,'late'),(9,14,'excused'),(9,15,'present'),
                                                             (9,16,'absent'),(9,17,'late'),(9,18,'excused'),(9,19,'present'),(9,20,'absent'),
                                                             (9,21,'late'),(9,22,'excused'),(9,23,'present');

-- Schedule 10
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (10, 11,'absent'),(10,12,'late'),(10,13,'excused'),(10,14,'present'),(10,15,'absent'),
                                                             (10,16,'late'),(10,17,'excused'),(10,18,'present'),(10,19,'absent'),(10,20,'late'),
                                                             (10,21,'excused'),(10,22,'present'),(10,23,'absent');

-- Schedule 11
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (11, 11,'late'),(11,12,'excused'),(11,13,'present'),(11,14,'absent'),(11,15,'late'),
                                                             (11,16,'excused'),(11,17,'present'),(11,18,'absent'),(11,19,'late'),(11,20,'excused'),
                                                             (11,21,'present'),(11,22,'absent'),(11,23,'late');

-- Schedule 12
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (12, 11,'excused'),(12,12,'present'),(12,13,'absent'),(12,14,'late'),(12,15,'excused'),
                                                             (12,16,'present'),(12,17,'absent'),(12,18,'late'),(12,19,'excused'),(12,20,'present'),
                                                             (12,21,'absent'),(12,22,'late'),(12,23,'excused');

-- Schedule 13 (tới 2025-12-05 08:00:00)
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (13, 11,'present'),(13,12,'absent'),(13,13,'late'),(13,14,'excused'),(13,15,'present'),
                                                             (13,16,'absent'),(13,17,'late'),(13,18,'excused'),(13,19,'present'),(13,20,'absent'),
                                                             (13,21,'late'),(13,22,'excused'),(13,23,'present');

-- ===================== CLASS 4 =====================
-- schedule_id 16 → 28, student_id 11→23, xoay vòng trạng thái tương tự
-- Schedule 16
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (16, 11,'present'),(16,12,'absent'),(16,13,'late'),(16,14,'excused'),(16,15,'present'),
                                                             (16,16,'absent'),(16,17,'late'),(16,18,'excused'),(16,19,'present'),(16,20,'absent'),
                                                             (16,21,'late'),(16,22,'excused'),(16,23,'present');

-- Schedule 17
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (17, 11,'absent'),(17,12,'late'),(17,13,'excused'),(17,14,'present'),(17,15,'absent'),
                                                             (17,16,'late'),(17,17,'excused'),(17,18,'present'),(17,19,'absent'),(17,20,'late'),
                                                             (17,21,'excused'),(17,22,'present'),(17,23,'absent');

-- Schedule 18
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (18, 11,'late'),(18,12,'excused'),(18,13,'present'),(18,14,'absent'),(18,15,'late'),
                                                             (18,16,'excused'),(18,17,'present'),(18,18,'absent'),(18,19,'late'),(18,20,'excused'),
                                                             (18,21,'present'),(18,22,'absent'),(18,23,'late');

-- Schedule 19
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (19, 11,'excused'),(19,12,'present'),(19,13,'absent'),(19,14,'late'),(19,15,'excused'),
                                                             (19,16,'present'),(19,17,'absent'),(19,18,'late'),(19,19,'excused'),(19,20,'present'),
                                                             (19,21,'absent'),(19,22,'late'),(19,23,'excused');

-- Schedule 20
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (20, 11,'present'),(20,12,'absent'),(20,13,'late'),(20,14,'excused'),(20,15,'present'),
                                                             (20,16,'absent'),(20,17,'late'),(20,18,'excused'),(20,19,'present'),(20,20,'absent'),
                                                             (20,21,'late'),(20,22,'excused'),(20,23,'present');

-- Schedule 21
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (21, 11,'absent'),(21,12,'late'),(21,13,'excused'),(21,14,'present'),(21,15,'absent'),
                                                             (21,16,'late'),(21,17,'excused'),(21,18,'present'),(21,19,'absent'),(21,20,'late'),
                                                             (21,21,'excused'),(21,22,'present'),(21,23,'absent');

-- Schedule 22
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (22, 11,'late'),(22,12,'excused'),(22,13,'present'),(22,14,'absent'),(22,15,'late'),
                                                             (22,16,'excused'),(22,17,'present'),(22,18,'absent'),(22,19,'late'),(22,20,'excused'),
                                                             (22,21,'present'),(22,22,'absent'),(22,23,'late');

-- Schedule 23
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (23, 11,'excused'),(23,12,'present'),(23,13,'absent'),(23,14,'late'),(23,15,'excused'),
                                                             (23,16,'present'),(23,17,'absent'),(23,18,'late'),(23,19,'excused'),(23,20,'present'),
                                                             (23,21,'absent'),(23,22,'late'),(23,23,'excused');

-- Schedule 24
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (24, 11,'present'),(24,12,'absent'),(24,13,'late'),(24,14,'excused'),(24,15,'present'),
                                                             (24,16,'absent'),(24,17,'late'),(24,18,'excused'),(24,19,'present'),(24,20,'absent'),
                                                             (24,21,'late'),(24,22,'excused'),(24,23,'present');

-- Schedule 25
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (25, 11,'absent'),(25,12,'late'),(25,13,'excused'),(25,14,'present'),(25,15,'absent'),
                                                             (25,16,'late'),(25,17,'excused'),(25,18,'present'),(25,19,'absent'),(25,20,'late'),
                                                             (25,21,'excused'),(25,22,'present'),(25,23,'absent');

-- Schedule 26
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (26, 11,'late'),(26,12,'excused'),(26,13,'present'),(26,14,'absent'),(26,15,'late'),
                                                             (26,16,'excused'),(26,17,'present'),(26,18,'absent'),(26,19,'late'),(26,20,'excused'),
                                                             (26,21,'present'),(26,22,'absent'),(26,23,'late');

-- Schedule 27
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (27, 11,'excused'),(27,12,'present'),(27,13,'absent'),(27,14,'late'),(27,15,'excused'),
                                                             (27,16,'present'),(27,17,'absent'),(27,18,'late'),(27,19,'excused'),(27,20,'present'),
                                                             (27,21,'absent'),(27,22,'late'),(27,23,'excused');

-- Schedule 28 (tới 2025-12-05 08:00:00)
INSERT INTO attendance (schedule_id, student_id, status) VALUES
                                                             (28, 11,'present'),(28,12,'absent'),(28,13,'late'),(28,14,'excused'),(28,15,'present'),
                                                             (28,16,'absent'),(28,17,'late'),(28,18,'excused'),(28,19,'present'),(28,20,'absent'),
                                                             (28,21,'late'),(28,22,'excused'),(28,23,'present');

-- ===================== CLASS 3: module_id 7,8,9 =====================
-- student_id 11 → 23

-- Module 7
INSERT INTO grades (student_id, module_id, theory_score, practice_score, note) VALUES
                                                                                   (11,7,8.5,9.0,''),(12,7,7.0,8.0,''),(13,7,9.0,8.5,''),(14,7,6.5,7.0,''),
                                                                                   (15,7,8.0,7.5,''),(16,7,7.5,8.0,''),(17,7,9.5,9.0,''),(18,7,6.0,7.0,''),(19,7,8.5,8.5,''),
                                                                                   (20,7,7.0,7.5,''),(21,7,8.0,9.0,''),(22,7,7.5,8.5,''),(23,7,9.0,9.0,'');

-- Module 8
INSERT INTO grades (student_id, module_id, theory_score, practice_score, note) VALUES
                                                                                   (11,8,7.5,8.0,''),(12,8,8.0,8.5,''),(13,8,9.0,9.0,''),(14,8,6.5,7.0,''),
                                                                                   (15,8,8.0,7.5,''),(16,8,7.5,8.0,''),(17,8,9.0,8.5,''),(18,8,6.0,6.5,''),(19,8,8.5,8.0,''),
                                                                                   (20,8,7.0,7.5,''),(21,8,8.0,9.0,''),(22,8,7.5,8.5,''),(23,8,9.0,9.0,'');

-- Module 9
INSERT INTO grades (student_id, module_id, theory_score, practice_score, note) VALUES
                                                                                   (11,9,8.0,8.5,''),(12,9,7.0,7.5,''),(13,9,9.0,8.0,''),(14,9,6.5,7.0,''),
                                                                                   (15,9,8.5,8.0,''),(16,9,7.5,7.5,''),(17,9,9.5,9.0,''),(18,9,6.0,6.5,''),(19,9,8.0,8.5,''),
                                                                                   (20,9,7.0,7.0,''),(21,9,8.0,8.5,''),(22,9,7.5,8.0,''),(23,9,9.0,9.0,'');

-- ===================== CLASS 4: module_id 1,2,3 =====================
-- student_id 11 → 23

-- Module 1
INSERT INTO grades (student_id, module_id, theory_score, practice_score, note) VALUES
                                                                                   (11,1,8.0,8.5,''),(12,1,7.5,8.0,''),(13,1,9.0,9.0,''),(14,1,6.5,7.0,''),
                                                                                   (15,1,8.0,7.5,''),(16,1,7.5,8.0,''),(17,1,9.5,9.0,''),(18,1,6.0,6.5,''),(19,1,8.5,8.0,''),
                                                                                   (20,1,7.0,7.5,''),(21,1,8.0,9.0,''),(22,1,7.5,8.5,''),(23,1,9.0,9.0,'');

-- Module 2
INSERT INTO grades (student_id, module_id, theory_score, practice_score, note) VALUES
                                                                                   (11,2,7.5,8.0,''),(12,2,8.0,8.5,''),(13,2,9.0,9.0,''),(14,2,6.5,7.0,''),
                                                                                   (15,2,8.0,7.5,''),(16,2,7.5,8.0,''),(17,2,9.0,8.5,''),(18,2,6.0,6.5,''),(19,2,8.5,8.0,''),
                                                                                   (20,2,7.0,7.5,''),(21,2,8.0,9.0,''),(22,2,7.5,8.5,''),(23,2,9.0,9.0,'');

-- Module 3
INSERT INTO grades (student_id, module_id, theory_score, practice_score, note) VALUES
                                                                                   (11,3,8.5,9.0,''),(12,3,7.0,7.5,''),(13,3,9.0,8.5,''),(14,3,6.5,7.0,''),
                                                                                   (15,3,8.0,7.5,''),(16,3,7.5,8.0,''),(17,3,9.5,9.0,''),(18,3,6.0,6.5,''),(19,3,8.5,8.5,''),
                                                                                   (20,3,7.0,7.5,''),(21,3,8.0,9.0,''),(22,3,7.5,8.5,''),(23,3,9.0,9.0,'');



INSERT INTO lesson_progress (student_id, lesson_id, is_completed, completed_at) VALUES
                                                                                    (1,35,false,NULL),(1,36,false,NULL),(1,37,false,NULL),(1,38,false,NULL),(1,39,false,NULL),(1,40,false,NULL),(1,41,false,NULL),(1,42,false,NULL),(1,43,false,NULL),(1,44,false,NULL),(1,45,false,NULL),

                                                                                    (5,35,false,NULL),(5,36,false,NULL),(5,37,false,NULL),(5,38,false,NULL),(5,39,false,NULL),(5,40,false,NULL),(5,41,false,NULL),(5,42,false,NULL),(5,43,false,NULL),(5,44,false,NULL),(5,45,false,NULL),

                                                                                    (9,35,false,NULL),(9,36,false,NULL),(9,37,false,NULL),(9,38,false,NULL),(9,39,false,NULL),(9,40,false,NULL),(9,41,false,NULL),(9,42,false,NULL),(9,43,false,NULL),(9,44,false,NULL),(9,45,false,NULL),

                                                                                    (11,35,false,NULL),(11,36,false,NULL),(11,37,false,NULL),(11,38,false,NULL),(11,39,false,NULL),(11,40,false,NULL),(11,41,false,NULL),(11,42,false,NULL),(11,43,false,NULL),(11,44,false,NULL),(11,45,false,NULL),

                                                                                    (13,35,false,NULL),(13,36,false,NULL),(13,37,false,NULL),(13,38,false,NULL),(13,39,false,NULL),(13,40,false,NULL),(13,41,false,NULL),(13,42,false,NULL),(13,43,false,NULL),(13,44,false,NULL),(13,45,false,NULL),

                                                                                    (15,35,false,NULL),(15,36,false,NULL),(15,37,false,NULL),(15,38,false,NULL),(15,39,false,NULL),(15,40,false,NULL),(15,41,false,NULL),(15,42,false,NULL),(15,43,false,NULL),(15,44,false,NULL),(15,45,false,NULL),

                                                                                    (17,35,false,NULL),(17,36,false,NULL),(17,37,false,NULL),(17,38,false,NULL),(17,39,false,NULL),(17,40,false,NULL),(17,41,false,NULL),(17,42,false,NULL),(17,43,false,NULL),(17,44,false,NULL),(17,45,false,NULL),

                                                                                    (19,35,false,NULL),(19,36,false,NULL),(19,37,false,NULL),(19,38,false,NULL),(19,39,false,NULL),(19,40,false,NULL),(19,41,false,NULL),(19,42,false,NULL),(19,43,false,NULL),(19,44,false,NULL),(19,45,false,NULL),

                                                                                    (21,35,false,NULL),(21,36,false,NULL),(21,37,false,NULL),(21,38,false,NULL),(21,39,false,NULL),(21,40,false,NULL),(21,41,false,NULL),(21,42,false,NULL),(21,43,false,NULL),(21,44,false,NULL),(21,45,false,NULL),

                                                                                    (23,35,false,NULL),(23,36,false,NULL),(23,37,false,NULL),(23,38,false,NULL),(23,39,false,NULL),(23,40,false,NULL),(23,41,false,NULL),(23,42,false,NULL),(23,43,false,NULL),(23,44,false,NULL),(23,45,false,NULL);


INSERT INTO lesson_progress (student_id, lesson_id, is_completed, completed_at) VALUES
                                                                                    (2,1,false,NULL),(2,2,false,NULL),(2,3,false,NULL),(2,4,false,NULL),(2,5,false,NULL),(2,6,false,NULL),(2,7,false,NULL),(2,8,false,NULL),(2,9,false,NULL),(2,10,false,NULL),(2,11,false,NULL),(2,12,false,NULL),(2,13,false,NULL),(2,14,false,NULL),(2,15,false,NULL),

                                                                                    (6,1,false,NULL),(6,2,false,NULL),(6,3,false,NULL),(6,4,false,NULL),(6,5,false,NULL),(6,6,false,NULL),(6,7,false,NULL),(6,8,false,NULL),(6,9,false,NULL),(6,10,false,NULL),(6,11,false,NULL),(6,12,false,NULL),(6,13,false,NULL),(6,14,false,NULL),(6,15,false,NULL),

                                                                                    (9,1,false,NULL),(9,2,false,NULL),(9,3,false,NULL),(9,4,false,NULL),(9,5,false,NULL),(9,6,false,NULL),(9,7,false,NULL),(9,8,false,NULL),(9,9,false,NULL),(9,10,false,NULL),(9,11,false,NULL),(9,12,false,NULL),(9,13,false,NULL),(9,14,false,NULL),(9,15,false,NULL),

                                                                                    (11,1,false,NULL),(11,2,false,NULL),(11,3,false,NULL),(11,4,false,NULL),(11,5,false,NULL),(11,6,false,NULL),(11,7,false,NULL),(11,8,false,NULL),(11,9,false,NULL),(11,10,false,NULL),(11,11,false,NULL),(11,12,false,NULL),(11,13,false,NULL),(11,14,false,NULL),(11,15,false,NULL),

                                                                                    (13,1,false,NULL),(13,2,false,NULL),(13,3,false,NULL),(13,4,false,NULL),(13,5,false,NULL),(13,6,false,NULL),(13,7,false,NULL),(13,8,false,NULL),(13,9,false,NULL),(13,10,false,NULL),(13,11,false,NULL),(13,12,false,NULL),(13,13,false,NULL),(13,14,false,NULL),(13,15,false,NULL),

                                                                                    (16,1,false,NULL),(16,2,false,NULL),(16,3,false,NULL),(16,4,false,NULL),(16,5,false,NULL),(16,6,false,NULL),(16,7,false,NULL),(16,8,false,NULL),(16,9,false,NULL),(16,10,false,NULL),(16,11,false,NULL),(16,12,false,NULL),(16,13,false,NULL),(16,14,false,NULL),(16,15,false,NULL),

                                                                                    (18,1,false,NULL),(18,2,false,NULL),(18,3,false,NULL),(18,4,false,NULL),(18,5,false,NULL),(18,6,false,NULL),(18,7,false,NULL),(18,8,false,NULL),(18,9,false,NULL),(18,10,false,NULL),(18,11,false,NULL),(18,12,false,NULL),(18,13,false,NULL),(18,14,false,NULL),(18,15,false,NULL),

                                                                                    (19,1,false,NULL),(19,2,false,NULL),(19,3,false,NULL),(19,4,false,NULL),(19,5,false,NULL),(19,6,false,NULL),(19,7,false,NULL),(19,8,false,NULL),(19,9,false,NULL),(19,10,false,NULL),(19,11,false,NULL),(19,12,false,NULL),(19,13,false,NULL),(19,14,false,NULL),(19,15,false,NULL),

                                                                                    (22,1,false,NULL),(22,2,false,NULL),(22,3,false,NULL),(22,4,false,NULL),(22,5,false,NULL),(22,6,false,NULL),(22,7,false,NULL),(22,8,false,NULL),(22,9,false,NULL),(22,10,false,NULL),(22,11,false,NULL),(22,12,false,NULL),(22,13,false,NULL),(22,14,false,NULL),(22,15,false,NULL),

                                                                                    (23,1,false,NULL),(23,2,false,NULL),(23,3,false,NULL),(23,4,false,NULL),(23,5,false,NULL),(23,6,false,NULL),(23,7,false,NULL),(23,8,false,NULL),(23,9,false,NULL),(23,10,false,NULL),(23,11,false,NULL),(23,12,false,NULL),(23,13,false,NULL),(23,14,false,NULL),(23,15,false,NULL);




-- Student Logs
INSERT INTO student_logs (student_id, author_staff_id, content) VALUES
                                                                    (11,2,'Điểm danh đầy đủ, thái độ tốt.'),
                                                                    (11,6,'Gợi ý học thêm bài tập về module 7.'),
                                                                    (12,2,'Vắng 1 buổi do ốm, bù lịch kịp thời.'),
                                                                    (13,3,'Hoàn thành bài tập muộn 1 ngày.'),
                                                                    (14,3,'Tham gia nhiệt tình, cần cải thiện thực hành.'),
                                                                    (15,4,'Chưa nộp bài tập module 8.'),
                                                                    (16,4,'Có tiến bộ về lý thuyết, thực hành còn yếu.'),
                                                                    (17,2,'Tham gia nhóm tốt, hỗ trợ bạn bè.'),
                                                                    (18,3,'Cần tập trung hơn khi làm bài thực hành.'),
                                                                    (19,4,'Hoàn thành bài kiểm tra module 9 xuất sắc.'),
                                                                    (20,2,'Vắng 2 buổi, nhắc nhở học sinh.'),
                                                                    (21,3,'Có ý tưởng sáng tạo trong dự án nhóm.'),
                                                                    (22,4,'Cần bổ sung kiến thức lý thuyết cơ bản.'),
                                                                    (23,2,'Hoàn thành toàn bộ bài tập đúng hạn.');

-- Class Logs
INSERT INTO class_logs (class_id, author_staff_id, content) VALUES
                                                                (1,2,'Class khởi động ổn, sinh viên tham gia đầy đủ.'),
                                                                (2,2,'Học viên có tiến bộ về lý thuyết module 1.'),
                                                                (3,3,'Lịch học module 7 – 9 đã phân bổ đều, sinh viên theo kịp.'),
                                                                (4,3,'Một số sinh viên cần ôn tập lại bài cũ.'),
                                                                (5,4,'Class mới, chuẩn bị tài liệu học tập.'),
                                                                (6,4,'Đang theo dõi tiến độ học viên, chưa có vấn đề.'),
                                                                (7,5,'Chia nhóm thực hành module 3 thành công.'),
                                                                (8,5,'Sinh viên tham gia nhiệt tình, dự án nhóm đạt yêu cầu.');