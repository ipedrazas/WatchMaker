#! /bin/bash


git clone https://github.com/pires/kubernetes-nats-cluster.git .

kubectl create -f kubernetes-nats-cluster/svc-nats.yaml

if [[ $1 eq "SSL" ]]; then
    openssl genrsa -out ca-key.pem 2048
    openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj "/CN=kube-ca"
    openssl genrsa -out nats-key.pem 2048
    openssl req -new -key nats-key.pem -out nats.csr -subj "/CN=kube-nats" -config ssl.cnf
    openssl x509 -req -in nats.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out nats.pem -days 3650 -extensions v3_req -extfile ssl.cnf
    kubectl create secret generic tls-nats --from-file nats.pem --from-file nats-key.pem
    kubectl create -f kubernetes-nats-cluster/deployment-nats-tls.yaml
else
    kubectl create -f kubernetes-nats-cluster/deployment-nats.yaml
fi

kubectl scale deployment nats --replicas 3
