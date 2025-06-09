# Step 3: 목적지 서버 설정

## 📚 학습 목표
- 목적지 nginx 서버를 구성한다
- 간단한 애플리케이션 서버를 구성한다
- 목적지 서버가 정상적으로 실행되는지 확인한다

---

## 🔹 준비 사항

### 필요한 파일 구조
```
nginx/
├── backend/
│   ├── Dockerfile
│   ├── nginx.conf  (server 블록 포함)
│   └── app/
│       └── index.html
└── docker-compose.yml (업데이트)
```

### 🔹 프록시 서버 vs 목적지 서버 구조 차이

**프록시 서버 (proxy)**
- 여러 사이트를 관리할 수 있도록 `sites-available`/`sites-enabled` 구조 사용
- 확장성과 유지보수성을 고려한 구조

**목적지 서버 (backend)**
- 단순히 정적 파일을 서빙하는 서버
- `nginx.conf`에 직접 `server` 블록 작성 (더 간단함)
- `sites-available`/`sites-enabled` 구조 불필요

---

## (1) 목적지 서버 Dockerfile 생성

목적지 서버용 Dockerfile을 생성합니다.

### 🔹 nginx 이미지 기본 구조

`nginx:alpine` 이미지에는 이미 다음이 포함되어 있습니다:
- `/etc/nginx/` 디렉토리 및 기본 설정 파일들
- `/usr/share/nginx/html/` 디렉토리 (기본 HTML 파일 위치)
- nginx 실행 파일

따라서 우리는 **추가로 필요한 디렉토리만 생성**하면 됩니다.

### backend/Dockerfile 내용

```dockerfile
FROM nginx:alpine

# /etc/nginx는 nginx 이미지에 이미 존재함
# 애플리케이션 디렉토리만 생성
RUN mkdir -p /usr/share/nginx/html/app

# 기본 nginx.conf를 우리가 만든 것으로 교체
COPY nginx.conf /etc/nginx/nginx.conf

# 애플리케이션 파일 복사
COPY app/ /usr/share/nginx/html/app/

# 포트 노출
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

### 🔹 왜 sites-available이 필요 없나?

목적지 서버는 단순히 정적 파일을 서빙하는 서버이므로:
- **단일 서버 블록만 필요** → `nginx.conf`에 직접 작성
- **확장성이 필요 없음** → sites-available/sites-enabled 구조 불필요
- **더 간단하고 명확함** → 모든 설정이 한 파일에 있어 관리 용이

---

## (2) 목적지 서버 nginx.conf 생성

목적지 서버의 nginx 설정 파일을 생성합니다. 
**프록시 서버와 달리 `server` 블록을 `nginx.conf`에 직접 작성합니다.**

### backend/nginx.conf 내용

```nginx
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log warn;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
}

