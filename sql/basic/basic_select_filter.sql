-- ==========================================
-- 🧭 01_basic_select_filter.sql
-- ==========================================
-- 🎯 목적: SELECT, ORDER BY, WHERE, LIKE 기본 문법 마스터
-- 📊 테이블: products, employees
-- 📌 핵심: 출력 → 정렬 → 필터링 → 패턴 검색
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
-- 1️⃣ SELECT (출력) - 어떤 컬럼을 볼 것인가?
-- 2️⃣ ORDER BY (정렬) - 어떤 순서로 볼 것인가?
-- 3️⃣ WHERE (필터링) - 어떤 조건의 행만 볼 것인가?
-- 4️⃣ LIKE (패턴 검색) - 문자열 패턴으로 검색
-- ==========================================

-- ==========================================
-- 📊 Level 1: SELECT (출력)
-- ==========================================

-- 🔸 특정 컬럼만 출력
SELECT product_name, price 
FROM products;

-- 🔸 모든 컬럼 출력
SELECT * 
FROM products;

-- 💡 핵심: SELECT는 "어떤 컬럼을 볼까?" 결정


-- ==========================================
-- 📊 Level 2: ORDER BY (정렬)
-- ==========================================

-- 🔸 가격 낮은 순 (오름차순 ASC - 기본값)
SELECT * 
FROM products 
ORDER BY price;  -- ASC 생략 가능

-- 🔸 다중 정렬: 가격 낮은 순 → 같으면 카테고리 가나다순
SELECT * 
FROM products 
ORDER BY price ASC, category ASC;

-- 💡 핵심: ORDER BY는 "어떤 순서로 볼까?" 결정
-- 💡 1차 정렬, 2차 정렬 순서대로 작성


-- ==========================================
-- 📊 Level 3: WHERE (필터링) - 비교 연산자
-- ==========================================

-- 🔸 특정 값과 일치하는 행만
SELECT * 
FROM products 
WHERE category = '가구';

-- 🔸 숫자 비교 (>, <, >=, <=, !=)
SELECT * 
FROM products 
WHERE price > 5000;

-- 🔸 문자도 비교 가능 (사전순)
SELECT * 
FROM products 
WHERE category > '가구';  -- '가구' 이후 문자들

-- 🔸 BETWEEN: 범위 조건
SELECT * 
FROM products 
WHERE price BETWEEN 5000 AND 8000;  -- 5000 이상 8000 이하

-- 💡 핵심: WHERE는 "어떤 조건의 행만 볼까?" 결정
-- 💡 문자는 작은따옴표 ' ' 필수


-- ==========================================
-- 📊 Level 4: WHERE (필터링) - 복합 조건
-- ==========================================

-- 🔸 AND: 모든 조건을 만족
SELECT * 
FROM products 
WHERE price > 5000 
  AND category = '가구';

-- 🔸 OR: 하나라도 만족
SELECT * 
FROM products 
WHERE category = '가구' 
   OR category = '옷';

-- 🔸 괄호로 우선순위 지정
SELECT * 
FROM products 
WHERE (category = '가구' OR category = '옷') 
  AND price = 5000;

-- 🔸 NOT: 조건 제외
SELECT * 
FROM products 
WHERE NOT price = 5000;

-- 또는
SELECT * 
FROM products 
WHERE price != 5000;

-- 💡 핵심: AND(그리고), OR(또는), NOT(제외)


-- ==========================================
-- 📊 Level 5: IN 연산자 (OR 간소화)
-- ==========================================

-- 🔸 OR가 반복될 때 사용
-- ❌ 비효율적
SELECT * 
FROM products 
WHERE category = '신발' 
   OR category = '가전' 
   OR category = '식품';

-- ✅ 간결하게
SELECT * 
FROM products 
WHERE category IN ('신발', '가전', '식품');

-- 🔸 NOT IN: 여러 값 제외
SELECT * 
FROM products 
WHERE product_name NOT IN ('셔츠', '반팔티', '운동화');

