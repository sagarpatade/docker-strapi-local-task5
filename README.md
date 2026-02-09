# 🐳 Dockerized Strapi v4 (Node 20)

This project provides a production-ready **Docker container for Strapi v4 Headless CMS**.

It is explicitly engineered to solve compatibility issues between **Strapi v4** and **Node.js 20**, and includes build optimizations to keep the image size manageable on local machines.

## 🚀 Features

* **Latest Tech Stack:** Runs on **Node.js 20 (Bullseye)**.
* **Optimized Build:** Includes aggressive cache cleaning (`rm -rf /root/.npm`) to prevent "No Space Left on Device" errors during build.
* **Stability Fixes:** Pre-configured with `ENV HOST=0.0.0.0` to prevent the common Strapi crash loop in containerized environments.
* **Zero-Config Start:** Uses the `--quickstart` flag to set up a local SQLite database automatically.

## 🛠 Prerequisites

* **Docker Desktop** (or Docker Engine on Linux)
* **Git**

## 🏃‍♂️ Quick Start

### 1. Clone the Repository
```bash
git clone [https://github.com/YOUR_USERNAME/docker-strapi-local.git](https://github.com/YOUR_USERNAME/docker-strapi-local.git)
cd docker-strapi-local
2. Build the Docker Image
This step installs Node 20, builds the Strapi Admin panel, and optimizes storage.

Bash

docker build -t strapi-local .
3. Run the Container
Map port 1337 to access the CMS.

Bash

docker run -p 1337:1337 --name my-strapi strapi-local
4. Access Strapi
Once the logs say "Welcome back!", open your browser: 👉 http://localhost:1337/admin

🏗 Project Structure
├── Dockerfile       # Multi-stage build instructions for Node 20 + Strapi
├── .dockerignore    # Prevents local node_modules from breaking the container
└── README.md        # Documentation
