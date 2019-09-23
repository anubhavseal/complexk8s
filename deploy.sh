docker build -t anubhav2381/multi-client:latest -t anubhav2381/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t anubhav2381/multi-server:latest  -t anubhav2381/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t anubhav2381/multi-worker:latest  -t anubhav2381/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anubhav2381/multi-client:latest
docker push anubhav2381/multi-client:$SHA

docker push anubhav2381/multi-server:latest
docker push anubhav2381/multi-server:$SHA

docker push anubhav2381/multi-worker:latest
docker push anubhav2381/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=anubhav2381/multi-client:$SHA
kubectl set image deployments/server-deployment server=anubhav2381/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=anubhav2381/multi-worker:$SHA