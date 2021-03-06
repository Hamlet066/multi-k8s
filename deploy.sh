docker build -t hamo066/multi-client:latest -t hamo066/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hamo066/multi-server:latest -t hamo066/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hamo066/multi-worker:latest -t hamo066/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push hamo066/multi-client:latest
docker push hamo066/multi-server:latest
docker push hamo066/multi-worker:latest

docker push hamo066/multi-client:$SHA
docker push hamo066/multi-server:$SHA
docker push hamo066/multi-worker$SHA

kubectl apply -f k8s --validate=false
kubectl set image deployments/client-deployment client=hamo066/multi-client:$SHA
kubectl set image deployments/server-deployment server=hamo066/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=hamo066/multi-worker:$SHA
