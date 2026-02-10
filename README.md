# 🐳 Dockerized Strapi with PostgreSQL & Nginx

This project demonstrates a production-ready, multi-container environment for Strapi v4. It replaces the default SQLite database with **PostgreSQL** and uses **Nginx** as a reverse proxy to handle traffic on Port 80.

## 📋 Task Submission
* **🎥 Demo Video:** [Click here to watch the Loom Video](https://www.loom.com/share/c597de33db434b419748625737f1267e)
* **🔀 Pull Request:** [View PR #1 on GitHub](https://github.com/sagarpatade/docker-strapi-local-task5/pull/1)

---

## 🏗 Architecture
The application runs on a custom Docker network (`strapi-net`) to ensure secure, isolated communication between containers.

```mermaid
graph LR
    User(Browser) -- Port 80 --> Nginx
    subgraph "Docker Network: strapi-net"
    Nginx -- Proxy --> Strapi(Port 1337)
    Strapi -- Database Connection --> Postgres(Port 5432)
    end
Nginx: Reverse Proxy (Exposed on Port 80)

Strapi: Headless CMS (Internal Port 1337)

PostgreSQL: Database (Internal Port 5432)

🚀 How to Run
1. Create the Network
Create a user-defined bridge network for container communication.

Bash

docker network create strapi-net
2. Start PostgreSQL
Start the database container with the necessary credentials.

Bash

docker run -d \
  --name my-postgres \
  --network strapi-net \
  -e POSTGRES_USER=strapi \
  -e POSTGRES_PASSWORD=strapi \
  -e POSTGRES_DB=strapi \
  postgres:16-alpine
3. Build & Run Strapi
Build the Docker image (optimized for Node 20) and start the application.

Bash

docker build -t strapi-postgres .

docker run -d \
  --name my-strapi \
  --network strapi-net \
  -e DATABASE_CLIENT=postgres \
  -e DATABASE_HOST=my-postgres \
  -e DATABASE_PORT=5432 \
  -e DATABASE_NAME=strapi \
  -e DATABASE_USERNAME=strapi \
  -e DATABASE_PASSWORD=strapi \
  -e DATABASE_SSL=false \
  strapi-postgres
4. Start Nginx Proxy
Start Nginx to forward traffic from localhost to the Strapi container.

Bash

docker run -d \
  --name my-nginx \
  --network strapi-net \
  -p 80:80 \
  -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
  nginx:alpine
✅ Verification
Open your browser to: http://localhost/admin

You should see the Strapi Registration page (served via Port 80).

Create an admin user. The data will be persisted in the PostgreSQL container.

🛠️ Tech Stack
Runtime: Node.js 20 (Bullseye)

Database: PostgreSQL 16 Alpine

Proxy: Nginx Alpine

Containerization: Docker