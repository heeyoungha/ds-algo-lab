# nginx 로그 분석 

## 목표
- 로그 읽는 눈 (패턴·형식·구조 인식)
- 텍스트 도구 능숙 사용 (grep, awk, sed, gawk)
- 필터링 → 집계 → 원인 추정 능력
- 실제 장애 대응에 필요한 분석 순서 이해

---

# Step 0: 로그 파일 생성

```
cd set_up

# Access 로그 생성
./generate_nginx_log.sh
>> 생성 파일: nginx_today.log

# Error 로그 생성  
./generate_nginx_error_log.sh
>> 생성 파일: nginx_error.log

# 파일 존재 확인
ls -lh nginx_today.log nginx_error.log

# 전체 라인 수 확인
wc -l nginx_*.log
```
✅ 체크포인트: 두 개의 로그 파일이 정상적으로 생성

# Stage 1: 기초 - 로그 구조 이해

## 목표
- nginx 로그의 구조와 각 필드의 의미를 이해한다
- 기본 리눅스 명령어로 로그를 읽고 탐색할 수 있다

## 필수 개념
- nginx Access 로그 형식
  - IP - - [일/월/년:시:분:초 타임존] "HTTP메서드 URL 프로토콜" 상태코드 응답크기 "리퍼러" "User-Agent"
  - 192.168.1.100 - - [12/Sep/2025:07:15:32 +0000] "GET /index.html HTTP/1.1" 200 5432 "-" "Mozilla/5.0..."
- nginx Error 로그 형식
  - 날짜 시간 [레벨] PID#TID: *연결번호 에러메시지, 추가정보
  - 2025/11/01 10:15:01 [error] 1245#1245: *1021 client prematurely closed connection

## 실습 1-1: 로그 파일 기본 탐색
cd set_up

```
# 📝 첫 5줄 보기
head -n 5 nginx_today.log

# 📝 마지막 5줄 보기
tail -n 5 nginx_today.log

# 📝 전체 라인 수 세기 
- word count (단어)
- 옵션 : -l (라인), -m (문자), -c (바이트)
wc -l nginx_today.log

# 📝 페이지 단위로 보기 (q로 종료)
less nginx_today.log
```

## 실습 1-2: 로그 필드 구분하기
cd set_up
```
# Access 로그에서 IP 주소만 보기 (첫 번째 필드)
head -n 10 nginx_today.log | cut -d' ' -f1

# Access 로그에서 HTTP 메서드만 보기
head -n 10 nginx_today.log | cut -d'"' -f2 | cut -d' ' -f1

# Access 로그에서 상태 코드만 보기
head -n 10 nginx_today.log | cut -d'"' -f3 | cut -d' ' -f2
```


## 연습 문제 1
1.	nginx_today.log의 첫 번째 로그 라인의 IP 주소는?
2.	nginx_error.log의 마지막 로그의 에러 레벨은?
3.	각 로그 파일의 총 라인 수는?


✅ 체크포인트:
  - [ ] 로그 형식의 각 필드를 구분할 수 있다
	- [ ] head, tail, less 명령어를 사용할 수 있다
	- [ ] cut 명령어로 특정 필드를 추출할 수 있다
