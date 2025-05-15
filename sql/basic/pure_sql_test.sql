-- 순수 SQL 테스트 파일
-- 이 파일은 PHP 없이 직접 SQL 데이터베이스에서 실행할 수 있는 쿼리들을 포함합니다
-- 실행: sqlite3 test_database.db < pure_sql_test.sql
-- 또는: sqlite3 test_database.db -cmd ".read pure_sql_test.sql"

-- SQLite 출력 형식 설정 (터미널에서 표로 표시)
.mode box
.headers on
.width 15 8 15 10 15

-- ===========================================
-- 1. 활성 "사용자" 목록 조회 : 단순 WHERE + 바인딩
-- ===========================================
.print '=== 1. 활성 사용자 목록 (status = ''active'') ==='
SELECT * FROM users WHERE status = 'active';

.print '\n'


-- ===========================================
-- 2. 특정 날짜 범위 "방문" 조회 : BETWEEN + 바인딩
-- ===========================================
.print '\n=== 2. 특정 날짜 범위 방문 조회 (2024-01-10 ~ 2024-01-11) ==='
SELECT * FROM visits 
WHERE visit_date BETWEEN '2024-01-10' AND '2024-01-11';

.print '\n'


-- ===========================================
-- 3. 활성 사용자 특정 기간 "방문" 조회 : JOIN + 다중 파라미터 바인딩
-- ===========================================
.print '\n=== 3. 활성 사용자 방문 조회 (JOIN 결과) ==='

SELECT * FROM visits v 
JOIN users u ON u.id = v.user_id 
WHERE u.status = 'active'
    AND v.visit_date BETWEEN '2024-01-10' AND '2024-01-11'
ORDER BY v.visit_date DESC;

.print '\n'


-- ===========================================
-- 사용자별 일자별 방문 경로 수와 총 방문 횟수 합계 : GROUP BY + 바인딩
-- visits, visit_details, users 테이블을 조인하여 active 사용자만 집계한다.

-- 📘 개념 요약
-- 1️⃣ COUNT(*)           : 경로(visit_details 행) 개수 = 방문한 페이지 종류 수
-- 2️⃣ SUM(visit_count)   : 해당 페이지별 실제 방문 횟수의 합
-- 3️⃣ GROUP BY (날짜, 사용자)
-- 4️⃣ WHERE (active 상태 + 날짜 범위)
-- ===========================================
.print '\n=== 4. 날짜별 방문자별 방문내역 종류갯수 및 총 방문내역 횟수 합계 ==='

SELECT v.visit_date,
       u.id as user_id,
       u.name as user_name,
       COUNT(*) as visit_count,
       SUM(d.visit_count) as total_visit_count 
FROM visits v 
JOIN visit_details d ON d.visit_id = v.id
JOIN users u ON u.id = v.user_id
WHERE u.status = 'active'
    AND v.visit_date BETWEEN '2024-01-10' AND '2024-01-11'
GROUP BY v.visit_date, u.id
ORDER BY v.visit_date DESC, u.name;

.print '\n'

.print '\n=== 5. 결과 해석 (예시) ==='
.print '\n 2024-01-10 | user_id=1 (Alice)'
.print '  visit_count       = 2  (2개의 경로 방문)'
.print '  total_visit_count = 5  (각 경로 방문횟수 합)'
.print '\n'