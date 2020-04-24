docker build -t maxpicky/multi-client-k8s:latest -t maxpicky/multi-client-k8s:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t maxpicky/multi-server-k8s:latest -t maxpicky/multi-server-k8s:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t maxpicky/multi-worker-k8s:latest -t maxpicky/multi-worker-k8s:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push maxpicky/multi-client-k8s:latest
docker push maxpicky/multi-server-k8s:latest
docker push maxpicky/multi-worker-k8s:latest

docker push maxpicky/multi-client-k8s:$GIT_SHA
docker push maxpicky/multi-server-k8s:$GIT_SHA
docker push maxpicky/multi-worker-k8s:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maxpicky/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=maxpicky/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=maxpicky/multi-worker:$GIT_SHA