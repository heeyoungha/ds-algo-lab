#!/bin/bash

# nginx 로그 파일 생성 통합 스크립트
# Access 로그와 Error 로그를 모두 생성합니다

ACCESS_LOG_FILE="nginx_today.log"
ERROR_LOG_FILE="nginx_error.log"

# 색상 정의
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}nginx 로그 파일 생성${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# ===========================================
# 1. Access 로그 생성
# ===========================================
echo -e "${YELLOW}[1/2] Access 로그 생성 중...${NC}"

# 로그 파일 초기화
> "$ACCESS_LOG_FILE"

# 다양한 IP 주소
IPS=("192.168.1.100" "10.0.0.50" "172.16.0.25" "192.168.1.101" "10.0.0.51")

# HTTP 메서드
METHODS=("GET" "POST" "PUT" "DELETE")

# URL 경로
URLS=("/index.html" "/api/users" "/products" "/about" "/contact" "/admin/login" "/api/data")

# HTTP 상태 코드
STATUS_CODES=(200 201 301 302 404 403 500 502)

# User Agent
USER_AGENTS=(
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36"
    "curl/7.68.0"
)

# 날짜별 로그 생성 함수
generate_access_log() {
    local hour=$1
    local minute=$2
    local second=$3
    
    # 시간대별로 다른 IP와 요청 생성
    local ip=${IPS[$RANDOM % ${#IPS[@]}]}
    local method=${METHODS[$RANDOM % ${#METHODS[@]}]}
    local url=${URLS[$RANDOM % ${#URLS[@]}]}
    local status=${STATUS_CODES[$RANDOM % ${#STATUS_CODES[@]}]}
    local user_agent=${USER_AGENTS[$RANDOM % ${#USER_AGENTS[@]}]}
    
    # 파일 크기 (랜덤)
    local size=$((RANDOM % 50000 + 1000))
    
    # 로그 형식: IP - - [날짜/시간] "메서드 URL 프로토콜" 상태 크기 "referer" "user-agent"
    printf '%s - - [12/Sep/2025:%02d:%02d:%02d +0000] "%s %s HTTP/1.1" %d %d "-" "%s"\n' \
        "$ip" "$hour" "$minute" "$second" "$method" "$url" "$status" "$size" "$user_agent" >> "$ACCESS_LOG_FILE"
}

# 9월 12일 전체 로그 생성 (06:00 ~ 11:00 사이)
# 필터링 범위: 07:00:00 ~ 10:30:00
# 범위 내 로그와 범위 밖 로그를 섞어서 생성

# 06:00 ~ 06:59 (범위 밖 - 앞부분)
for minute in {0..59}; do
    generate_access_log 6 $minute $((RANDOM % 60))
done

# 07:00 ~ 10:30 (필터링 대상 범위 내)
for hour in {7..9}; do
    for minute in {0..59}; do
        generate_access_log $hour $minute $((RANDOM % 60))
    done
done

# 10:00 ~ 10:30
for minute in {0..30}; do
    generate_access_log 10 $minute $((RANDOM % 60))
done

# 10:31 ~ 11:00 (범위 밖 - 뒷부분)
for minute in {31..59}; do
    generate_access_log 10 $minute $((RANDOM % 60))
done

# 몇 개의 로그 추가로 섞기 (다른 시간대)
generate_access_log 5 30 15   # 05:30 (범위 밖)
generate_access_log 11 15 45  # 11:15 (범위 밖)
generate_access_log 12 0 0    # 12:00 (범위 밖)

echo -e "${GREEN}✓ Access 로그 생성 완료: $ACCESS_LOG_FILE${NC}"
echo "  - 총 라인 수: $(wc -l < "$ACCESS_LOG_FILE")"
echo ""

# ===========================================
# 2. Error 로그 생성
# ===========================================
echo -e "${YELLOW}[2/2] Error 로그 생성 중...${NC}"

# 로그 파일 초기화
> "$ERROR_LOG_FILE"

# 클라이언트 관련 에러
cat >> "$ERROR_LOG_FILE" << 'EOF'
2025/11/01 10:15:01 [error] 1245#1245: *1021 client prematurely closed connection while reading response header from upstream, client: 192.168.1.21, server: actlog.shop, request: "GET /api/data HTTP/1.1"
2025/11/01 10:15:02 [error] 1245#1245: *1022 client sent invalid request while reading client request line, client: 203.0.113.5, server: actlog.shop
2025/11/01 10:15:03 [warn] 1245#1245: *1023 client closed connection while waiting for request, client: 10.0.0.5, server: actlog.shop
2025/11/01 10:15:03 [error] 1245#1245: *1024 client sent invalid method in request line: "GTE /home HTTP/1.1", client: 45.12.45.9
2025/11/01 10:15:04 [error] 1245#1245: *1025 client sent invalid header line: "X-Forwarded: test", client: 10.0.3.2
2025/11/01 10:15:05 [error] 1245#1245: *1026 client prematurely closed connection, while sending response to client, client: 52.66.11.15
2025/11/01 10:15:06 [error] 1245#1245: *1027 client closed connection while reading client request body, client: 192.168.1.35
2025/11/01 10:15:07 [error] 1245#1245: *1028 client intended to send too large body: 10485761 bytes, client: 203.0.113.8
2025/11/01 10:15:08 [warn] 1245#1245: *1029 an upstream response is buffered to a temporary file /var/lib/nginx/proxy/1/00/000001 due to high latency, client: 10.0.0.15
2025/11/01 10:15:09 [error] 1245#1245: *1030 client sent too long header line while reading request headers, client: 198.51.100.11
2025/11/01 10:15:10 [error] 1245#1245: *1031 client closed connection prematurely (499), client: 203.0.113.77
2025/11/01 10:15:11 [error] 1245#1245: *1032 invalid host in request header: "evil.com", client: 203.0.113.10
2025/11/01 10:15:12 [warn] 1245#1245: *1033 client sent invalid chunk size, client: 10.0.2.6
2025/11/01 10:15:13 [error] 1245#1245: *1034 client connection reset by peer, client: 203.0.113.23
2025/11/01 10:15:14 [error] 1245#1245: *1035 client prematurely closed connection while reading client request body, client: 172.16.1.10
2025/11/01 10:15:15 [error] 1245#1245: *1036 client request body is buffered to a temporary file due to request size, client: 10.0.3.10
2025/11/01 10:15:16 [error] 1245#1245: *1037 client closed connection while reading response body, client: 203.0.113.111
2025/11/01 10:15:17 [warn] 1245#1245: *1038 invalid referer header from client, client: 192.168.0.88
2025/11/01 10:15:18 [error] 1245#1245: *1039 client prematurely closed connection during keepalive, client: 10.0.2.9
2025/11/01 10:15:19 [error] 1245#1245: *1040 client sent invalid Content-Length header, client: 198.51.100.22
EOF

# 업스트림 관련 에러
cat >> "$ERROR_LOG_FILE" << 'EOF'
2025/11/01 10:16:01 [error] 1246#1246: *1101 upstream timed out (110: Connection timed out) while connecting to upstream, client: 192.168.1.21, upstream: "http://10.0.3.5:8080/api/user"
2025/11/01 10:16:02 [error] 1246#1246: *1102 connect() failed (111: Connection refused) while connecting to upstream, client: 203.0.113.11, upstream: "http://10.0.3.8:8080/login"
2025/11/01 10:16:03 [error] 1246#1246: *1103 upstream sent invalid header while reading response header from upstream, client: 10.0.0.9, upstream: "http://10.0.3.10:8080/"
2025/11/01 10:16:04 [error] 1246#1246: *1104 upstream prematurely closed connection while reading response header from upstream, client: 203.0.113.33
2025/11/01 10:16:05 [error] 1246#1246: *1105 no live upstreams while connecting to upstream, client: 10.0.0.11, upstream: "backend_cluster"
2025/11/01 10:16:06 [error] 1246#1246: *1106 upstream sent too big header while reading response header, client: 192.168.1.23
2025/11/01 10:16:07 [error] 1246#1246: *1107 recv() failed (104: Connection reset by peer) while reading response header from upstream, client: 10.0.2.8
2025/11/01 10:16:08 [error] 1246#1246: *1108 upstream response is buffered to a temporary file /var/lib/nginx/proxy/2/00/000002, client: 203.0.113.21
2025/11/01 10:16:09 [error] 1246#1246: *1109 upstream server temporarily disabled while connecting, client: 203.0.113.45
2025/11/01 10:16:10 [error] 1246#1246: *1110 upstream timed out (110: Connection timed out) while reading response header from upstream, client: 10.0.0.55
2025/11/01 10:16:11 [error] 1246#1246: *1111 upstream sent invalid response while reading upstream, client: 192.168.0.88
2025/11/01 10:16:12 [error] 1246#1246: *1112 connect() to upstream failed (113: No route to host) while connecting to upstream, client: 10.0.2.7
2025/11/01 10:16:13 [error] 1246#1246: *1113 upstream response connection reset (104: Connection reset by peer), client: 203.0.113.90
2025/11/01 10:16:14 [error] 1246#1246: *1114 upstream sent too big response header, client: 203.0.113.66
2025/11/01 10:16:15 [error] 1246#1246: *1115 upstream prematurely closed keepalive connection, client: 10.0.3.6
2025/11/01 10:16:16 [error] 1246#1246: *1116 bad gateway while reading response from upstream, client: 203.0.113.81
2025/11/01 10:16:17 [error] 1246#1246: *1117 upstream server closed connection unexpectedly, client: 10.0.0.22
2025/11/01 10:16:18 [error] 1246#1246: *1118 upstream timed out (110: Connection timed out) while sending to client, client: 203.0.113.105
2025/11/01 10:16:19 [error] 1246#1246: *1119 upstream sent invalid chunked response, client: 192.168.1.70
2025/11/01 10:16:20 [error] 1246#1246: *1120 upstream prematurely closed connection, request: "GET /api/data HTTP/1.1", upstream: "http://10.0.3.12:8080"
EOF

# 시스템 리소스/파일 관련 에러
cat >> "$ERROR_LOG_FILE" << 'EOF'
2025/11/01 10:17:01 [error] 1247#1247: *1201 open() "/var/www/html/index.html" failed (2: No such file or directory), client: 192.168.1.21
2025/11/01 10:17:02 [error] 1247#1247: *1202 open() "/var/www/html/style.css" failed (13: Permission denied), client: 203.0.113.55
2025/11/01 10:17:03 [crit] 1247#1247: *1203 sendfile() failed (104: Connection reset by peer) while sending response, client: 10.0.0.22
2025/11/01 10:17:04 [alert] 1247#1247: accept4() failed (24: Too many open files)
2025/11/01 10:17:05 [error] 1247#1247: *1205 stat() "/etc/nginx/conf.d/mime.types" failed (2: No such file or directory)
2025/11/01 10:17:06 [crit] 1247#1247: *1206 worker process 1321 exited on signal 9
2025/11/01 10:17:07 [error] 1247#1247: *1207 mkdir() "/var/lib/nginx/tmp" failed (13: Permission denied)
2025/11/01 10:17:08 [error] 1247#1247: *1208 open() "/var/log/nginx/access.log" failed (30: Read-only file system)
2025/11/01 10:17:09 [error] 1247#1247: *1209 unlink() "/var/lib/nginx/proxy_temp" failed (13: Permission denied)
2025/11/01 10:17:10 [crit] 1247#1247: *1210 socket() failed (24: Too many open files)
2025/11/01 10:17:11 [error] 1247#1247: *1211 connect() to unix:/run/php-fpm.sock failed (2: No such file or directory)
2025/11/01 10:17:12 [error] 1247#1247: *1212 failed to allocate memory for request buffer
2025/11/01 10:17:13 [error] 1247#1247: *1213 open() "/var/www/html/favicon.ico" failed (2: No such file or directory)
2025/11/01 10:17:14 [error] 1247#1247: *1214 readdir() failed (5: Input/output error)
2025/11/01 10:17:15 [crit] 1247#1247: *1215 epoll_wait() failed (4: Interrupted system call)
2025/11/01 10:17:16 [error] 1247#1247: *1216 getpeername() failed (107: Transport endpoint is not connected)
2025/11/01 10:17:17 [error] 1247#1247: *1217 open() "/etc/nginx/nginx.conf" failed (13: Permission denied)
2025/11/01 10:17:18 [crit] 1247#1247: *1218 worker process 1247 exited on signal 11 (core dumped)
2025/11/01 10:17:19 [error] 1247#1247: *1219 write() to "/var/log/nginx/error.log" failed (28: No space left on device)
EOF

# 구성/모듈 관련 에러
cat >> "$ERROR_LOG_FILE" << 'EOF'
2025/11/01 10:18:01 [emerg] 1248#1248: unknown directive "prox_pass" in /etc/nginx/conf.d/default.conf:14
2025/11/01 10:18:02 [emerg] 1248#1248: "server" directive is not allowed here in /etc/nginx/nginx.conf:25
2025/11/01 10:18:03 [emerg] 1248#1248: invalid parameter "offf" in /etc/nginx/conf.d/proxy.conf:9
2025/11/01 10:18:04 [alert] 1248#1248: could not build the variables_hash, you should increase variables_hash_max_size
2025/11/01 10:18:05 [emerg] 1248#1248: unknown log format "mainlog" in /etc/nginx/nginx.conf:70
2025/11/01 10:18:06 [emerg] 1248#1248: duplicate location "/" in /etc/nginx/conf.d/app.conf:22
2025/11/01 10:18:07 [warn] 1248#1248: conflicting server name "example.com" on 0.0.0.0:80, ignored
2025/11/01 10:18:08 [emerg] 1248#1248: invalid number of arguments in "listen" directive in /etc/nginx/conf.d/app.conf:5
2025/11/01 10:18:09 [emerg] 1248#1248: "location" directive is not terminated properly in /etc/nginx/sites-enabled/api.conf:33
2025/11/01 10:18:10 [error] 1248#1248: invalid PID number in "/run/nginx.pid"
2025/11/01 10:18:11 [emerg] 1248#1248: unexpected end of file, expecting "}" in /etc/nginx/nginx.conf:89
2025/11/01 10:18:12 [emerg] 1248#1248: invalid port in "listen 80abc" of the "server" directive
2025/11/01 10:18:13 [warn] 1248#1248: load module "/usr/lib/nginx/modules/ngx_http_fancy_module.so" failed (2: No such file or directory)
2025/11/01 10:18:14 [emerg] 1248#1248: duplicate upstream "backend" in /etc/nginx/conf.d/backend.conf:2
2025/11/01 10:18:15 [emerg] 1248#1248: invalid parameter "ssl_on" in /etc/nginx/conf.d/ssl.conf:6
2025/11/01 10:18:16 [alert] 1248#1248: unknown variable "$upstream_ip" in /etc/nginx/conf.d/log.conf:8
2025/11/01 10:18:17 [emerg] 1248#1248: the "events" directive is duplicate in /etc/nginx/nginx.conf:12
2025/11/01 10:18:18 [emerg] 1248#1248: invalid value "http2on" in "listen" directive
2025/11/01 10:18:19 [emerg] 1248#1248: directive "proxy_pass" is not terminated by ";" in /etc/nginx/conf.d/proxy.conf:20
2025/11/01 10:18:20 [emerg] 1248#1248: unknown directive "fastcgi_buffer_sie" in /etc/nginx/conf.d/fastcgi.conf:10
EOF

echo -e "${GREEN}✓ Error 로그 생성 완료: $ERROR_LOG_FILE${NC}"
echo "  - 총 라인 수: $(wc -l < "$ERROR_LOG_FILE")"
echo "  - [error] 레벨: $(grep -c "\[error\]" "$ERROR_LOG_FILE")"
echo "  - [warn] 레벨: $(grep -c "\[warn\]" "$ERROR_LOG_FILE")"
echo "  - [crit] 레벨: $(grep -c "\[crit\]" "$ERROR_LOG_FILE")"
echo "  - [alert] 레벨: $(grep -c "\[alert\]" "$ERROR_LOG_FILE")"
echo "  - [emerg] 레벨: $(grep -c "\[emerg\]" "$ERROR_LOG_FILE")"
echo ""

# ===========================================
# 최종 요약
# ===========================================
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✅ 모든 로그 파일 생성 완료!${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""
echo "📁 생성된 파일:"
echo "  - $ACCESS_LOG_FILE ($(wc -l < "$ACCESS_LOG_FILE")줄)"
echo "  - $ERROR_LOG_FILE ($(wc -l < "$ERROR_LOG_FILE")줄)"
echo ""
echo "📚 사용 방법:"
echo "  - Access 로그: gawk 시간 필터링 연습용"
echo "  - Error 로그: grep/awk/sed 명령어 연습용"
echo ""
echo "📖 상세 가이드: ../nginx_log_practice.md"



