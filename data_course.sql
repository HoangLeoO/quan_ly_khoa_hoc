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


INSERT INTO users (email, password_hash, role_id, is_delete) VALUES
-- 10 staff
('admin@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 1, 0),
('teacher1@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 2, 0),
('teacher2@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 2, 0),
('teacher3@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 2, 0),
('academic1@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 4, 0),
('academic2@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 4, 0),
('advisor@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 4, 0),
('coordinator@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 4, 0),
('support1@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 4, 0),
('support2@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 4, 0),

-- 10 students
('student1@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 0),
('student2@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 0),
('student3@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 0),
('student4@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 0),
('student5@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 0),
('student6@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 0),
('student7@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 0),
('student8@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 0),
('student9@cg.com', '$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau', 3, 0),
('student10@cg.com','$2a$10$EVg/oWJBbmuMWflTfKJ1pOUbXcbzUi5eae.1KA/k8fT8bfdUtDPau',3, 0);



-- -----------------------------------------------------
-- 4. STAFF
-- -----------------------------------------------------
INSERT INTO staff (user_id, full_name, phone, dob, position, address) VALUES
                                                                          (1, 'Admin One', '0900000001', '1990-01-01', 'Admin', 'HN'),
                                                                          (2, 'Teacher One', '0900000002', '1988-02-02', 'Teacher', 'HCM'),
                                                                          (3, 'Teacher Two', '0900000003', '1989-03-03', 'Teacher', 'HCM'),
                                                                          (4, 'Teacher Three', '0900000004', '1987-04-04', 'Teacher', 'DN'),
                                                                          (5, 'Academic Staff A', '0900000005', '1992-05-05', 'Academic', 'HN'),
                                                                          (6, 'Academic Staff B', '0900000006', '1993-06-06', 'Academic', 'HN'),
                                                                          (7, 'Advisor One', '0900000007', '1994-07-07', 'Advisor', 'HCM'),
                                                                          (8, 'Coordinator One','0900000008','1995-08-08','Coordinator','DN'),
                                                                          (9, 'Support One','0900000009','1996-09-09','Support','HN'),
                                                                          (10,'Support Two','0900000010','1997-10-10','Support','HCM');

INSERT INTO students (user_id, full_name, phone, dob, position, address) VALUES
                                                                             (11, 'Student One', '0911111111', '2000-01-01', 'Học viên', 'HN'),
                                                                             (12, 'Student Two', '0911111112', '2000-02-02', 'Học viên', 'HCM'),
                                                                             (13, 'Student Three', '0911111113', '2000-03-03', 'Học viên', 'DN'),
                                                                             (14, 'Student Four', '0911111114', '2000-04-04', 'Học viên', 'HN'),
                                                                             (15, 'Student Five', '0911111115', '2000-05-05', 'Học viên', 'HCM'),
                                                                             (16, 'Student Six', '0911111116', '2000-06-06', 'Học viên', 'HN'),
                                                                             (17, 'Student Seven', '0911111117', '2000-07-07', 'Học viên', 'DN'),
                                                                             (18, 'Student Eight', '0911111118', '2000-08-08', 'Học viên', 'HCM'),
                                                                             (19, 'Student Nine', '0911111119', '2000-09-09', 'Học viên', 'HN'),
                                                                             (20, 'Student Ten', '0911111120', '2000-10-10', 'Học viên', 'DN');


INSERT INTO courses (course_name, description) VALUES
                                                   ('Java Fullstack', 'Fullstack Java learning path'),
                                                   ('Spring Boot Mastery', 'Deep dive Spring Boot'),
                                                   ('Frontend React', 'React course'),
                                                   ('Database MySQL', 'Learning MySQL'),
                                                   ('HTML + CSS', 'Basic web foundation'),
                                                   ('Docker DevOps', 'Docker fundamentals'),
                                                   ('NodeJS Backend', 'Node.js backend'),
                                                   ('Python Web', 'Python Flask Django web'),
                                                   ('Mobile Flutter', 'Flutter mobile app'),
                                                   ('AWS Cloud', 'AWS training');


INSERT INTO modules (course_id, module_name, sort_order) VALUES
                                                             (1, 'Java Core', 1),
                                                             (2, 'Spring Boot Intro', 1),
                                                             (3, 'React Basics', 1),
                                                             (4, 'MySQL Basic', 1),
                                                             (5, 'HTML & CSS Basic', 1),
                                                             (6, 'Docker Engine', 1),
                                                             (7, 'Node Intro', 1),
                                                             (8, 'Python Web Intro', 1),
                                                             (9, 'Flutter Widgets', 1),
                                                             (10,'AWS EC2 Intro', 1);

INSERT INTO lessons (module_id, lesson_name, sort_order) VALUES
                                                             (1,'Java Variables',1),
                                                             (2,'Spring Boot Starter',1),
                                                             (3,'React Components',1),
                                                             (4,'MySQL SELECT',1),
                                                             (5,'CSS Flexbox',1),
                                                             (6,'Dockerfile Basic',1),
                                                             (7,'NodeJS Routing',1),
                                                             (8,'Flask Routing',1),
                                                             (9,'Flutter Layout',1),
                                                             (10,'EC2 Launch',1);


INSERT INTO lesson_contents (lesson_id, content_type, content_data) VALUES
                                                                        (1,'text','Java variable explanation'),
                                                                        (2,'video','spring_boot_intro.mp4'),
                                                                        (3,'text','React component content'),
                                                                        (4,'text','MySQL SELECT tutorial'),
                                                                        (5,'video','flexbox_tutorial.mp4'),
                                                                        (6,'quiz','Dockerfile quiz'),
                                                                        (7,'video','node_routing.mp4'),
                                                                        (8,'text','Flask routing article'),
                                                                        (9,'quiz','Flutter widget quiz'),
                                                                        (10,'text','EC2 launch guide');


INSERT INTO classes (class_name, course_id, teacher_id, start_date, end_date, status) VALUES
                                                                                          ('JV-FS-01',1,2,'2025-01-01','2025-06-01','studying'),
                                                                                          ('SP-BOOT-01',2,3,'2025-02-01','2025-05-01','coming-soon'),
                                                                                          ('REACT-01',3,4,'2025-01-15','2025-04-15','studying'),
                                                                                          ('MYSQL-01',4,5,'2025-01-10','2025-02-20','completed'),
                                                                                          ('HTMLCSS-01',5,6,'2025-03-01','2025-05-01','studying'),
                                                                                          ('DOCKER-01',6,7,'2025-01-05','2025-02-05','completed'),
                                                                                          ('NODE-01',7,8,'2025-02-10','2025-06-10','studying'),
                                                                                          ('PY-WEB-01',8,9,'2025-03-05','2025-07-05','studying'),
                                                                                          ('FLUTTER-01',9,10,'2025-02-15','2025-03-15','dropped'),
                                                                                          ('AWS-01',10,5,'2025-04-01','2025-08-01','coming-soon');


INSERT INTO enrolments (student_id, class_id, status) VALUES
                                                          (1,1,'studying'),
                                                          (2,1,'studying'),
                                                          (3,2,'studying'),   -- sửa comingsoon -> studying
                                                          (4,3,'studying'),
                                                          (5,4,'completed'),
                                                          (6,5,'studying'),
                                                          (7,6,'completed'),
                                                          (8,7,'studying'),
                                                          (9,8,'studying'),
                                                          (10,9,'dropped');


INSERT INTO schedules (class_id, lesson_id, time_start, time_end, room) VALUES
                                                                            (1,1,'2025-01-02 08:00','2025-01-02 10:00','A1'),
                                                                            (2,2,'2025-02-02 08:00','2025-02-02 10:00','A2'),
                                                                            (3,3,'2025-01-16 09:00','2025-01-16 11:00','B1'),
                                                                            (4,4,'2025-01-11 13:00','2025-01-11 15:00','B2'),
                                                                            (5,5,'2025-03-02 08:00','2025-03-02 10:00','C1'),
                                                                            (6,6,'2025-01-06 14:00','2025-01-06 16:00','C2'),
                                                                            (7,7,'2025-02-11 09:00','2025-02-11 11:00','D1'),
                                                                            (8,8,'2025-03-06 18:00','2025-03-06 20:00','D2'),
                                                                            (9,9,'2025-02-16 08:00','2025-02-16 10:00','E1'),
                                                                            (10,10,'2025-04-02 08:00','2025-04-02 10:00','E2');


INSERT INTO attendance (student_id, status, note) VALUES
                                                      (1,'present','On time'),
                                                      (2,'absent','Sick'),
                                                      (3,'late','Came late 10 minutes'),
                                                      (4,'present','Good'),
                                                      (5,'excused','Family issue'),
                                                      (6,'present','Good'),
                                                      (7,'present','Good'),
                                                      (8,'late','Traffic'),
                                                      (9,'absent','Unknown'),
                                                      (10,'present','Participated');


INSERT INTO grades (student_id, module_id, theory_score, practice_score, note) VALUES
                                                                                   (1,1,8.5,9.0,'Good'),
                                                                                   (2,2,7.0,6.5,'Average'),
                                                                                   (3,3,9.0,9.5,'Excellent'),
                                                                                   (4,4,6.0,6.5,'OK'),
                                                                                   (5,5,8.0,7.5,'Good'),
                                                                                   (6,6,7.5,8.0,'Nice'),
                                                                                   (7,7,9.0,8.5,'Strong'),
                                                                                   (8,8,5.0,5.5,'Weak'),
                                                                                   (9,9,9.5,9.0,'Top'),
                                                                                   (10,10,7.0,7.0,'Average');

INSERT INTO lesson_progress (student_id, lesson_id, is_completed, completed_at) VALUES
                                                                                    (1,1,1,'2025-01-03'),
                                                                                    (2,1,0,NULL),
                                                                                    (3,2,1,'2025-02-03'),
                                                                                    (4,3,1,'2025-01-20'),
                                                                                    (5,4,1,'2025-01-12'),
                                                                                    (6,5,0,NULL),
                                                                                    (7,6,1,'2025-01-07'),
                                                                                    (8,7,0,NULL),
                                                                                    (9,8,1,'2025-03-07'),
                                                                                    (10,9,0,NULL);


INSERT INTO student_logs (student_id, author_staff_id, content) VALUES
                                                                    (1,2,'Progress improving'),
                                                                    (2,3,'Needs extra support'),
                                                                    (3,4,'Excellent attitude'),
                                                                    (4,5,'Late submission'),
                                                                    (5,6,'Good communication'),
                                                                    (6,7,'Participates well'),
                                                                    (7,8,'Needs motivation'),
                                                                    (8,9,'Absent frequently'),
                                                                    (9,10,'Strong performance'),
                                                                    (10,2,'Dropped from class');


INSERT INTO class_logs (class_id, author_staff_id, content) VALUES
                                                                (1,2,'Class running normally'),
                                                                (2,3,'Preparing materials'),
                                                                (3,4,'Students active'),
                                                                (4,5,'Class completed'),
                                                                (5,6,'Midterm exam result good'),
                                                                (6,7,'Completed successfully'),
                                                                (7,8,'Project phase started'),
                                                                (8,9,'Attendance dropping'),
                                                                (9,10,'Class dropped'),
                                                                (10,2,'Ready to launch syllabus');
