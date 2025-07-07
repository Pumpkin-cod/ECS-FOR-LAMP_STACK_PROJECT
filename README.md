LAMP Stack Deployment on AWS with ECS, Aurora, NGINX Reverse Proxy, and CloudWatch Monitoring
This project demonstrates how to deploy a secure, scalable, and observable LAMP (Linux, Apache, MySQL-compatible Aurora, PHP) stack application on AWS. It includes reverse proxying via NGINX, containerization via Docker, and deployment to Amazon ECS using AWS Copilot CLI. Monitoring, logging, and alerting are integrated with CloudWatch.

🔗 Live Demo
Access the deployed PHP CRUD application:

👉 http://lamp-a-publi-rovkasjtjmyu-1026018692.eu-west-1.elb.amazonaws.com/

📐 Project Architecture
```
pgsql
Copy
Edit
                        +---------------------------+
                        |        End User           |
                        +------------+--------------+
                                     |
                          HTTPS / HTTP Request
                                     |
                            +--------v--------+
                            |     NGINX       |  (Reverse Proxy - port 80)
                            +--------+--------+
                                     |
                            Proxy to Apache (port 8080)
                                     |
                            +--------v--------+
                            |    Apache + PHP |  (App Server)
                            +--------+--------+
                                     |
                                 PDO/MySQL
                                     |
                       +-------------v----------------+
                       |  Amazon Aurora (MySQL) RDS   |
                       +------------------------------+



For ECS deployment:
```
pgsql
Copy
Edit
```
                            +------------------------------+
                            |        AWS Copilot CLI       |
                            +------------------------------+
                                       |
                                       v
+----------------------+     +---------------------+     +----------------------+
|   ECS Cluster        | --> |   Fargate Service   | --> | Application Load Balancer |
+----------------------+     +---------------------+     +----------------------+
                                       |
                                Dockerized PHP-Apache App
                                       |
                               +-------v--------+
                               | Aurora DB (RDS)|
                               +----------------+

📁 Application Structure
Deployed in /var/www/html/:

index.php – Display all records

create.php – Add a new entry

update.php – Edit a record

delete.php – Delete a record

db.php – Database connection

info.php – Detailed view

🚀 Deployment Steps
✅ 1. Infrastructure Provisioning
ECS Fargate cluster via AWS Copilot

Aurora MySQL RDS database (provisioned separately)

Security groups and IAM roles handled by Copilot

Load Balanced Web Service exposed via ALB on port 80

✅ 2. Application Containerization
Dockerfile includes:

PHP 8.2 + Apache

PDO and MySQL extensions

Apache config and project files

Docker Compose used for local testing

Secrets (DB credentials, host) injected using Copilot secrets

✅ 3. ECS Deployment with AWS Copilot
copilot init to set up application

copilot svc deploy to deploy the PHP container

Secrets managed via:

bash
Copy
Edit
copilot secret init
Public URL auto-provisioned by Copilot via ALB

📊 Monitoring & Observability
✅ CloudWatch Agent (on EC2 version)
Logs collected from:

/var/log/nginx/access.log

/var/log/nginx/error.log

/var/log/httpd/access_log

/var/log/httpd/error_log

✅ CloudWatch Logs & Alarms
Alarm Name	Condition	Action
HighMemoryUsage	Memory > 80% for 5 mins	SNS Email Alert
HighCPUUsage	CPU > 80% for 5 mins	SNS Email Alert
DiskUsageHigh	Disk > 80% used	SNS Email Alert
Apache5xxErrors	500 errors detected in Apache logs	SNS Email Alert

✅ Best Practices Followed
🛠️ ECS Fargate for serverless container hosting

🔐 Secrets managed using AWS SSM Parameter Store via Copilot

🛡️ NGINX as reverse proxy for added security

📈 Centralized monitoring with CloudWatch

🔄 Aurora DB used for scalable, managed MySQL-compatible database

📦 CI/CD-ready architecture (future: GitHub Actions or CodePipeline)

📄 License
This project is for educational and demonstration purposes. For production use, apply enhanced security, backups, CI/CD, and auto-scaling.

🙌 Acknowledgments
AWS Copilot CLI

Amazon ECS & Fargate

Aurora RDS

CloudWatch Logs and Alarms

NGINX + Apache PHP stack