drop database codegym;
create DATABASE codegym;
USE codegym;

-- -----------------------------------------------------
-- 1. QUẢN LÝ NGƯỜI DÙNG & VAI TRÒ
-- -----------------------------------------------------

CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE COMMENT 'Tên vai trò'
);

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE SET NULL
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    dob DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE staff (
    staff_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    position VARCHAR(100) COMMENT 'Chức vụ',
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- 2. NỘI DUNG KHÓA HỌC
-- -----------------------------------------------------

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(255) NOT NULL,
    description TEXT
);

CREATE TABLE modules (
    module_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    module_name VARCHAR(255) NOT NULL,
    sort_order INT DEFAULT 0,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

CREATE TABLE lessons (
    lesson_id INT AUTO_INCREMENT PRIMARY KEY,
    module_id INT NOT NULL,
    lesson_name VARCHAR(255) NOT NULL,
    sort_order INT DEFAULT 0,
    FOREIGN KEY (module_id) REFERENCES modules(module_id) ON DELETE CASCADE
);

CREATE TABLE lesson_contents (
    content_id INT AUTO_INCREMENT PRIMARY KEY,
    lesson_id INT NOT NULL,
    content_type ENUM('text', 'video', 'quiz', 'markdown') NOT NULL,
    content_data TEXT,
    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE CASCADE
);

-- -----------------------------------------------------
-- 3. LỚP HỌC & TÁC NGHIỆP
-- -----------------------------------------------------

CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(100) NOT NULL UNIQUE,
    course_id INT NOT NULL,
    teacher_id INT,
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES staff(staff_id) ON DELETE SET NULL
);

CREATE TABLE enrolments (
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    enrol_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('studying', 'completed', 'dropped') DEFAULT 'studying',
    PRIMARY KEY (student_id, class_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE
);

CREATE TABLE schedules (
    schedule_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    lesson_id INT,
    time_start DATETIME NOT NULL,
    time_end DATETIME NOT NULL,
    room VARCHAR(50),
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE SET NULL
);

-- -----------------------------------------------------
-- 4. THEO DÕI & LOG
-- -----------------------------------------------------

CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    schedule_id INT NOT NULL,
    student_id INT NOT NULL,
    status ENUM('present', 'absent', 'late', 'excused') NOT NULL,
    note TEXT,
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id) ON DELETE CASCADE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    UNIQUE(schedule_id, student_id)
);

CREATE TABLE grades (
    student_id INT NOT NULL,
    module_id INT NOT NULL,
    score DECIMAL(5,2) NOT NULL,
    note TEXT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (student_id, module_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (module_id) REFERENCES modules(module_id) ON DELETE CASCADE
);

CREATE TABLE lesson_progress (
    student_id INT NOT NULL,
    lesson_id INT NOT NULL,
    is_completed BOOLEAN DEFAULT false,
    completed_at TIMESTAMP,
    PRIMARY KEY (student_id, lesson_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id) REFERENCES lessons(lesson_id) ON DELETE CASCADE
);

CREATE TABLE student_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    author_staff_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (author_staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE
);

CREATE TABLE class_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    author_staff_id INT NOT NULL,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (class_id) REFERENCES classes(class_id) ON DELETE CASCADE,
    FOREIGN KEY (author_staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE
);
