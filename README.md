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

4. Deploy / Pipeline
    -  [AWS S3에 이미지 배포하기](#aws-s3-배포하기)
    -  [CI/CD 배포 자동화 (Feat. Github Actions)](#github-actions)


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

## 읽기 수정 vim 

- `vi [파일이름]`: 파일 읽기
- `i`: 편집 실행
- `ESC` : 종료하기
- `:wq` : 저장하고 종료하기 

          - : 커서맨아래로 이동
          - w 저장하기
          - q 나가기
          - wq 저장하고 종료하기
          - q! 저장하지 않고 나가기

## 파일 권한 설정

## tar zp

## nginx 설정


## Dockerfile 작성


## docker 명령어


## docker-compose


## 도커이미지 도커허브에 올리기

## AWS s3 배포하기

## github actions

