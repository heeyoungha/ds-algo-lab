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

