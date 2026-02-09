# 1. Use Node 20 (Bullseye)
FROM node:20-bullseye

# 2. Install System Dependencies & Clean Up Immediately
# We combine commands to keep layers small
RUN apt-get update && apt-get install -y \
    libvips-dev \
    python3 \
    make \
    g++ \
    git \
    && rm -rf /var/lib/apt/lists/*

# 3. Set Working Directory
WORKDIR /opt/app

# 4. Install Strapi (Optimized for Low Disk Space)
# We install Strapi AND delete the huge npm cache in the same step.
RUN npx create-strapi-app@4.25.4 my-project \
    --quickstart \
    --no-run \
    --skip-cloud \
    && rm -rf /root/.npm /root/.cache /tmp/*

# 5. Move into project
WORKDIR /opt/app/my-project

# 6. Rebuild Sharp & Build Admin (Clean cache again)
RUN npm rebuild sharp \
    && npm run build \
    && rm -rf /root/.npm /root/.cache

# 7. Set Environment Variables (Fixes the crash)
ENV HOST=0.0.0.0
ENV PORT=1337

# 8. Expose Port
EXPOSE 1337

# 9. Start
CMD ["npm", "run", "develop"]