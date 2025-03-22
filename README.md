# Terraform-AWS-Project
Cloud Setup with Terraform: This project uses Terraform to automatically create cloud resources on AWS, like servers, networks, security settings, and load balancers. It shows how to easily set up and manage cloud infrastructure with code.

# 🚀 Create Infrastructure using Terraform  

This project focuses on **creating cloud infrastructure using Terraform** with a real-time example. We will provision a **VPC, deploy two applications** across different **Availability Zones**, and configure a **Load Balancer** to distribute traffic automatically.  

---

## 📌 **Project Overview**  
✅ **Create a Virtual Private Cloud (VPC)** for secure networking.  
✅ **Deploy two applications** across different **Availability Zones** for high availability.  
✅ **Set up an Application Load Balancer (ALB)** to distribute traffic between the instances.  

---

## 🏗 **Infrastructure Architecture**  
The following AWS resources will be provisioned using Terraform:  

- **VPC** – A Virtual Private Cloud to isolate resources.  
- **Subnets** – Two private subnets in different Availability Zones.  
- **EC2 Instances** – Two application instances deployed in separate subnets.  
- **Security Groups** – Control inbound and outbound traffic for instances.  
- **Application Load Balancer (ALB)** – Automatically distributes traffic across instances.  
- **Target Groups & Health Checks** – Ensure traffic is routed only to healthy instances.  

---

## 🛠 **Terraform Configuration**  
### **1️⃣ Initialize Terraform**  
Run the following command to initialize Terraform and download necessary providers:  
```sh
terraform init
```

### **2️⃣ Plan the Infrastructure**  
To see the execution plan before applying changes:  
```sh
terraform plan
```

### **3️⃣ Implement Terraform Formatting & Validation  
Before applying your changes, always check for syntax errors and proper formatting:  

```sh
terraform fmt       # Auto-formats Terraform code  
terraform validate  # Validates Terraform configuration  
```

### **4️⃣ Deploy the Infrastructure**  
Apply the Terraform configuration to provision AWS resources:  
```sh
terraform apply -auto-approve
```
### **5️⃣ Destroy the infrastructure**
Destroying infrastructure when no longer needed using: 
```sh
terraform destroy -auto-approve
```

## 🔄 **Infrastructure Diagram**  

```txt
                Internet
                    │
         ┌─────────▼─────────┐
         │Load Balancer (ALB)│
         └─────────┬─────────┘
                   │
       ┌──────────▼───────────┐
       │   VPC (10.0.0.0/16)  │
       └──────────┬───────────┘
                  │
      ┌──────────▼───────────┐
      │    Public Subnet 1   │──────────┐
      │   (AZ-1, 10.0.1.0/24)│          │
      └──────────┬───────────┘          │
                 │                      │
        ┌───────▼────────┐       ┌──────▼────────┐
        │    EC2-App1    │       │    EC2-App2   │
        │  (Web Server)  │       │  (Web Server) │
        └────────────────┘       └───────────────┘
                 │                         │
      ┌─────────▼─────────┐      ┌──────── ▼─────────┐
      │    Private Subnet │      │   Private Subnet  │
      │(AZ-2, 10.0.2.0/24)│      │(AZ-2, 10.0.3.0/24)│
      └───────────────────┘      └───────────────────┘
```

### **Explanation of Components:**
- **VPC (10.0.0.0/16):** A virtual network for all AWS resources.
- **Public Subnets (AZ-1 & AZ-2):** Hosts EC2 instances with web applications.
- **EC2 Instances:** Two web servers deployed in separate availability zones.
- **Application Load Balancer (ALB):** Distributes traffic between EC2 instances.
- **Private Subnets:** (If needed) Can be used for databases or backend services.

---
## 🔧 Troubleshooting & Common Issues  

### ❌ Issue: Terraform provider errors?  
**🛠 Fix:** Run the following command to update provider plugins:  
```sh
terraform init -upgrade
```
### ❌ Issue: Load Balancer not routing traffic?  
**🛠 Fix:** Ensure that health checks are properly configured in the Load Balancer settings.  

### ❌ Issue: SSH access denied?  
**🛠 Fix:** Verify that your Security Group rules allow inbound SSH (port 22).  
---

## 🎯 Key Takeaways  

✅ **Automating cloud infrastructure deployment** using **Terraform** for consistency and scalability.  
✅ **Deploying applications across multiple Availability Zones** to ensure **fault tolerance and high availability**.  
✅ **Implementing Load Balancing** to efficiently distribute traffic and improve **performance & reliability**.  
✅ **Enhancing security** by properly configuring **Security Groups, IAM roles, and VPC networking**.  
✅ **Utilizing Terraform state management** to track infrastructure changes and enable collaboration.  
✅ **Following Infrastructure as Code (IaC) best practices**, including **modules, variables, and version control**.  
✅ **Debugging Terraform issues** and resolving provider-related errors to ensure smooth deployments.  

 ---

 ## 📚 Further Learning  

📖 [**Official Terraform Documentation**](https://developer.hashicorp.com/terraform/docs) → Learn Terraform concepts, commands, and best practices.  
📖 [**AWS Infrastructure Best Practices**](https://aws.amazon.com/architecture/well-architected/) → Follow AWS Well-Architected Framework guidelines for building scalable and secure infrastructure.  
📖 [**Terraform Modules Guide**](https://registry.terraform.io/) → Explore reusable Terraform modules for efficient infrastructure management.  

---

🌟 **Keep Building, Keep Learning!** 🌟  

Cloud infrastructure is the backbone of modern applications, and **Terraform empowers you** to manage it efficiently. 🚀  
Every command you run, every resource you provision, and every challenge you overcome **takes you one step closer** to mastering DevOps & Cloud Engineering!  

🔹 **Start small, experiment, and break things—because that’s how you learn!**  
🔹 **Infrastructure as Code (IaC) is the future—embrace it, automate it, and scale with confidence.**  
🔹 **Remember: Every expert was once a beginner. Your journey starts now!**  

💡 **Let’s build, innovate, and share knowledge with the tech community!**  

🚀 **The cloud is limitless—so is your potential!**  
---
