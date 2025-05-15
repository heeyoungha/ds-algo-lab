-- visits 테이블 (방문 로그)
CREATE TABLE visits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    visit_date DATE DEFAULT (date('now')),
    week INTEGER DEFAULT 0, -- 주 (1-52)
    day_of_week INTEGER DEFAULT 0, -- 요일 (0-6, 일요일=0)
    year INTEGER DEFAULT 0, -- 년도
    month INTEGER DEFAULT 0, -- 월 (1-12)
    day INTEGER DEFAULT 0, -- 일 (1-31)
    is_first_visit INTEGER DEFAULT 0, -- 최초방문여부 (0: 아니오, 1: 예)
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

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

-- users 테이블 (사용자 정보)
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    status VARCHAR(10), -- 'active', 'inactive'
    user_type VARCHAR(20), -- 회원 유형 (예: 'regular', 'premium', 'vip')
    join_date DATE,
    first_login_at DATETIME -- 첫 로그인 일시
);

-- users 테이블 인덱스
CREATE INDEX idx_users_user_type ON users(user_type);
CREATE INDEX idx_users_first_login ON users(first_login_at);

-- visit_details 테이블 (방문 상세 정보 - 경로별 방문 통계)
CREATE TABLE visit_details (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    visit_id INTEGER NOT NULL,
    path_name VARCHAR(255) DEFAULT '/', -- 경로명 (새탭 내 이동경로)
    visit_count INTEGER DEFAULT 0, -- 방문횟수
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (visit_id) REFERENCES visits(id) ON DELETE CASCADE
);

-- visit_details 테이블 인덱스 및 제약
CREATE UNIQUE INDEX visit_details_visit_path_unique ON visit_details(visit_id, path_name);
CREATE INDEX idx_visit_details_visit_id ON visit_details(visit_id);
CREATE INDEX idx_visit_details_path ON visit_details(path_name);

-- user_registration_log 테이블 (누적회원수 추적)
CREATE TABLE user_registration_log (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    visit_id INTEGER NOT NULL DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (visit_id) REFERENCES visits(id) ON DELETE CASCADE
);

-- user_registration_log 테이블 인덱스
CREATE INDEX idx_user_registration_visit_id ON user_registration_log(visit_id);

-- visit_sessions 테이블 (접속환경 트래킹)
CREATE TABLE visit_sessions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    visit_id INTEGER NOT NULL,
    hour INTEGER DEFAULT 0, -- 시 (0-23)
    minute INTEGER DEFAULT 0, -- 분 (0-59)
    second INTEGER DEFAULT 0, -- 초 (0-59)
    ip_address VARCHAR(20), -- IP 주소
    browser_type VARCHAR(20), -- 브라우저 유형
    os_type VARCHAR(20), -- OS 유형
    device_type VARCHAR(20), -- 기기 유형
    referral_type VARCHAR(100), -- 유입타입 (직접, 검색채널, 기타, SNS 등)
    search_channel_type VARCHAR(100), -- 검색채널 유형 (네이버, 구글, 다음 등)
    referral_path VARCHAR(50), -- 유입 경로
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (visit_id) REFERENCES visits(id) ON DELETE CASCADE
);

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

-- ===========================================
-- 2단계: 샘플 데이터 삽입
-- ===========================================

INSERT INTO users (id, name, status, user_type, join_date, first_login_at) VALUES 
(1, 'Alice', 'active', 'premium', '2024-01-01', '2024-01-10 09:00:00'),
(2, 'Bob', 'active', 'regular', '2024-01-15', '2024-01-10 14:20:00'),
(3, 'Charlie', 'inactive', 'regular', '2024-02-01', '2024-01-10 11:15:00'),
(4, 'Diana', 'active', 'vip', '2024-02-15', '2024-01-11 13:30:00');

INSERT INTO visits (id, user_id, visit_date, week, day_of_week, year, month, day, is_first_visit, created_at) VALUES 
(1, 1, '2024-01-10', 2, 3, 2024, 1, 10, 1, '2024-01-10 09:00:00'),
(2, 1, '2024-01-11', 2, 4, 2024, 1, 11, 0, '2024-01-11 10:30:00'),
(3, 2, '2024-01-10', 2, 3, 2024, 1, 10, 1, '2024-01-10 14:20:00'),
(4, 2, '2024-01-12', 2, 5, 2024, 1, 12, 0, '2024-01-12 16:45:00'),
(5, 3, '2024-01-10', 2, 3, 2024, 1, 10, 1, '2024-01-10 11:15:00'),
(6, 4, '2024-01-11', 2, 4, 2024, 1, 11, 1, '2024-01-11 13:30:00');

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
(6, '/home', 2);

-- user_registration_log 테이블 샘플 데이터 (첫 방문인 경우만)
INSERT INTO user_registration_log (visit_id, created_at) VALUES 
(1, '2024-01-10 09:00:00'), -- Alice 첫 방문
(3, '2024-01-10 14:20:00'), -- Bob 첫 방문
(5, '2024-01-10 11:15:00'), -- Charlie 첫 방문
(6, '2024-01-11 13:30:00'); -- Diana 첫 방문

-- visit_sessions 테이블 샘플 데이터 (각 방문에 대한 접속환경 정보)
INSERT INTO visit_sessions (visit_id, hour, minute, second, ip_address, browser_type, os_type, device_type, referral_type, search_channel_type, referral_path, created_at) VALUES 
(1, 9, 0, 0, '192.168.1.101', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/', '2024-01-10 09:00:00'),
(2, 10, 30, 0, '192.168.1.101', 'Chrome', 'Windows', 'Desktop', '직접', NULL, '/home', '2024-01-11 10:30:00'),
(3, 14, 20, 0, '192.168.1.102', 'Safari', 'macOS', 'Desktop', '검색채널', '구글', '/search?q=example', '2024-01-10 14:20:00'),
(4, 16, 45, 0, '192.168.1.102', 'Safari', 'macOS', 'Desktop', '직접', NULL, '/products', '2024-01-12 16:45:00'),
(5, 11, 15, 0, '192.168.1.103', 'Edge', 'Windows', 'Desktop', 'SNS', NULL, '/twitter/share', '2024-01-10 11:15:00'),
(6, 13, 30, 0, '10.0.0.5', 'Safari', 'iOS', 'Mobile', '검색채널', '네이버', '/search?q=test', '2024-01-11 13:30:00');
