docker build -t olegsudakov/multi-client:latest -t olegsudakov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t olegsudakov/multi-server:latest -t olegsudakov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t olegsudakov/multi-worker:latest -t olegsudakov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push olegsudakov/multi-client:latest
docker push olegsudakov/multi-server:latest
docker push olegsudakov/multi-worker:latest

docker push olegsudakov/multi-client:$SHA
docker push olegsudakov/multi-server:$SHA
docker push olegsudakov/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=olegsudakov/multi-client:$SHA
kubectl set image deployments/server-deployment server=olegsudakov/multi-server:$SHA
kubectl set image deployments/worker-deployment client=olegsudakov/multi-worker:$SHA