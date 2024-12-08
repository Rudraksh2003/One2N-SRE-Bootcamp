# One2N-SRE-Bootcamp
# Student API Deployment Project

Welcome to the **Student API Deployment Project** repository! This project provides an infrastructure-as-code approach to managing, deploying, and scaling the `student-api` application using Kubernetes and Helm.

## Table of Contents

1. [Project Overview](#project-overview)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Installation](#installation)
5. [Accessing the Applications](#accessing-the-applications)
6. [Project Structure](#project-structure)
7. [Contributing](#contributing)
8. [License](#license)

---

## Project Overview

The `student-api` application is designed to manage student records, providing CRUD (Create, Read, Update, Delete) operations via a RESTful API. This repository focuses on deploying the application in Kubernetes using Helm for package management and ease of deployment.

The repository includes two namespaces to allow flexible deployments for staging (`student-api-new`) and production (`student-api`).

---

## Features

- Automated deployment with Helm charts.
- Namespace segregation for staging and production environments.
- Seamless configuration management.
- Scalable and robust architecture on Kubernetes.

---

## Prerequisites

Ensure the following tools are installed and configured on your system:

- [Kubernetes](https://kubernetes.io/) cluster (Minikube, EKS, GKE, or AKS recommended).
- [Helm](https://helm.sh/) 3.x or higher.
- [kubectl](https://kubernetes.io/docs/tasks/tools/).

---

## Installation
### Step 1: minikube three node start
```bash
minikube start --nodes=3 --cpus=2 --memory=4g --driver=docker
```
### Step 2: label the nodes
```bash
kubectl label nodes minikube type=student-api
kubectl label nodes minikube-m02 type=database
kubectl label nodes minikube-m03 role=dependent-services
```

### Step 3: Clone the Repository

```bash
git clone https://github.com/Rudraksh2003/One2N-SRE-Bootcamp.git
cd student-api-deployment/kubernetes
```

### Step 4: Create Namespaces

```bash
kubectl create namespace student-api

```

### Step 5: apply kubernetes yaml file
```bash
kubectl apply -f application.yaml
kubectl apply -f database.yaml
kubectl apply -f dependent-services
cd external-services
kubectl apply -f vault.yaml
kubectl apply -f prometheus.yaml
kubectl apply -f grafana.yaml
kubectl apply -f promtail.yaml
kubectl apply -f black.yaml


```



### Step 4: Verify Deployment

```bash
kubectl get pods -n student-api
kubectl get pods -n dependent-services
```

---

## Accessing the Applications

### Using Kubernetes Service

Both deployments expose the `student-api` application via a Kubernetes service. To access the application:

1. Retrieve the service information:

   ```bash
   kubectl get svc -n student-api
   kubectl get svc -n dependent-services
  
   ```

2. Access the application using the service's external IP or NodePort.

### by using minikube
```
minikube service student-api -n student-api

```

### Using Port Forwarding

If an external IP is not available:

```bash
kubectl port-forward svc/student-api 8080:80 -n student-api
```

Access the APIs at:

- **Production:** `http://localhost:8080`

---

## Project Structure

```plaintext
(.env) rudraksh@rudraksh:~/O2N$ tree
.
├── application-deployment.yaml
├── app.py
├── config.py
├── database-deployment.yaml
├── deployment
│   ├── agrocd
│   │   ├── argocd-apps.yaml
│   │   └── argocd-repository-secret.yaml
│   ├── helm1
│   │   ├── my-helm-chart
│   │   │   ├── Chart.lock
│   │   │   ├── charts
│   │   │   │   ├── grafana-6.0.0.tgz
│   │   │   │   └── prometheus-15.0.0.tgz
│   │   │   ├── Chart.yaml
│   │   │   ├── templates
│   │   │   │   ├── eso-deployment.yaml
│   │   │   │   ├── grafana-deployment.yaml
│   │   │   │   ├── namespace.yaml
│   │   │   │   ├── podsecuritypolicy.yaml
│   │   │   │   ├── prometheus-deployment.yaml
│   │   │   │   ├── pvc.yaml
│   │   │   │   ├── rolebinding-psp.yaml
│   │   │   │   ├── rolebinding.yaml
│   │   │   │   ├── role-psp.yaml
│   │   │   │   ├── role.yaml
│   │   │   │   ├── serviceMonitor.yaml
│   │   │   │   └── vault-deployment.yaml
│   │   │   └── values.yaml
│   │   ├── my-helm-chart-0.1.0.tgz
│   │   ├── student-api-0.1.0.tgz
│   │   ├── student-api-chart
│   │   │   ├── Chart.yaml
│   │   │   ├── templates
│   │   │   │   ├── configmap.yaml
│   │   │   │   ├── deployment.yaml
│   │   │   │   ├── namespace.yaml
│   │   │   │   ├── secret.yaml
│   │   │   │   └── service.yaml
│   │   │   └── values.yaml
│   │   ├── student-db-0.1.0.tgz
│   │   └── student-db-chart
│   │       ├── Chart.yaml
│   │       ├── templates
│   │       │   ├── configmap.yaml
│   │       │   ├── deployment.yaml
│   │       │   └── secret.yaml
│   │       └── values.yaml
│   ├── helm2
│   │   └── student-api-helm-chart
│   │       ├── charts
│   │       ├── Chart.yaml
│   │       ├── templates
│   │       │   ├── db-deployment.yaml
│   │       │   ├── db-pvc.yaml
│   │       │   ├── deployment.yaml
│   │       │   ├── _helpers.tpl
│   │       │   ├── hpa.yaml
│   │       │   ├── ingress.yaml
│   │       │   ├── NOTES.txt
│   │       │   ├── secret.yaml
│   │       │   ├── serviceaccount.yaml
│   │       │   ├── service.yaml
│   │       │   ├── tests
│   │       │   │   └── test-connection.yaml
│   │       │   ├── vault2-backup.yaml
│   │       │   ├── vault-deployment.yaml
│   │       │   └── vault-pvc.yaml
│   │       └── values.yaml
│   └── prometheus-server.yaml
├── docker-compose.yml
├── Dockerfile
├── install_dependencies.sh
├── instance
│   └── students.db
├── kubernetes
│   ├── application.yml
│   ├── argocd
│   ├── argocd-server
│   ├── argocd-server.yaml
│   ├── database.yml
│   ├── dependent-services.yml
│   ├── external-secrets
│   │   ├── black.yml
│   │   ├── eso-config.yml
│   │   ├── grafana-pvc.yaml
│   │   ├── grafana.yaml
│   │   ├── prometheus-pvc.yaml
│   │   ├── prometheus.yaml
│   │   ├── prom-trail.yml
│   │   ├── psdb.yml
│   │   └── vault.yml
│   ├── metallb-config.yaml
│   ├──  PersistentVolumeClaim.yml
│   └── postman-collection-configmap.yaml
├── makefile
├── migrations
│   ├── alembic.ini
│   ├── env.py
│   ├── __pycache__
│   │   └── env.cpython-312.pyc
│   ├── README
│   ├── script.py.mako
│   └── versions
│       ├── 61518127cda6_.py
│       └── __pycache__
│           └── 61518127cda6_.cpython-312.pyc
├── models.py
├── nginx.conf
├── observability-deployment.yaml
├── postgres-deployment.yaml
├── prometheus-deployment.yaml
├── __pycache__
│   ├── app.cpython-312.pyc
│   ├── app.cpython-39.pyc
│   ├── config.cpython-312.pyc
│   ├── config.cpython-39.pyc
│   ├── models.cpython-312.pyc
│   ├── models.cpython-39.pyc
│   ├── routes.cpython-312.pyc
│   └── routes.cpython-39.pyc
├── routes.py
├── static
│   └── requirements.txt
├── templates
│   └── index.html
└── Vagrantfile

26 directories, 103 files

```

---

## Contributing

We welcome contributions to improve this project! To contribute:

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-name`).
3. Commit your changes (`git commit -m "Add feature"`).
4. Push to your fork (`git push origin feature-name`).
5. Submit a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

Thank you for using the **Student API Deployment Project**! If you encounter any issues, feel free to open an issue in this repository.

