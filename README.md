# simple-image-server
이미지 서버 구축해보기

- [X] 로컬 - nginx에 이미지 띄우고 docker 이미지로 만들어 Docker Hub에 올리기
- [X] 클라우드 - AWS S3 에 이미지 배포하여 서빙하기

<br />
<br />

__Results__

__URL__ : `${HOST}/images/${z}/${x}/${y}.png` 로 접근한다. <br/>
          &ensp; &emsp; &emsp;(ex: http://localhost:3000/images/12/3495/1601.png)


<br />
<br />
<br />

## Get Started

### Run Nginx

```
brew services start nginx
```

- visit : http://localhost:3000/images/12/3495/1601.png

<br />

### Run Docker Image

```
docker build -t simple-image-server .
docker run --rm -p 3030:80 --name nginx simple-image-server
```

- visit : http://localhost:3030/images/12/3495/1601.png


<br />
<br />
<br />

## Guide

 



1. Nginx
    - [nginx 설치 및 실행](#nginx-설치-및-실행-macos)
    - [nginx.conf 파일 설정](#nginx-설정)

2. Linux
    - [폴더/파일 복사](#리눅스-명령어)
    - [파일 삭제](#파일-삭제-rm)
    - [파일 출력](#파일-출력-cat)
    - [파일 읽기/수정 (vi/vim)](#읽기-수정-vim)
    - [파일 권한 설정](#파일-권한-설정)
    - [tar zp 압축](#tar-zp)

3. Docker
    - [Dockerfile 작성](#dockerfile-작성)
    - [Docker 명령어](#docker-명령어)
    - [docker-compose](#docker-compose)
    - [도커 이미지 도커허브에 올리기](#도커이미지-도커허브에-올리기)
    - [Image's platform](#Image's-platform)

4. Deploy / Pipeline
    -  [AWS S3에 이미지 배포하기](#aws-s3-배포하기)
    -  [Github action을 이용한 자동배포](#github-actions)


<br />
<br />
<br />


## Nginx 설치 및 실행 (macOS)

- 설치 : `brew install nginx`

- 실행 : `brew services start nginx` or `brew services restart nginx`
  
- 종료 : `nginx -s stop`

- 확인 : `ps -ef | grep nginx`



<br />
<br />
<br />


## 리눅스 명령어

### 폴더/파일 복사 - cp

- `cp ${원본 파일명} ${복사본 파일명}` 

- `cp ${파일명} ${디렉토리명}` :  디렉토리 안에 파일 복사

- `cp ${원본 디렉토리명} ${복사본 디렉토리명}` 

- `cp -r ${디렉토리명} ${복사 위치 디렉토리명}` : 뒤에 명시된 디렉토리 안으로 복사

### 폴더/파일 이동 mv

- `mv ${원본 파일명} ${이동할 파일명}`: 파일명 변경과 동일
- `mv [파일명] [이동할 디렉토리명`


### 파일 삭제 rm

- `rm [옵션][삭제 할 디렉토리/파일]`
  - 옵션 `-r` : 디렉토리 내부의 모든 내용을 삭제합니다.
- `rm *.txt` : 현재 위치의 .txt로 끝나는 모든 파일 제거

### 파일 출력 cat

- `cat [파일이름]` : 파일 열기
- `cat -b [파일이름]` : 각 행에 번호 붙여서 출력하기
- `cat [파일이름]` : 빈 행에 번호 붙여서 출력하기

<br/>

### 읽기 수정 vim 

- `vi [파일이름]`: 파일 읽기
- `i`: 편집 실행
- `ESC` : 종료하기
- `:wq` : 저장하고 종료하기 

          - : 커서맨아래로 이동
          - w 저장하기
          - q 나가기
          - wq 저장하고 종료하기
          - q! 저장하지 않고 나가기
<br/>
<br/>

### 파일 권한 설정
`ls -al`
`sudo chmod -R 755 ./`

<br/>

### tar zp

`-cf  images.tar.gz ./images`

<br/>
<br/>
<br/>

## nginx 설정

1. `brew info nginx`로 nginx path를 조회한다.
2. 해당 위치로 이동하면 nginx.conf 파일이 있는데, 이 파일로 설정을 수정해 주어야 한다.
3. `sudo vi /opt/homebrew/etc/nginx/nginx.conf` 실행
4. server 부분에서 라우트설정 및 포트를 설정 줄 수 있다. <br />     
```   
          server {
              listen       80; // 포트설정 : 기본이 80 - localhost:80 접속시 ngnix 화면을 볼 수 있다.
              server_name  localhost;

              location /images {
                  alias /etc/nginx/images/sample/;
               }
          }
```
    
<br />

5. 경로설정 root vs alias <br />
&ensp; - `root` : location 으로 넘어온 부분을 root로 설정한 경로에 __추가__ 한다.  <br />
&ensp; -`alias`: location 에 매칭된 부분을 alias 로 설정한 경로로 __바꾼다__.

<br />

예) `localhost:80/images` 접속

:honeybee: __root__
```
location /images {
      root /etc/nginx/images/sample/;
}
```
:arrow_right: __/etc/nginx/images/sample/images__ 로 자원을 찾게된다. <br/>

<br />

:honeybee: __alias__
```
location /images {
      alias /etc/nginx/images/sample/;
}
```
:arrow_right:  __/etc/nginx/images/sample__ 로 자원을 찾게된다.

<br />

6. cors 설정
```
location /images {
  alias /etc/nginx/images/DJ/;
  add_header 'Access-Control-Allow-Origin' '*' always;
}
```

<br />
<br />
<br />


## Dockerfile 작성

Dockerfile 은 도커 _이미지_를 생성하는 파일이다.

```
FROM nginx


#기본 디렉토리 설정
WORKDIR /etc/nginx 

# Copy the images 폴더
COPY images/  ./images/

# Copy the Nginx config
COPY nginx.conf ./

# 포트설정
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

- tar zp 압축한 경우

```
 COPY images.tar.gz ./
 RUN tar -xf ./images.tar.gz \ 
 && rm -rf ./images.tar.gz
#  ADD images.tar.gz ./ 하면 자동으로 압축 해제됨
```

<br />
<br />
<br />


## docker 명령어

### 이미지 검색

- `docker images` 

### 도커 이미지 빌드

- `docker build -t [컨테이너명] .`


### 도커 이미지 실행
- `docker run --rm -it[컨테이너명] sh`
- `docker run --rm -d -p 3000:8888 [컨테이너명]` 
- `run --rm -d -p 3000:8888 --name [이름지정] [컨테이너명]` : 컨테이너명 이름을 지정하여 실행

|옵션|설명|
|--------|--------------|
|--rm |  컨테이너가 종료될 때 컨테이너와 관련된 리소스(파일 시스템, 볼륨)제거 (주로 일회성 실행에 쓰임)|
|-d|  데몬 형태로 실행|
| -p [로컬포트]:[컨테이너포트]|포트 포워딩|
|-it|   컨테이너를 종료하지 않은채로, 터미널의 입력을 계속해서 컨테이너로 전달하기 위해서 사용|
| --name| 컨테이너에 이름을 부여, 삭제, 종료시 편리|
         
         
 

### 컨테이너 목록 조회

- `docker ps` : 실행중인 컨테이너 목록 출력
- `docker ps -a` : 실행했던 컨테이너 목록의 이력을 출력
- `docker ps -a -q` : 도커의 모든 컨테이너 ID 확인
- `docker logs` : 도커 로그 목록 조회

### 컨테이너 접속 / 종료 / 빠져나오기
- `docker exec -it ` :  도커 컨테이너 접속
- `exec`: 컨테이너 종료하면서 빠져나오기 
- `docker stop [컨테이너이름]` : 컨테이너 종료

<br />
<br />
<br />

## docker-compose

docker-compose는 도커 _컨테이너_를 생성하는 파일이다.

여러 컨테이너를 가지는 애플리케이션을 통합적으로 Docker 이미지를 만들고, 만들어진 각각의 컨테이너를 시작 및 중지하는 등의 작업을 더 쉽게 수행할 수 있도록 도와주는 도구 <br />
:arrow_right: 복수 컨테이너를 정의하기 위한 툴
<br />
```
version: [버전 명시]

services:
  [서비스명 지정]:
    container_name: [컨테이너명]
    image: [이미지명]
    build:
      context: ./
      dockerfile: ./Dockerfile
    ports:
      - 80:80
```
<br />
<br />
<br />


## 도커이미지 도커허브에 올리기
github Actions 를 사용하여 CI/CD 작성해보자
<br />

```
name: deploy simple image server

on:
  push:
    branches:
      - "main" // main 브랜치에 머지될때마다 아래 jobs 실행

jobs:
 CD_DockerHub:
    name: [이름작성]
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repo
        uses: actions/checkout@v3

      - name: Login to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_HUB_USER_NAME }}
          password: ${{ secrets.DOCKER_HUB_PASSWORD }}

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Build and push
        uses: docker/build-push-action@v4
        with:
          context: .
          file: ./Dockerfile
          push: true
          tags: ${{ secrets.DOCKER_HUB_USER_NAME }}/simple-image-server:latest
```

<br />
<br />

## Image's platform

[이슈] Docker on Mac M1 gives: "The requested image's platform (linux/amd64) does not match the detected host platform"

[해결] 빌드할때 --platform linux/arm64 옵션을 설정해준다.


<br />
<br />
<br />

## AWS s3 배포하기

[참고링크](https://velog.io/@lllen/AWS-S3%EC%99%80-Cloudfront%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%9C-%ED%94%84%EB%A1%A0%ED%8A%B8%EC%97%94%EB%93%9C-%EB%B0%B0%ED%8F%AC)


```
{
  "name": "simple-image-server",
  "version": "0.0.0",
  "license": "MIT",
  "scripts": {
    "deploy": "aws s3 sync ./build s3://`서비스명` --profile=`사용자 이름`"
  }
}

```

## Github action을 이용한 자동배포

[참고링크](https://zzsza.github.io/development/2020/06/06/github-action/)

