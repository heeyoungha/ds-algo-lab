-- ==========================================
-- 🧭 02_pure_sql_test.sql
-- ==========================================
-- 🎯 목적: WHERE, JOIN, GROUP BY 실전 연습
-- 📊 테이블: users, visits, visit_details
-- 📌 핵심: 필터링 → 조인 → 집계
-- ==========================================

-- ==========================================
-- 📋 SQL 쿼리 실행 순서 (목차)
-- ==========================================
-- | 단계  | 절                     | 주요 역할                    | 관련 키워드                                              |
-- | --- | --------------------- | ------------------------ | --------------------------------------------------- |
-- | 1️⃣ | **SELECT**            | 어떤 데이터를 볼 것인가 (출력 컬럼 선택) | `SELECT`, `DISTINCT`, `AS`, `COUNT()`, `SUM()`      |
-- | 2️⃣ | **FROM / JOIN**       | 어디서 가져올 것인가 (데이터 원천 정의)  | `FROM`, `JOIN`, `ON`, `LEFT JOIN`, `INNER JOIN`     |
-- | 3️⃣ | **WHERE**             | 어떤 행만 볼 것인가 (조건 필터링)     | `=`, `!=`, `>`, `<`, `BETWEEN`, `IN`, `LIKE`, `NOT` |
-- | 4️⃣ | **GROUP BY / HAVING** | 어떤 기준으로 묶을 것인가           | `GROUP BY`, `HAVING`, `COUNT`, `SUM`                |
-- | 5️⃣ | **ORDER BY / LIMIT**  | 어떤 순서로 보여줄 것인가           | `ORDER BY`, `ASC`, `DESC`, `LIMIT`                  |
-- ==========================================

-- ==========================================
-- 🧩 개념 구조
-- ==========================================
-- 1️⃣ WHERE (필터링) - 어떤 조건의 행만 볼 것인가?
-- 2️⃣ BETWEEN (범위 조건) - 범위 내의 값만
-- 3️⃣ JOIN (조인) - 두 테이블을 연결
-- 4️⃣ GROUP BY (집계) - 그룹별 통계 계산
-- ==========================================

-- ==========================================
-- 📊 Level 1: WHERE (필터링) - 단순 조건
-- ==========================================

-- 🔸 특정 값과 일치하는 행만
SELECT * 
FROM users 
WHERE status = 'active';

-- 🔸 다른 값과 일치하는 행
SELECT * 
FROM users 
WHERE status = 'inactive';

-- 💡 핵심: WHERE는 "어떤 조건의 행만 볼까?" 결정
-- 💡 문자는 작은따옴표 ' ' 필수


-- ==========================================
-- 📊 Level 2: WHERE (필터링) - 범위 조건 (BETWEEN)
-- ==========================================

-- 🔸 특정 날짜 범위 방문 조회
SELECT * 
FROM visits 
WHERE visit_date BETWEEN '2024-01-10' AND '2024-01-11';

-- 🔸 BETWEEN은 다음과 동일
SELECT * 
FROM visits 
WHERE visit_date >= '2024-01-10' 
  AND visit_date <= '2024-01-11';

-- 💡 핵심: BETWEEN은 "범위 내의 값"을 의미
-- 💡 BETWEEN A AND B: A 이상 B 이하 (양쪽 포함)
-- 💡 날짜 형식: 'YYYY-MM-DD'


-- ==========================================
-- 📊 Level 3: JOIN (두 테이블 연결)
-- ==========================================

-- 🔸 두 테이블 연결하기
SELECT * 
FROM visits v 
JOIN users u ON u.id = v.user_id;

-- 🔸 조인 후 조건 필터링
SELECT * 
FROM visits v 
JOIN users u ON u.id = v.user_id 
WHERE u.status = 'active';

-- 🔸 조인 + 필터링 + 정렬
SELECT * 
FROM visits v 
JOIN users u ON u.id = v.user_id 
WHERE u.status = 'active'
  AND v.visit_date BETWEEN '2024-01-10' AND '2024-01-11'
ORDER BY v.visit_date DESC;

-- 💡 핵심: JOIN은 "두 테이블을 연결"하는 것
-- 💡 ON 절: 두 테이블을 연결하는 조건
-- 💡 v, u는 테이블 별칭(alias) - 긴 테이블명을 짧게 사용


-- ==========================================
-- 📊 Level 4: 다중 JOIN (여러 테이블 연결)
-- ==========================================

-- 🔸 세 개 테이블 연결
SELECT * 
FROM visits v 
JOIN visit_details d ON d.visit_id = v.id
JOIN users u ON u.id = v.user_id;

-- 🔸 조인 후 필터링
SELECT * 
FROM visits v 
JOIN visit_details d ON d.visit_id = v.id
JOIN users u ON u.id = v.user_id
WHERE u.status = 'active'
  AND v.visit_date BETWEEN '2024-01-10' AND '2024-01-11';