http {
    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    log_format main '$remote_addr - $remote_user [$time_local] "$request" '
                    '$status $body_bytes_sent "$http_referer" '
                    '"$http_user_agent" "$http_x_forwarded_for"';

    access_log /var/log/nginx/access.log main;

    sendfile on;
    keepalive_timeout 65;

    # 목적지 서버 설정 (간단하게 nginx.conf에 직접 작성)
    server {
        listen 80;
        server_name _;  # 모든 도메인 허용

        # 로그 설정
        access_log /var/log/nginx/app_access.log;
        error_log /var/log/nginx/app_error.log;

        # 루트 디렉토리 설정
        root /usr/share/nginx/html/app;
        index index.html;

        # 정적 파일 서빙
        location / {
            try_files $uri $uri/ /index.html;
        }

        # 헤더 정보 표시 (디버깅용)
        location /info {
            add_header Content-Type text/plain;
            return 200 "Backend Server\nX-Real-IP: $remote_addr\nX-Forwarded-For: $http_x_forwarded_for\nHost: $host\n";
        }
    }
}
```

### 설정 설명
- `listen 80`: 80 포트에서 요청을 받음
- `server_name _`: 모든 도메인 허용 (프록시를 통해 접근하므로)
- `root /usr/share/nginx/html/app`: 정적 파일이 있는 디렉토리
- `/info` 엔드포인트: 프록시를 통해 전달된 헤더 정보를 확인할 수 있음

---

## (4) 간단한 애플리케이션 페이지 생성

목적지 서버에서 보여줄 간단한 HTML 페이지를 생성합니다.

### backend/app/index.html 내용

```html
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>목적지 서버 - 애플리케이션</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }
        .container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            text-align: center;
            max-width: 600px;
        }
        h1 {
            font-size: 2.5em;
            margin-bottom: 20px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        .info {
            background: rgba(255, 255, 255, 0.2);
            padding: 20px;
            border-radius: 10px;
            margin-top: 20px;
        }
        .info-item {
            margin: 10px 0;
            font-size: 1.1em;
        }
        .success {
            font-size: 1.5em;
            margin-top: 30px;
            padding: 15px;
            background: rgba(76, 175, 80, 0.3);
            border-radius: 10px;
        }
        a {
            color: #fff;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎉 목적지 서버에 도달했습니다!</h1>
        <p style="font-size: 1.2em; margin-bottom: 20px;">
            프록시 서버를 통해 성공적으로 접근했습니다.
        </p>
        
        <div class="info">
            <div class="info-item">
                <strong>서버 타입:</strong> 목적지 서버 (Backend)
            </div>
            <div class="info-item">
                <strong>접근 경로:</strong> 클라이언트 → 프록시 서버 → 목적지 서버
            </div>
            <div class="info-item">
                <strong>프록시 헤더 정보:</strong> <a href="/info">/info</a>에서 확인 가능
            </div>
        </div>

        <div class="success">
            ✅ 프록시 서버 연습 성공!
        </div>
    </div>
</body>
</html>
```

---

## (4) docker-compose.yml 업데이트

docker-compose.yml에 목적지 서버 설정을 추가합니다.

### docker-compose.yml 전체 내용

```yaml
version: '3.8'

services:
  proxy:
    build:
      context: ./proxy
      dockerfile: Dockerfile
    container_name: nginx-proxy
    ports:
      - "80:80"
    volumes:
      - ./proxy/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./proxy/sites-available:/etc/nginx/sites-available:ro
    depends_on:
      - backend
    networks:
      - proxy-network

  backend:
    build:
      context: ./backend
      dockerfile: Dockerfile
    container_name: nginx-backend
    volumes:
      - ./backend/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./backend/app:/usr/share/nginx/html/app:ro
    networks:
      - proxy-network
    # 포트는 외부에 노출하지 않음 (프록시를 통해서만 접근)
```

---

## (5) 파일 생성 및 확인

### 파일 생성 명령어

```bash
# nginx 폴더로 이동
cd nginx

# 디렉토리 생성
mkdir -p backend/app

# Dockerfile 생성 (위 내용 복사)
# nginx.conf 생성 (위 내용 복사) - server 블록 포함
# app/index.html 생성 (위 내용 복사)
# docker-compose.yml 업데이트 (위 내용 복사)
```

---

## (6) 도커 빌드 및 실행

### 빌드 및 실행

```bash
# 모든 서비스 빌드
docker-compose build

# 모든 서비스 실행
docker-compose up -d

# 로그 확인
docker-compose logs backend
docker-compose logs proxy
```

### 실행 확인

```bash
# 컨테이너 상태 확인
docker-compose ps

# 목적지 서버 nginx 설정 테스트
docker-compose exec backend nginx -t

# 목적지 서버에 직접 접근 테스트 (프록시를 거치지 않고)
docker-compose exec backend curl http://localhost/info
```

---

## 🔹 네트워크 구조 이해

### 도커 네트워크

```
[클라이언트] 
    ↓
[프록시 서버:80] (외부 포트 노출)
    ↓ (proxy-network)
[목적지 서버:80] (내부 네트워크만)
```

### 포트 노출
- **프록시 서버**: `80:80` - 외부에서 접근 가능
- **목적지 서버**: 포트 노출 없음 - 프록시를 통해서만 접근 가능

### 네트워크 이름
- `proxy-network`: 프록시와 목적지 서버가 같은 네트워크에 있어서 서비스 이름으로 통신 가능
- `proxy_pass http://backend:80`: backend는 서비스 이름

---

## 🧩 연습 문제

### 문제 1: 네트워크 통신
프록시 서버에서 목적지 서버로 요청을 보낼 때 `proxy_pass http://backend:80`에서 `backend`는 무엇인가?

### 문제 2: 포트 노출
목적지 서버의 포트를 외부에 노출하지 않는 이유는?

### 문제 3: 헤더 정보
`/info` 엔드포인트에서 확인할 수 있는 헤더 정보는 무엇인가?

---

## ✅ 체크포인트

다음 내용을 확인하세요:
- [ ] backend/Dockerfile이 생성되었다
- [ ] backend/nginx.conf가 생성되었다 (server 블록 포함)
- [ ] backend/app/index.html이 생성되었다
- [ ] docker-compose.yml에 backend 서비스가 정의되었다
- [ ] 도커 컨테이너가 정상적으로 실행된다
- [ ] `nginx -t` 명령어로 설정이 올바른지 확인했다
- [ ] 목적지 서버에 직접 접근할 수 있다 (컨테이너 내부에서)

---

## 📝 다음 단계

목적지 서버 설정을 완료했다면 다음 단계로 진행하세요:
👉 [Step 4: 통합 및 테스트](./step4_integration.md)

