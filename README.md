# 개요
- ReactApp 빌드시 화면의 prerendering을 위하여 nodejs 모듈인 puppeteer(https://github.com/puppeteer/puppeteer)와 네이티브 모듈인 chromium 설치된 빌드용 amazonlinux2 docker 이미지 생성
- codebuild의 amazonlinux2 인스턴스는 실제 빌드할수 있는 있지만 buildspec.xml에 추가 모듈을 yum을 통해서 install phase에서 설치해야함
```
version: 0.2
env:
  git-credential-helper: yes    
phases:
  install:
    commands:
      - yum install -y cups-libs dbus-glib libXScrnSaver libXrandr libXcursor libXinerama cairo cairo-gobject pango GConf2
....
```
- 로컬 확인용이나 런타임용으로 참고하세요

## 크로미늄 엔진을 설치한 AmazonLinux2 도커이미지 커스텀 생성 (amazonlinux2:chromium)
```
docker build --force-rm	-t amazonlinux2:chromium .

```

## 테스트를 위하여 web(react) 볼륨을 연동 && 이미지 구동 (-it)
- host_source_dir은 리엑트 프로젝트의 소스 위치 입니다. -v를 통하여 마운트후 빌드 하는 방식입니다. 
```
docker run -it --rm \
-v {host_source_dir}:/web \
amazonlinux2:chromium
```


## codebuild amazonlinux2 3.0 이용
```
docker run  -it --privileged --rm \
-v /Users/jay/vible/workspace/lotus_web:/web \
codebuild/amazoneliunx2:3.0 /bin/bash

```

## chromium 및 종속성 설치
```
yum install -y cups-libs dbus-glib libXScrnSaver libXrandr libXcursor libXinerama cairo cairo-gobject pango GConf2
```