-- 💡 핵심: 여러 테이블을 순차적으로 연결 가능
-- 💡 JOIN은 여러 개 사용 가능


-- ==========================================
-- 📊 Level 5: GROUP BY (집계)
-- ==========================================

-- 🔸 사용자별 방문 횟수 집계
SELECT 
    u.id,
    u.name,
    COUNT(*) AS visit_count
FROM users u
JOIN visits v ON v.user_id = u.id
GROUP BY u.id, u.name;

-- 🔸 사용자별 일자별 방문 경로 수와 총 방문 횟수 합계
SELECT 
    v.visit_date,
    u.id AS user_id,
    u.name AS user_name,
    COUNT(*) AS visit_path_count,        -- 방문한 경로 종류 수
    SUM(d.visit_count) AS total_visits    -- 총 방문 횟수 합계
FROM visits v 
JOIN visit_details d ON d.visit_id = v.id
JOIN users u ON u.id = v.user_id
WHERE u.status = 'active'
  AND v.visit_date BETWEEN '2024-01-10' AND '2024-01-11'
GROUP BY v.visit_date, u.id
ORDER BY v.visit_date DESC, u.name;

-- 💡 핵심: GROUP BY는 "같은 그룹끼리 묶어서 집계"
-- 💡 COUNT(*): 그룹 내 행 개수
-- 💡 SUM(컬럼): 해당 컬럼 값의 합계
-- 💡 GROUP BY에 있는 컬럼만 SELECT에 사용 가능 (집계 함수 제외)


-- ==========================================
-- 🎯 종합 연습문제
-- ==========================================

-- Q1. 비활성 사용자의 방문 목록을 날짜순으로
SELECT v.*, u.name AS user_name
FROM visits v
JOIN users u ON u.id = v.user_id
WHERE u.status = 'inactive'
ORDER BY v.visit_date ASC;

-- Q2. 2024-01-10에 방문한 사용자들의 이름과 방문 시간
SELECT 
    u.name,
    v.visit_date,
    vs.hour,
    vs.minute
FROM visits v
JOIN users u ON u.id = v.user_id
JOIN visit_sessions vs ON vs.visit_id = v.id
WHERE v.visit_date = '2024-01-10'
ORDER BY vs.hour, vs.minute;

-- Q3. 각 사용자별 총 방문 횟수 (visit_details의 visit_count 합계)
SELECT 
    u.id,
    u.name,
    SUM(d.visit_count) AS total_visit_count
FROM users u
JOIN visits v ON v.user_id = u.id
JOIN visit_details d ON d.visit_id = v.id
GROUP BY u.id, u.name
ORDER BY total_visit_count DESC;

-- Q4. premium 또는 vip 사용자의 방문 정보
SELECT 
    u.name,
    u.user_type,
    v.visit_date,
    COUNT(d.id) AS path_count
FROM users u
JOIN visits v ON v.user_id = u.id
LEFT JOIN visit_details d ON d.visit_id = v.id
WHERE u.user_type IN ('premium', 'vip')
GROUP BY u.id, u.name, u.user_type, v.visit_date
ORDER BY v.visit_date DESC;


-- ==========================================
-- 💡 학습 포인트 정리
-- ==========================================
-- ✅ WHERE: 행 필터링 (어떤 조건)
-- ✅ BETWEEN: 범위 조건 (A 이상 B 이하)
-- ✅ JOIN: 테이블 연결 (ON 조건으로 연결)
-- ✅ GROUP BY: 그룹별 집계 (COUNT, SUM 등)
-- ✅ ORDER BY: 정렬 (어떤 순서로)
--
-- ✅ JOIN 종류:
--    - INNER JOIN (JOIN): 양쪽 모두 있는 데이터만
--    - LEFT JOIN: 왼쪽 테이블 기준 (없어도 표시)
--    - RIGHT JOIN: 오른쪽 테이블 기준
--
-- ✅ 집계 함수:
--    - COUNT(*): 행 개수
--    - SUM(컬럼): 합계
--    - AVG(컬럼): 평균
--    - MAX(컬럼): 최대값
--    - MIN(컬럼): 최소값
--
-- ✅ GROUP BY 주의사항:
--    - SELECT에 집계 함수가 있으면 GROUP BY 필수
--    - GROUP BY에 없는 컬럼은 SELECT에 올 수 없음 (집계 함수 제외)
-- ==========================================

-- ==========================================
-- 🔄 응용 변형
-- ==========================================
-- 1️⃣ 날짜별 방문자 수: GROUP BY visit_date
-- 2️⃣ 사용자별 평균 방문 횟수: AVG(visit_count)
-- 3️⃣ 최다 방문 경로: ORDER BY SUM(visit_count) DESC LIMIT 1
-- 4️⃣ 복합 조건: WHERE + JOIN + GROUP BY 조합
-- ==========================================
