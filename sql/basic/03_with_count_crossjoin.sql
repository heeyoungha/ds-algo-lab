-- ==========================================
-- 🧭 03_with_count_crossjoin.sql
-- ==========================================
-- 🎯 목적: WITH 절, COUNT, CROSS JOIN 마스터
-- 📊 테이블: users, visits, products, employees
-- 📌 핵심: 가독성 향상 → 집계 함수 → 조합 생성
-- ==========================================

-- ==========================================
-- 🧩 개념 구조
-- ==========================================
-- 1️⃣ WITH 절 (CTE) - 복잡한 쿼리를 단계별로 나누기
-- 2️⃣ COUNT - 행 개수 집계
-- 3️⃣ CROSS JOIN - 모든 조합 생성
-- ==========================================

-- ==========================================
-- 📊 Level 1: COUNT 기초
-- ==========================================

-- 🔸 COUNT(*): 모든 행 개수 (NULL 포함)
SELECT COUNT(*) AS total_users
FROM users;

-- 결과값 >> 
-- --------------------
-- total_users
-- --------------------
-- 22
-- --------------------

-- 🔸 COUNT(컬럼): NULL 제외한 행 개수
SELECT COUNT(name) AS users_with_name
FROM users;

-- 결과값 >> 
-- --------------------
-- users_with_name
-- --------------------
-- 20
-- --------------------

-- 🔸 COUNT(DISTINCT 컬럼): 중복 제거한 개수
SELECT COUNT(DISTINCT user_type) AS distinct_user_types
FROM users;

-- 결과값 >> 
-- --------------------
-- distinct_user_types
-- --------------------
-- 4
-- --------------------

-- 🔸 COUNT와 GROUP BY 조합
SELECT 
    user_type,
    COUNT(*) AS user_count
FROM users
GROUP BY user_type;

-- 결과값 >> 
-- --------------------
-- user_type | user_count
-- --------------------
-- NULL      | 0
-- premium   | 5
-- regular   | 10
-- vip       | 5
-- --------------------

-- 💡 핵심: COUNT는 "몇 개?"를 세는 함수
-- 💡 COUNT(*): 모든 행
-- 💡 COUNT(컬럼): NULL 제외
-- 💡 COUNT(DISTINCT 컬럼): 중복 제거


-- ==========================================
-- 📊 Level 2: COUNT 응용
-- ==========================================

-- 🔸 조건부 COUNT: CASE WHEN 사용
SELECT 
    user_type,
    COUNT(*) AS total_count,
    COUNT(CASE WHEN status = 'active' THEN 1 END) AS active_count,
    COUNT(CASE WHEN status = 'inactive' THEN 1 END) AS inactive_count
FROM users
GROUP BY user_type;

-- 결과값 >> 
-- --------------------
-- user_type | total_count | active_count | inactive_count
-- --------------------
-- premium   | 5           | 5           | 0
-- regular   | 10          | 7           | 3
-- vip       | 5           | 5           | 0
-- --------------------

-- 🔸 날짜별 방문자 수
SELECT 
    visit_date,
    COUNT(*) AS visit_count
FROM visits
GROUP BY visit_date
ORDER BY visit_date;

-- 결과값 >> 
-- --------------------
-- visit_date  | visit_count
-- --------------------
-- 2024-01-10  | 3
-- 2024-01-11  | 2
-- 2024-01-12  | 2
-- 2024-01-13  | 2
-- 2024-01-14  | 2
-- 2024-01-15  | 2
-- 2024-01-16  | 2
-- 2024-01-17  | 2
-- 2024-01-18  | 2
-- 2024-01-19  | 2
-- 2024-01-20  | 2
-- 2024-01-21  | 2
-- 2024-01-22  | 2
-- 2024-01-23  | 2
-- 2024-01-24  | 2
-- 2024-01-25  | 1
-- 2024-01-26  | 2
-- 2024-01-27  | 2
-- 2024-01-28  | 1
-- 2024-01-30  | 1
-- --------------------

-- 🔸 회원 유형별 평균 방문 횟수
SELECT 
    u.user_type,
    COUNT(DISTINCT v.id) AS total_visits, -- 방문한 세션 수
    COUNT(vd.id) AS total_path_visits,    -- 방문한 경로 수
    sum(vd.visit_count) AS total_page_view, -- 총 페이지 뷰 수
    COUNT(DISTINCT v.user_id) AS unique_visitors    -- 중복 제거한 사용자 수 = 고유 방문자 수
FROM users u
LEFT JOIN visits v ON v.user_id = u.id
LEFT JOIN visit_details vd ON vd.visit_id = v.id
GROUP BY u.user_type;

-- 결과값 >> 
-- --------------------
-- user_type | total_visits | total_path_visits | total_page_view | unique_visitors
-- --------------------
-- premium   | 11           | 57               | 125             | 5
-- regular   | 19           | 38               | 76              | 10
-- vip       | 11           | 22               | 44              | 5
-- --------------------

-- 💡 핵심: COUNT는 집계 함수이므로 GROUP BY와 함께 사용
-- 💡 CASE WHEN으로 조건부 집계 가능

