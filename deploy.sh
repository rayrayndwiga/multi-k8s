docker build -t rayrayndwiga/multi-client:latest -t rayrayndwiga/multi-client:$SHA  -f ./client/Dockerfile ./client
docker build -t rayrayndwiga/multi-server:latest -t rayrayndwiga/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rayrayndwiga/multi-worker:latest -t rayrayndwiga/multi-worker:$SHA -f ./worker/Dockerfile ./worker

# Push the images
docker push rayrayndwiga/multi-client:latest
docker push rayrayndwiga/multi-server:latest
docker push rayrayndwiga/multi-worker:latest

docker push rayrayndwiga/multi-client:$SHA
docker push rayrayndwiga/multi-server:$SHA
docker push rayrayndwiga/multi-worker:$SHA

# Apply k8s
kubectl apply -f k8s

# Imperatively set
# kubectl set image deployments/server-deployment server=rayrayndwiga/multi-server:$SHA
kubectl set image deployments/client-deployment client=rayrayndwiga/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rayrayndwiga/multi-worker:$SHA