-- ==========================================
-- 📦 쇼핑몰 학습용 데이터베이스
-- ==========================================
-- 목적: SQL 기초 문법 연습용 샘플 데이터
-- 테이블: products (상품), employees (직원)
-- ==========================================

-- UTF-8 인코딩 설정
SET NAMES utf8mb4;

USE shop_db;

-- 데이터베이스 character set 및 collation 설정
ALTER DATABASE shop_db CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

-- ==========================================
-- 1. 상품 테이블 (products)
-- ==========================================
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price INT NOT NULL,
    stock INT DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 인덱스 생성
CREATE INDEX idx_category ON products(category);
CREATE INDEX idx_price ON products(price);
CREATE INDEX idx_stock ON products(stock);

-- ==========================================
-- 2. 직원 테이블 (employees)
-- ==========================================
CREATE TABLE employees (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    work_years INT NOT NULL COMMENT '근무기간(년)',
    salary INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 인덱스 생성
CREATE INDEX idx_department ON employees(department);
CREATE INDEX idx_work_years ON employees(work_years);

-- ==========================================
-- 3. 상품 샘플 데이터 삽입
-- ==========================================
INSERT INTO products (product_name, category, price, stock) VALUES
-- 가구 카테고리
('편안한 소파', '가구', 89000, 15),
('모던 소파', '가구', 120000, 8),
('나무 소파', '가구', 95000, 12),
('Green fabric chair', '가구', 45000, 25),
('Green leather chair', '가구', 78000, 10),
('책상', '가구', 65000, 20),
('의자', '가구', 35000, 30),

-- 옷 카테고리
('셔츠', '옷', 29000, 50),
('반팔티', '옷', 15000, 80),
('청바지', '옷', 45000, 40),
('원피스', '옷', 55000, 25),
('코트', '옷', 120000, 15),

-- 신발 카테고리
('운동화', '신발', 89000, 35),
('구두', '신발', 95000, 20),
('슬리퍼', '신발', 12000, 60),
('부츠', '신발', 110000, 18),

-- 가전 카테고리
('냉장고', '가전', 850000, 5),
('세탁기', '가전', 650000, 7),
('에어컨', '가전', 750000, 6),
('청소기', '가전', 180000, 12),
('전자레인지', '가전', 95000, 18),

-- 식품 카테고리
('사과', '식품', 5000, 100),
('바나나', '식품', 3500, 120),
('우유', '식품', 2800, 80),
('빵', '식품', 4500, 90),
('치즈', '식품', 6500, 45),

-- 경계값 테스트용
('특가 상품1', '잡화', 2500, 150),
('특가 상품2', '잡화', 2900, 18),
('고급 상품1', '잡화', 6100, 22),
('고급 상품2', '잡화', 8500, 5);

-- ==========================================
-- 4. 직원 샘플 데이터 삽입
-- ==========================================
INSERT INTO employees (name, department, work_years, salary) VALUES
-- 기획팀
('김철수', '기획팀', 1, 3000),
('이영희', '기획팀', 3, 3800),
('박민수', '기획팀', 5, 4500),

-- 개발팀
('최지훈', '개발팀', 2, 4000),
('정수진', '개발팀', 2, 4000),
('강동원', '개발팀', 7, 6000),

-- 디자인팀
('윤서연', '디자인팀', 1, 3200),
('한지민', '디자인팀', 4, 4200),

-- 마케팅팀
('송중기', '마케팅팀', 3, 3900),
('전지현', '마케팅팀', 6, 5200),

-- 인사팀
('이민호', '인사팀', 8, 6500),
('김태희', '인사팀', 4, 4300);

-- ==========================================
-- 5. 데이터 확인 쿼리
-- ==========================================

-- 전체 상품 개수 확인
SELECT COUNT(*) AS total_products FROM products;

-- 카테고리별 상품 개수
SELECT category, COUNT(*) AS count 
FROM products 
GROUP BY category 
ORDER BY count DESC;

-- 전체 직원 개수 확인
SELECT COUNT(*) AS total_employees FROM employees;

-- 부서별 직원 수
SELECT department, COUNT(*) AS count 
FROM employees 
GROUP BY department 
ORDER BY count DESC;

-- ==========================================
-- 6. 사용자 테이블 (users)
-- ==========================================
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    status VARCHAR(10), -- 'active', 'inactive'
    user_type VARCHAR(20), -- 회원 유형 (예: 'regular', 'premium', 'vip')
    join_date DATE,
    first_login_at DATETIME -- 첫 로그인 일시
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- users 테이블 인덱스
CREATE INDEX idx_users_user_type ON users(user_type);
CREATE INDEX idx_users_first_login ON users(first_login_at);

-- ==========================================
-- 7. 방문 테이블 (visits)
-- ==========================================
CREATE TABLE visits (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    visit_date DATE DEFAULT (CURRENT_DATE),
    week INT DEFAULT 0, -- 주 (1-52)
    day_of_week INT DEFAULT 0, -- 요일 (0-6, 일요일=0)
    year INT DEFAULT 0, -- 년도
    month INT DEFAULT 0, -- 월 (1-12)
    day INT DEFAULT 0, -- 일 (1-31)
    is_first_visit INT DEFAULT 0, -- 최초방문여부 (0: 아니오, 1: 예)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- visits 테이블 인덱스
CREATE UNIQUE INDEX visits_user_date_unique ON visits(user_id, visit_date);
CREATE INDEX idx_visits_user_id ON visits(user_id);
CREATE INDEX idx_visits_week ON visits(week);
CREATE INDEX idx_visits_day_of_week ON visits(day_of_week);
CREATE INDEX idx_visits_year ON visits(year);
CREATE INDEX idx_visits_month ON visits(month);
CREATE INDEX idx_visits_day ON visits(day);
CREATE INDEX idx_visits_date ON visits(visit_date);
CREATE INDEX idx_visits_first_visit ON visits(is_first_visit);

-- ==========================================
-- 8. 방문 상세 테이블 (visit_details)
-- ==========================================
CREATE TABLE visit_details (
    id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL,
    path_name VARCHAR(255) DEFAULT '/', -- 경로명 (새탭 내 이동경로)
    visit_count INT DEFAULT 0, -- 방문횟수
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (visit_id) REFERENCES visits(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- visit_details 테이블 인덱스 및 제약
CREATE UNIQUE INDEX visit_details_visit_path_unique ON visit_details(visit_id, path_name);
CREATE INDEX idx_visit_details_visit_id ON visit_details(visit_id);
CREATE INDEX idx_visit_details_path ON visit_details(path_name);

-- ==========================================
-- 9. 회원가입 로그 테이블 (user_registration_log)
-- ==========================================
CREATE TABLE user_registration_log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (visit_id) REFERENCES visits(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- user_registration_log 테이블 인덱스
CREATE INDEX idx_user_registration_visit_id ON user_registration_log(visit_id);

-- ==========================================
-- 10. 방문 세션 테이블 (visit_sessions)
-- ==========================================
CREATE TABLE visit_sessions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT NOT NULL,
    hour INT DEFAULT 0, -- 시 (0-23)
    minute INT DEFAULT 0, -- 분 (0-59)
    second INT DEFAULT 0, -- 초 (0-59)
    ip_address VARCHAR(20), -- IP 주소
    browser_type VARCHAR(20), -- 브라우저 유형
    os_type VARCHAR(20), -- OS 유형
    device_type VARCHAR(20), -- 기기 유형
    referral_type VARCHAR(100), -- 유입타입 (직접, 검색채널, 기타, SNS 등)
    search_channel_type VARCHAR(100), -- 검색채널 유형 (네이버, 구글, 다음 등)
    referral_path VARCHAR(50), -- 유입 경로
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (visit_id) REFERENCES visits(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- visit_sessions 테이블 인덱스
CREATE INDEX idx_visit_sessions_hour ON visit_sessions(hour);
CREATE INDEX idx_visit_sessions_minute ON visit_sessions(minute);
CREATE INDEX idx_visit_sessions_second ON visit_sessions(second);
CREATE INDEX idx_visit_sessions_ip ON visit_sessions(ip_address);
CREATE INDEX idx_visit_sessions_visit_id ON visit_sessions(visit_id);
CREATE INDEX idx_visit_sessions_browser ON visit_sessions(browser_type);
CREATE INDEX idx_visit_sessions_os ON visit_sessions(os_type);
CREATE INDEX idx_visit_sessions_device ON visit_sessions(device_type);
CREATE INDEX idx_visit_sessions_referral_path ON visit_sessions(referral_path);
CREATE INDEX idx_visit_sessions_search_channel ON visit_sessions(search_channel_type);

-- ==========================================
-- 11. 사용자 샘플 데이터 삽입
-- ==========================================
INSERT INTO users (id, name, status, user_type, join_date, first_login_at) VALUES 
(1, 'Alice', 'active', 'premium', '2024-01-01', '2024-01-10 09:00:00'),
(2, 'Bob', 'active', 'regular', '2024-01-15', '2024-01-10 14:20:00'),
(3, 'Charlie', 'inactive', 'regular', '2024-02-01', '2024-01-10 11:15:00'),
(4, 'Diana', 'active', 'vip', '2024-02-15', '2024-01-11 13:30:00'),
-- 추가 사용자 데이터 (WITH 절, COUNT, CROSS JOIN 연습용)
(5, 'Eve', 'active', 'premium', '2024-01-05', '2024-01-12 10:00:00'),
(6, 'Frank', 'active', 'regular', '2024-01-08', '2024-01-13 11:00:00'),
(7, 'Grace', 'active', 'vip', '2024-01-10', '2024-01-14 12:00:00'),
(8, 'Henry', 'active', 'premium', '2024-01-12', '2024-01-15 13:00:00'),
(9, 'Ivy', 'inactive', 'regular', '2024-01-15', '2024-01-16 14:00:00'),
(10, 'Jack', 'active', 'regular', '2024-01-18', '2024-01-17 15:00:00'),
(11, 'Kate', 'active', 'vip', '2024-01-20', '2024-01-18 16:00:00'),
(12, 'Leo', 'active', 'premium', '2024-01-22', '2024-01-19 17:00:00'),
(13, 'Mia', 'active', 'regular', '2024-01-25', '2024-01-20 18:00:00'),
(14, 'Noah', 'inactive', 'regular', '2024-01-28', '2024-01-21 19:00:00'),
(15, 'Olivia', 'active', 'vip', '2024-02-01', '2024-01-22 20:00:00'),
(16, 'Paul', 'active', 'premium', '2024-02-03', '2024-01-23 21:00:00'),
(17, 'Quinn', 'active', 'regular', '2024-02-05', '2024-01-24 22:00:00'),
(18, 'Ryan', 'active', 'regular', '2024-02-08', '2024-01-25 23:00:00'),
(19, 'Sophia', 'active', 'vip', '2024-02-10', '2024-01-26 10:00:00'),
(20, 'Tom', 'inactive', 'regular', '2024-02-12', '2024-01-27 11:00:00');

-- ==========================================
-- 12. 방문 샘플 데이터 삽입
-- ==========================================
INSERT INTO visits (id, user_id, visit_date, week, day_of_week, year, month, day, is_first_visit, created_at) VALUES 
(1, 1, '2024-01-10', 2, 3, 2024, 1, 10, 1, '2024-01-10 09:00:00'),
(2, 1, '2024-01-11', 2, 4, 2024, 1, 11, 0, '2024-01-11 10:30:00'),
(3, 2, '2024-01-10', 2, 3, 2024, 1, 10, 1, '2024-01-10 14:20:00'),
(4, 2, '2024-01-12', 2, 5, 2024, 1, 12, 0, '2024-01-12 16:45:00'),
(5, 3, '2024-01-10', 2, 3, 2024, 1, 10, 1, '2024-01-10 11:15:00'),
(6, 4, '2024-01-11', 2, 4, 2024, 1, 11, 1, '2024-01-11 13:30:00'),
-- 추가 방문 데이터 (다양한 날짜와 사용자로 통계 분석 가능하도록)
(7, 1, '2024-01-15', 3, 1, 2024, 1, 15, 0, '2024-01-15 09:00:00'),
(8, 1, '2024-01-20', 3, 6, 2024, 1, 20, 0, '2024-01-20 10:00:00'),
(9, 2, '2024-01-13', 2, 6, 2024, 1, 13, 0, '2024-01-13 14:00:00'),
(10, 2, '2024-01-17', 3, 3, 2024, 1, 17, 0, '2024-01-17 15:00:00'),
(11, 4, '2024-01-14', 2, 0, 2024, 1, 14, 0, '2024-01-14 13:00:00'),
(12, 4, '2024-01-18', 3, 4, 2024, 1, 18, 0, '2024-01-18 14:00:00'),
(13, 5, '2024-01-12', 2, 5, 2024, 1, 12, 1, '2024-01-12 10:00:00'),
(14, 5, '2024-01-16', 3, 2, 2024, 1, 16, 0, '2024-01-16 11:00:00'),
(15, 5, '2024-01-19', 3, 5, 2024, 1, 19, 0, '2024-01-19 12:00:00'),
(16, 6, '2024-01-13', 2, 6, 2024, 1, 13, 1, '2024-01-13 11:00:00'),
(17, 6, '2024-01-17', 3, 3, 2024, 1, 17, 0, '2024-01-17 12:00:00'),
(18, 7, '2024-01-14', 2, 0, 2024, 1, 14, 1, '2024-01-14 12:00:00'),
(19, 7, '2024-01-18', 3, 4, 2024, 1, 18, 0, '2024-01-18 13:00:00'),
(20, 7, '2024-01-22', 4, 1, 2024, 1, 22, 0, '2024-01-22 14:00:00'),
(21, 8, '2024-01-15', 3, 1, 2024, 1, 15, 1, '2024-01-15 13:00:00'),
(22, 8, '2024-01-20', 3, 6, 2024, 1, 20, 0, '2024-01-20 14:00:00'),
(23, 9, '2024-01-16', 3, 2, 2024, 1, 16, 1, '2024-01-16 14:00:00'),
(24, 10, '2024-01-17', 3, 3, 2024, 1, 17, 1, '2024-01-17 15:00:00'),
(25, 10, '2024-01-21', 4, 0, 2024, 1, 21, 0, '2024-01-21 16:00:00'),
(26, 11, '2024-01-18', 3, 4, 2024, 1, 18, 1, '2024-01-18 16:00:00'),
(27, 11, '2024-01-22', 4, 1, 2024, 1, 22, 0, '2024-01-22 17:00:00'),
(28, 12, '2024-01-19', 3, 5, 2024, 1, 19, 1, '2024-01-19 17:00:00'),
(29, 12, '2024-01-23', 4, 2, 2024, 1, 23, 0, '2024-01-23 18:00:00'),
(30, 13, '2024-01-20', 3, 6, 2024, 1, 20, 1, '2024-01-20 18:00:00'),
(31, 13, '2024-01-24', 4, 3, 2024, 1, 24, 0, '2024-01-24 19:00:00'),
(32, 14, '2024-01-21', 4, 0, 2024, 1, 21, 1, '2024-01-21 19:00:00'),
(33, 15, '2024-01-22', 4, 1, 2024, 1, 22, 1, '2024-01-22 20:00:00'),
(34, 15, '2024-01-26', 4, 5, 2024, 1, 26, 0, '2024-01-26 21:00:00'),
(35, 16, '2024-01-23', 4, 2, 2024, 1, 23, 1, '2024-01-23 21:00:00'),
(36, 16, '2024-01-27', 4, 6, 2024, 1, 27, 0, '2024-01-27 22:00:00'),
(37, 17, '2024-01-24', 4, 3, 2024, 1, 24, 1, '2024-01-24 22:00:00'),
(38, 17, '2024-01-28', 5, 0, 2024, 1, 28, 0, '2024-01-28 23:00:00'),
(39, 18, '2024-01-25', 4, 4, 2024, 1, 25, 1, '2024-01-25 23:00:00'),
(40, 19, '2024-01-26', 4, 5, 2024, 1, 26, 1, '2024-01-26 10:00:00'),
(41, 19, '2024-01-30', 5, 2, 2024, 1, 30, 0, '2024-01-30 11:00:00'),
(42, 20, '2024-01-27', 4, 6, 2024, 1, 27, 1, '2024-01-27 11:00:00');

-- ==========================================
-- 13. 방문 상세 샘플 데이터 삽입
-- ==========================================
INSERT INTO visit_details (visit_id, path_name, visit_count) VALUES 
(1, '/home', 3),
(1, '/products', 2),
(2, '/home', 5),
(2, '/about', 1),
(3, '/products', 4),
(3, '/contact', 2),
(4, '/home', 6),
(4, '/products', 3),
(5, '/home', 2),
(6, '/products', 4),
(6, '/home', 2),
-- 추가 방문 상세 데이터
(7, '/home', 4),
(7, '/products', 3),
(8, '/about', 2),
(9, '/products', 5),
(10, '/home', 3),
(11, '/home', 4),
(11, '/products', 2),
(12, '/contact', 1),
(13, '/home', 6),
(13, '/products', 4),
(14, '/home', 3),
(15, '/products', 5),
(16, '/home', 4),
(17, '/about', 2),
(18, '/home', 5),
(18, '/products', 3),
(19, '/home', 4),
(20, '/products', 6),
(21, '/home', 3),
(21, '/products', 2),
(22, '/about', 1),
(23, '/home', 4),
(24, '/products', 5),
(25, '/home', 3),
(26, '/home', 6),
(26, '/products', 4),
(27, '/contact', 2),
(28, '/home', 4),
(29, '/products', 5),
(30, '/home', 3),
(31, '/about', 2),
(32, '/home', 4),
(33, '/products', 6),
(34, '/home', 3),
(35, '/home', 5),
(35, '/products', 3),
(36, '/about', 1),
(37, '/home', 4),
(38, '/products', 5),
(39, '/home', 3),
(40, '/home', 6),
(40, '/products', 4),
(41, '/contact', 2),
(42, '/home', 4);

-- ==========================================
-- 14. 회원가입 로그 샘플 데이터 삽입
-- ==========================================
INSERT INTO user_registration_log (visit_id, created_at) VALUES 
(1, '2024-01-10 09:00:00'), -- Alice 첫 방문
(3, '2024-01-10 14:20:00'), -- Bob 첫 방문
(5, '2024-01-10 11:15:00'), -- Charlie 첫 방문
(6, '2024-01-11 13:30:00'), -- Diana 첫 방문
(13, '2024-01-12 10:00:00'), -- Eve 첫 방문
(16, '2024-01-13 11:00:00'), -- Frank 첫 방문
(18, '2024-01-14 12:00:00'), -- Grace 첫 방문
(21, '2024-01-15 13:00:00'), -- Henry 첫 방문
(23, '2024-01-16 14:00:00'), -- Ivy 첫 방문
(24, '2024-01-17 15:00:00'), -- Jack 첫 방문
(26, '2024-01-18 16:00:00'), -- Kate 첫 방문
(28, '2024-01-19 17:00:00'), -- Leo 첫 방문
(30, '2024-01-20 18:00:00'), -- Mia 첫 방문
(32, '2024-01-21 19:00:00'), -- Noah 첫 방문
(33, '2024-01-22 20:00:00'), -- Olivia 첫 방문
(35, '2024-01-23 21:00:00'), -- Paul 첫 방문
(37, '2024-01-24 22:00:00'), -- Quinn 첫 방문
(39, '2024-01-25 23:00:00'), -- Ryan 첫 방문
(40, '2024-01-26 10:00:00'), -- Sophia 첫 방문
(42, '2024-01-27 11:00:00'); -- Tom 첫 방문

-- ==========================================
-- 15. 방문 세션 샘플 데이터 삽입
-- ==========================================
INSERT INTO visit_sessions (visit_id, hour, minute, second, ip_address, browser_type, os_type, device_type, referral_type, search_channel_type, referral_path, created_at) VALUES 
(1, 9, 0, 0, '192.168.1.101', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-10 09:00:00'),
(2, 10, 30, 0, '192.168.1.101', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/home', '2024-01-11 10:30:00'),
(3, 14, 20, 0, '192.168.1.102', 'Safari', 'macOS', 'Desktop', '검색채널', '구글', '/search?q=example', '2024-01-10 14:20:00'),
(4, 16, 45, 0, '192.168.1.102', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/products', '2024-01-12 16:45:00'),
(5, 11, 15, 0, '192.168.1.103', 'Edge', 'Windows', 'Desktop', 'SNS', NULL, '/twitter/share', '2024-01-10 11:15:00'),
(6, 13, 30, 0, '10.0.0.5', 'Safari', 'iOS', 'Mobile', '검색채널', '네이버', '/search?q=test', '2024-01-11 13:30:00'),
-- 추가 방문 세션 데이터
(7, 9, 0, 0, '192.168.1.101', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-15 09:00:00'),
(8, 10, 0, 0, '192.168.1.101', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/about', '2024-01-20 10:00:00'),
(9, 14, 0, 0, '192.168.1.102', 'Safari', 'macOS', 'Desktop', '검색채널', '구글', '/search', '2024-01-13 14:00:00'),
(10, 15, 0, 0, '192.168.1.102', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-17 15:00:00'),
(11, 13, 0, 0, '10.0.0.5', 'Safari', 'iOS', 'Mobile', '검색채널', '네이버', '/search', '2024-01-14 13:00:00'),
(12, 14, 0, 0, '10.0.0.5', 'Safari', 'iOS', 'Mobile', '직접', NULL, '/', '2024-01-18 14:00:00'),
(13, 10, 0, 0, '192.168.1.104', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-12 10:00:00'),
(14, 11, 0, 0, '192.168.1.104', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-16 11:00:00'),
(15, 12, 0, 0, '192.168.1.104', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-19 12:00:00'),
(16, 11, 0, 0, '192.168.1.105', 'Edge', 'Windows', 'Desktop', '검색채널', '구글', '/search', '2024-01-13 11:00:00'),
(17, 12, 0, 0, '192.168.1.105', 'Edge', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-17 12:00:00'),
(18, 12, 0, 0, '192.168.1.106', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-14 12:00:00'),
(19, 13, 0, 0, '192.168.1.106', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-18 13:00:00'),
(20, 14, 0, 0, '192.168.1.106', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-22 14:00:00'),
(21, 13, 0, 0, '192.168.1.107', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-15 13:00:00'),
(22, 14, 0, 0, '192.168.1.107', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-20 14:00:00'),
(23, 14, 0, 0, '192.168.1.108', 'Firefox', 'Linux', 'Desktop', '직접', NULL, '/', '2024-01-16 14:00:00'),
(24, 15, 0, 0, '192.168.1.109', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-17 15:00:00'),
(25, 16, 0, 0, '192.168.1.109', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-21 16:00:00'),
(26, 16, 0, 0, '192.168.1.110', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-18 16:00:00'),
(27, 17, 0, 0, '192.168.1.110', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-22 17:00:00'),
(28, 17, 0, 0, '192.168.1.111', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-19 17:00:00'),
(29, 18, 0, 0, '192.168.1.111', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-23 18:00:00'),
(30, 18, 0, 0, '192.168.1.112', 'Edge', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-20 18:00:00'),
(31, 19, 0, 0, '192.168.1.112', 'Edge', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-24 19:00:00'),
(32, 19, 0, 0, '10.0.0.6', 'Safari', 'iOS', 'Mobile', '직접', NULL, '/', '2024-01-21 19:00:00'),
(33, 20, 0, 0, '192.168.1.113', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-22 20:00:00'),
(34, 21, 0, 0, '192.168.1.113', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-26 21:00:00'),
(35, 21, 0, 0, '192.168.1.114', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-23 21:00:00'),
(36, 22, 0, 0, '192.168.1.114', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-27 22:00:00'),
(37, 22, 0, 0, '192.168.1.115', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-24 22:00:00'),
(38, 23, 0, 0, '192.168.1.115', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-28 23:00:00'),
(39, 23, 0, 0, '192.168.1.116', 'Firefox', 'Linux', 'Desktop', '직접', NULL, '/', '2024-01-25 23:00:00'),
(40, 10, 0, 0, '192.168.1.117', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-26 10:00:00'),
(41, 11, 0, 0, '192.168.1.117', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/', '2024-01-30 11:00:00'),
(42, 11, 0, 0, '10.0.0.7', 'Safari', 'iOS', 'Mobile', '직접', NULL, '/', '2024-01-27 11:00:00');

-- ==========================================
-- 💡 학습 가이드
-- ==========================================
-- 이 데이터로 연습할 수 있는 것들:
--
-- 1. SELECT 기초
--    - 특정 컬럼 조회
--    - 모든 컬럼 조회
--
-- 2. ORDER BY
--    - 가격순 정렬
--    - 다중 정렬 (가격 → 카테고리)
--    - 근무기간순 정렬
--
-- 3. WHERE (비교 연산자)
--    - 특정 카테고리 필터링
--    - 가격 범위 조회
--    - BETWEEN 사용
--
-- 4. WHERE (복합 조건)
--    - AND, OR 조합
--    - NOT 사용
--    - 괄호로 우선순위 지정
--
-- 5. IN 연산자
--    - 여러 카테고리 동시 조회
--    - NOT IN으로 제외
--
-- 6. LIKE 패턴 검색
--    - '소파' 포함 상품
--    - 'Green'으로 시작하는 상품
--    - '_소파_' 패턴
--
-- 7. 응용 문제
--    - 재고 20 이하 상품
--    - 가격 3000 미만 또는 6000 초과
--    - 복합 조건 조합
--
-- 8. JOIN 연습
--    - users와 visits 조인
--    - visits와 visit_details 조인
--    - 다중 테이블 조인
--
-- 9. GROUP BY 연습
--    - 사용자별 방문 횟수 집계
--    - 날짜별 방문 통계
--    - 경로별 방문 통계
-- ==========================================