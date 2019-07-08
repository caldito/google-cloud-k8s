docker build -t caldito99/multi-client:latest -f ./multi-client/Dockerfile ./client
docker build -t caldito99/multi-client:$SHA -f ./multi-client/Dockerfile ./client
docker build -t caldito99/multi-server:latest -f ./multi-server/Dockerfile ./server
docker build -t caldito99/multi-server:$SHA -f ./multi-server/Dockerfile ./server
docker build -t caldito99/multi-worker:latest -f ./multi-worker/Dockerfile ./worker
docker build -t caldito99/multi-worker:$SHA -f ./multi-worker/Dockerfile ./worker

docker push caldito99 multi-client:latest
docker push caldito99 multi-client:$SHA
docker push caldito99 multi-server:latest
docker push caldito99 multi-server:$SHA
docker push caldito99 multi-worker:latest
docker push caldito99 multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=caldito99/multi-server:$SHA
kubectl set image deployments/client-deployment client=caldito99/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=caldito99/multi-worker:$SHA
