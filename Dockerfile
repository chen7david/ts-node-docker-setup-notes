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