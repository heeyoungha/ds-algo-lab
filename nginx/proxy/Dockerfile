FROM nginx:alpine

# /etc/nginx는 nginx 이미지에 이미 존재함
# sites-available, sites-enabled 디렉토리만 추가 생성
RUN mkdir -p /etc/nginx/sites-available \
    && mkdir -p /etc/nginx/sites-enabled

# 기본 nginx.conf를 우리가 만든 것으로 교체
COPY nginx.conf /etc/nginx/nginx.conf

# 심볼릭 링크 생성 (sites-available → sites-enabled)
# RUN ln -s /etc/nginx/sites-available/proxy.conf /etc/nginx/sites-enabled/proxy.conf

# 포트 노출
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]


