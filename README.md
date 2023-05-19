# simple-image-server
이미지 서버 구축해보기

1. 로컬 : nginx에 이미지 띄우고 docker 이미지로 만들어 Docker Hub에 올리기
2. 클라우드 : AWS S3 에 이미지 배포하여 서빙하기

<br />
<br />

__Results__

__URL__ : `${HOST}/images/${z}/${x}/${y}.png` 로 접근한다. (ex: http://localhost:3000/images/12/3495/1601.png)


<br />
<br />
<br />

## Guide

 



1. Nginx
    - [nginx 설치 및 실행](#nginx-설치-및-실행-macos)
    - [nginx.conf 파일 설정](#nginx-설정)

2. Linux
    - [폴더 전체 복사/이동/삭제 명령어](#리눅스-명령어)
    - [파일 수정 (vi/vim)](#vim-명령어)
    - [파일 권한 설정](#파일-권한-설정)
    - [tar zp 압축](#tar-zp)

3. Docker
    - [Dockerfile 작성](#dockerfile-작성)
    - [Docker 명령어](#docker-명령어)
    - [docker-compose](#docker-compose)
    - [도커 이미지 도커허브에 올리기](#도커이미지-도커허브에-올리기)

4. Deploy / Pipeline
    -  [AWS S3에 이미지 배포하기](#aws-s3-배포하기)
    -  [CI/CD 배포 자동화 (Feat. Github Actions)](#github-actions)


<br />
<br />
<br />


## Nginx 설치 및 실행 (macOS)

- 설치 : `brew install nginx`

- 실행 : `brew services restart nginx`
  
- 종료 : `nginx -s stop`

- 확인 : `ps -ef | grep nginx`



<br />
<br />
<br />


## 리눅스 명령어


## vim 명령어

## 파일 권한 설정

## tar zp

## nginx 설정


## Dockerfile 작성


## docker 명령어


## docker-compose


## 도커이미지 도커허브에 올리기

## AWS s3 배포하기

## github actions

