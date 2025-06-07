# Step 2: 프록시 서버 설정

## 📚 학습 목표
- 도커로 프록시 nginx 서버를 구성한다
- sites-enabled와 심볼릭 링크를 이해하고 설정한다
- 프록시 서버가 정상적으로 실행되는지 확인한다

---

## 🔹 준비 사항

### 필요한 파일 구조
```
nginx/
├── proxy/
│   ├── Dockerfile
│   ├── nginx.conf
│   └── sites-available/
│       └── proxy.conf
└── docker-compose.yml
```

---

## (1) Dockerfile 생성

프록시 서버용 Dockerfile을 생성합니다.

```bash
# nginx/proxy/Dockerfile 생성

# nginx 컨테이너에서 복사할 폴더 준비
mkdir -p nginx/proxy/sites-available
```

### 🔹 nginx 이미지 기본 구조

`nginx:alpine` 이미지에는 이미 다음이 포함되어 있습니다:
- `/etc/nginx/` 디렉토리 및 기본 설정 파일들
- `/usr/share/nginx/html/` 디렉토리 (기본 HTML 파일 위치)
- nginx 실행 파일

따라서 우리는 **추가로 필요한 디렉토리만 생성**하면 됩니다.

### Dockerfile 내용

```dockerfile
FROM nginx:alpine

# /etc/nginx는 nginx 이미지에 이미 존재함
# sites-available, sites-enabled 디렉토리만 추가 생성
RUN mkdir -p /etc/nginx/sites-available \
    && mkdir -p /etc/nginx/sites-enabled

# 기본 nginx.conf를 우리가 만든 것으로 교체
COPY nginx.conf /etc/nginx/nginx.conf

# sites-available의 설정 파일 복사
COPY sites-available/ /etc/nginx/sites-available/

# 심볼릭 링크 생성 (sites-available → sites-enabled)
RUN ln -s /etc/nginx/sites-available/proxy.conf /etc/nginx/sites-enabled/proxy.conf

# 포트 노출
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

---

## (2) nginx.conf 생성

메인 nginx 설정 파일을 생성합니다.

### 🔹 nginx.conf vs sites-available의 차이

**nginx.conf (메인 설정 파일)**
- 위치: `proxy/nginx.conf` → `/etc/nginx/nginx.conf`
- 역할: nginx의 **전역 설정** (worker 프로세스, 로그 포맷, http 블록 등)
- 내용: `include /etc/nginx/sites-enabled/*.conf;`로 사이트별 설정을 포함

**sites-available/proxy.conf (사이트별 설정 파일)**
- 위치: `proxy/sites-available/proxy.conf` → `/etc/nginx/sites-available/proxy.conf`
- 역할: **특정 도메인/서버 블록** 설정 (프록시 설정 포함)
- 활성화: `sites-enabled`에 심볼릭 링크로 연결되어 사용

### 동작 흐름

```
nginx.conf (메인 설정)
    ↓
include /etc/nginx/sites-enabled/*.conf;
    ↓
sites-enabled/proxy.conf (심볼릭 링크)
    ↓
sites-available/proxy.conf (실제 파일)
```

### nginx.conf 내용

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

    # sites-enabled의 설정 파일들을 포함
    include /etc/nginx/sites-enabled/*.conf;
}
```

### 핵심 포인트

#### 🔹 include가 필요한 이유

**기본 nginx.conf에는 sites-enabled가 포함되어 있지 않습니다!**

기본 nginx 이미지의 nginx.conf는 다음과 같습니다:
```nginx
http {
    include /etc/nginx/mime.types;
    # ... 기타 설정 ...
    include /etc/nginx/conf.d/*.conf;  # 이것만 있음
}
```

- `sites-available`/`sites-enabled` 구조는 **Ubuntu/Debian 배포판의 관례**입니다
- nginx 공식 이미지는 이를 **자동으로 포함하지 않습니다**
- 따라서 우리가 **명시적으로 `include`를 추가**해야 합니다

#### include의 역할
- `include /etc/nginx/sites-enabled/*.conf;`: sites-enabled 폴더의 모든 설정 파일을 포함
- 이렇게 하면 sites-enabled에 심볼릭 링크를 추가하면 자동으로 설정이 적용됨
- **이 줄이 없으면 sites-enabled의 설정 파일들이 무시됩니다!**

---

## (3) 프록시 설정 파일 생성

sites-available에 프록시 설정 파일을 생성합니다.

### sites-available/proxy.conf 내용

```nginx
server {
    listen 80;
    server_name myapp.local;

    # 로그 설정
    access_log /var/log/nginx/proxy_access.log;
    error_log /var/log/nginx/proxy_error.log;

    # 프록시 설정
    location / {
        # 목적지 서버로 요청 전달
        # backend는 docker-compose.yml에서 정의한 서비스 이름
        proxy_pass http://backend:80;
        
        # 헤더 설정
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### 설정 설명
- `listen 80`: 80 포트에서 요청을 받음
- `server_name myapp.local`: 도메인 이름 (나중에 /etc/hosts에 추가)
- `proxy_pass http://backend:80`: backend 서비스의 80 포트로 요청 전달
- `proxy_set_header`: 요청 헤더를 설정하여 목적지 서버가 클라이언트 정보를 알 수 있게 함

---

## (4) docker-compose.yml 설정

프록시 서버를 도커로 실행하기 위한 설정을 추가합니다.

### docker-compose.yml 내용 (프록시 부분)

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
      # 설정 파일 변경 시 재시작 없이 테스트 가능
      - ./proxy/nginx.conf:/etc/nginx/nginx.conf:ro
      - ./proxy/sites-available:/etc/nginx/sites-available:ro
    depends_on:
      - backend
    networks:
      - proxy-network

  backend:
    # Step 3에서 설정할 예정
    # 일단 placeholder로 남겨둠
    image: nginx:alpine
    container_name: nginx-backend
    networks:
      - proxy-network

networks:
  proxy-network:
    driver: bridge
```

---

## (5) 파일 생성 및 확인

### 파일 생성 명령어

```bash
# nginx 폴더로 이동
cd nginx

# 디렉토리 생성
mkdir -p proxy/sites-available

# Dockerfile 생성 (위 내용 복사)
# nginx.conf 생성 (위 내용 복사)
# sites-available/proxy.conf 생성 (위 내용 복사)
# docker-compose.yml 생성 (위 내용 복사)
```

### 파일 구조 확인

```bash
tree nginx/
# 또는
ls -R nginx/
```

---

## (6) 도커 빌드 및 실행

### 빌드 및 실행

```bash
# 도커 이미지 빌드
docker-compose build proxy

# 컨테이너 실행
docker-compose up -d proxy

# 로그 확인
docker-compose logs proxy
```

### 실행 확인

```bash
# 컨테이너 상태 확인
docker-compose ps

# nginx 설정 테스트
docker-compose exec proxy nginx -t

# nginx 재시작 (설정 변경 시)
docker-compose exec proxy nginx -s reload
```

---

## 🔹 sites-enabled와 심볼릭 링크 이해

### 개념 설명

#### sites-available
- 사용 가능한 모든 설정 파일을 저장하는 디렉토리
- 여러 설정 파일을 준비해두고 필요에 따라 활성화/비활성화

#### sites-enabled
- 실제로 활성화된 설정 파일을 저장하는 디렉토리
- sites-available의 파일에 대한 심볼릭 링크를 생성

#### 심볼릭 링크 (Symbolic Link)
- 실제 파일을 가리키는 포인터
- 원본 파일을 수정하면 링크를 통해서도 변경사항이 반영됨

### 예시

```bash
# sites-available에 설정 파일 생성
/etc/nginx/sites-available/proxy.conf

# sites-enabled에 심볼릭 링크 생성
ln -s /etc/nginx/sites-available/proxy.conf /etc/nginx/sites-enabled/proxy.conf

# 결과: sites-enabled/proxy.conf → sites-available/proxy.conf를 가리킴
```

### 장점
- 설정 파일을 쉽게 활성화/비활성화 가능
- 여러 설정 파일을 관리하기 용이
- 원본 파일은 sites-available에 보관

---

## 🧩 연습 문제

### 문제 1: 심볼릭 링크 생성
sites-available에 `test.conf` 파일이 있을 때, sites-enabled에 심볼릭 링크를 생성하는 명령어는?

### 문제 2: 설정 파일 비활성화
sites-enabled에서 심볼릭 링크를 삭제하면 어떻게 되는가?

### 문제 3: nginx 설정 확인
nginx 설정 파일에 문법 오류가 있는지 확인하는 명령어는?

---

## ✅ 체크포인트

다음 내용을 확인하세요:
- [ ] proxy/Dockerfile이 생성되었다
- [ ] proxy/nginx.conf가 생성되었다
- [ ] proxy/sites-available/proxy.conf가 생성되었다
- [ ] docker-compose.yml에 proxy 서비스가 정의되었다
- [ ] 도커 컨테이너가 정상적으로 실행된다
- [ ] `nginx -t` 명령어로 설정이 올바른지 확인했다
- [ ] sites-enabled와 심볼릭 링크의 개념을 이해했다

---

## 📝 다음 단계

프록시 서버 설정을 완료했다면 다음 단계로 진행하세요:
👉 [Step 3: 목적지 서버 설정](./step3_backend_setup.md)

