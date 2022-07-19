docker build -t colteks01/multi-client:latest -t colteks01/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t colteks01/multi-server:latest -t colteks01/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t colteks01/multi-worker:latest -t colteks01/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push colteks01/multi-client:latest
docker push colteks01/multi-server:latest
docker push colteks01/multi-worker:latest

docker push colteks01/multi-client:$SHA
docker push colteks01/multi-server:$SHA
docker push colteks01/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/server-deployment server=colteks01/multi-server:$SHA
kubectl set image deployments/client-deployment server=colteks01/multi-client:$SHA
kubectl set image deployments/worker-deployment server=colteks01/multi-worker:$SHA