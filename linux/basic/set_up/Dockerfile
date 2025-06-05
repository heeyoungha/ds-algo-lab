FROM ubuntu:latest

# 기본 업데이트 및 필수 도구 설치
RUN apt-get update && apt-get install -y \
    vim \
    curl \
    wget \
    git \
    tree \
    less \
    man-db \
    manpages \
    gawk \
    bc \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /workspace

# 컨테이너가 종료되지 않도록 기본 명령어 설정
CMD ["bash"]

