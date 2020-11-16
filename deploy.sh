docker build -t furkanh/multi-client:latest -t furkanh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t furkanh/multi-server:latest -t furkanh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t furkanh/multi-worker:latest -t furkanh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push furkanh/multi-client:latest 
docker push furkanh/multi-server:latest
docker push furkanh/multi-worker:latest
docker push furkanh/multi-client:$SHA 
docker push furkanh/multi-server:$SHA
docker push furkanh/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=furkanh/multi-server:$SHA
kubectl set image deployments/client-deployment client=furkanh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=furkanh/multi-worker:$SHA