-- 💡 핵심: 같은 컬럼에 OR가 여러 개면 IN 사용


-- ==========================================
-- 📊 Level 6: LIKE (패턴 검색)
-- ==========================================

-- 🔹 와일드카드
-- % : 0개 이상의 문자 (아무거나)
-- _ : 정확히 1개의 문자

-- 🔸 '소파'가 포함된 모든 상품
SELECT * 
FROM products 
WHERE product_name LIKE '%소파%';

-- 🔸 '소파'로 끝나는 상품
SELECT * 
FROM products 
WHERE product_name LIKE '%소파';

-- 🔸 '소파'로 시작하는 상품
SELECT * 
FROM products 
WHERE product_name LIKE '소파%';

-- 🔸 'Green'으로 시작, 'chair'로 끝 (중간에 뭐든 가능)
SELECT * 
FROM products 
WHERE product_name LIKE 'Green%chair';

-- 🔸 공백 포함된 패턴
SELECT * 
FROM products 
WHERE product_name LIKE 'Green % chair';

-- 🔸 언더스코어(_): 정확히 1글자
-- X소파 또는 소파X 형태
SELECT * 
FROM products 
WHERE product_name LIKE '_소파_';

-- XX소파 또는 소파XX 형태
SELECT * 
FROM products 
WHERE product_name LIKE '__소파__';

-- 🔸 LIKE + OR 조합
SELECT * 
FROM products 
WHERE product_name LIKE '%소파%' 
   OR product_name LIKE '%chair%';

-- 🔸 LIKE + AND + NOT 조합
-- '소파'는 있지만 '나무'는 없는 상품
SELECT * 
FROM products 
WHERE product_name LIKE '%소파%' 
  AND NOT product_name LIKE '%나무%';

-- 💡 핵심: LIKE는 문자열 패턴 검색
-- 💡 %는 0개 이상, _는 정확히 1개
-- ⚠️ 주의: %로 시작하면 인덱스 사용 못해 느려질 수 있음


-- ==========================================
-- 🎯 종합 연습문제
-- ==========================================

-- Q1. 재고가 20 이하인 상품을 상품명 가나다순으로
SELECT * 
FROM products 
WHERE stock <= 20 
ORDER BY product_name ASC;

-- Q2. 가격이 3000원 미만이거나 6000원 초과인 상품
SELECT * 
FROM products 
WHERE price < 3000 
   OR price > 6000;

-- Q3. 카테고리가 '옷'이 아니면서 가격이 5000원인 상품
SELECT * 
FROM products 
WHERE category != '옷' 
  AND price = 5000;

-- Q4. 상품명이 '셔츠', '반팔티', '운동화'가 아닌 상품 🔴
SELECT * 
FROM products 
WHERE product_name NOT IN ('셔츠', '반팔티', '운동화');


-- ==========================================
-- 💡 학습 포인트 정리
-- ==========================================
-- ✅ SELECT: 컬럼 선택 (무엇을)
-- ✅ FROM: 테이블 지정 (어디서)
-- ✅ WHERE: 행 필터링 (어떤 조건)
-- ✅ ORDER BY: 정렬 (어떤 순서로)
--
-- ✅ 연산자 우선순위:
--    1. 괄호 ()
--    2. NOT
--    3. AND
--    4. OR
--
-- ✅ LIKE 성능:
--    - '%abc'  : 느림 (인덱스 X)
--    - 'abc%'  : 빠름 (인덱스 O)
--    - '%abc%' : 느림 (인덱스 X)
-- ==========================================

-- ==========================================
-- 🔄 응용 변형
-- ==========================================
-- 1️⃣ 가격대별 그룹: WHERE price BETWEEN 1000 AND 5000
-- 2️⃣ 복수 패턴: WHERE name LIKE '%A%' OR name LIKE '%B%'
-- 3️⃣ 제외 조건: WHERE NOT (조건1 OR 조건2)
-- ==========================================