# complex
docker project with multiple containers

sudo: required
services:
  - docker

before install:
  - docker build -t caldito99/react-test -f ./client/Dockerfile.dev ./client

script:
  - docker run caldito99/react-test npm test -- --coverage

afeter_success:
  - docker build -t caldito99/multi-client ./client
  - docker build -t caldito99/multi-nginx ./nginx
  - docker build -t caldito99/multi-server ./server
  - docker build -t caldito99/multi-worker ./worker
  #Login to dockerhub
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_ID" --password-stdin   
  #Push to dockerhub
  - docker push caldito99/multi-client
  - docker push caldito99/multi-nginx
  - docker push caldito99/multi-server
  - docker push caldito99/multi-worker
  
