# ts-node-docker-setup-notes

```bash
touch Dockerfile .dockerignore docker-compose.yaml docker-compose.dev.yaml
```

```yaml
# Dockerfile

FROM node:16-alpine as development

WORKDIR /user/src/app

COPY ./package*.json .

RUN npm i

COPY . .

RUN npm run build

FROM node:16-alpine as production

WORKDIR /user/src/app

ARG NODE_ENV=production

ENV NODE_ENV=${NODE_ENV}

COPY ./package*.json .

RUN npm install ci --only=production

COPY --from=development /usr/src/app/dist ./dist

CMD ["node", "dist/app.js"]
```

```yaml
# .dockerignore

node_modules/
dist/
```

```yaml
# docker-compose.dev.yaml

version: "3.4"

services:
  ts-app:
    build:
      context: .
      target: development
    volumes:
      - ./:/usr/src/app
      - /usr/src/app/node_modules
    ports:
      - 3000:3000
    command: npm run dev
```

```yaml
# docker-compose.yaml
version: "3.4"

services:
  ts-app:
    build:
      context: .
      target: production
    ports:
      - 3000:3000
```

```json
// package.json

"scripts": {
    "docker:dev:up": "docker-compose -f docker-compose.dev.yaml up -d",
    "docker:dev:down": "docker-compose -f docker-compose.dev.yaml down",
    "docker:prod:up": "docker-compose up --build -d",
    "docker:prod:down": "docker-compose down"
  },
```
