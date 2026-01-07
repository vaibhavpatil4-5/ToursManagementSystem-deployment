# Tourism Management System – Kubernetes Deployment (AWS EKS)

This project demonstrates the **containerized deployment of a PHP-based Tourism Management System** on **AWS EKS (Kubernetes)** using **Docker, MySQL, Services, and AWS ALB Ingress Controller**.

It follows **real-world DevOps practices** such as Infrastructure as Code, containerization, and cloud-native deployment.

---

## 🚀 Project Overview

The application is a **Tourism Management System** built with:
- **PHP** (backend)
- **MySQL** (database)
- **NGINX** (web server)

The system is deployed on **Kubernetes (EKS)** with:
- Separate pods for application and database
- Kubernetes Services for internal communication
- AWS Application Load Balancer (ALB) for external access

---

## 🛠️ Tech Stack

- **Cloud**: AWS (EKS, ALB, IAM)
- **Containerization**: Docker
- **Orchestration**: Kubernetes
- **Ingress**: AWS Load Balancer Controller (ALB Ingress)
- **Database**: MySQL
---

## ⚙️ Architecture

- **MySQL Pod**
  - Runs MySQL database
  - Exposed internally using ClusterIP service

- **Application Pod**
  - Runs PHP application with NGINX
  - Connects to MySQL using environment variables

- **Ingress (ALB)**
  - Exposes application publicly
  - Routes HTTP traffic to application service

---

## 🔐 Environment Variables

The application uses environment variables for database connectivity:

```env
DB_HOST=
DB_USER=
DB_PASS=
DB_NAME=

- **Web Server**: NGINX
- **Version Control**: Git & GitHub

---

## 📂 Repository Structure

├── k8s-manifests/
│ ├── mysql-deployment.yaml
│ ├── mysql-service.yaml
│ ├── app-deployment.yaml
│ ├── app-service.yaml
│ └── ingress.yaml
│


🧩 Deployment Steps
1️⃣ Deploy MySQL
kubectl apply -f mysql-deployment.yaml
kubectl apply -f mysql-service.yaml

2️⃣ Import Database
kubectl exec -i deploy/mysql -n tms -- \
mysql -h 127.0.0.1 -u -p tms < tms.sql

3️⃣ Deploy Application
kubectl apply -f app-deployment.yaml
kubectl apply -f app-service.yaml

4️⃣ Deploy Ingress (AWS ALB)
kubectl apply -f ingress.yaml

🌐 Access Application

After successful Ingress creation:

kubectl get ingress -n tms


Open the ALB DNS name in your browser:

http://k8s-xxxx.elb.amazonaws.com
Vaibhav Patil
Aspiring Cloud & DevOps Engineer
GitHub: https://github.com/vaibhavpatil4-5
