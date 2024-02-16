FROM node:20-alpine AS api-build

ARG PORT=80

WORKDIR /app

COPY . .

RUN npm install --omit=dev
RUN npm run build

FROM node:20-alpine AS api

WORKDIR /app

COPY package.json .
COPY package-lock.json .
COPY --from=api-build /app/node_modules node_modules
COPY --from=api-build /app/lib .

EXPOSE $PORT

CMD ["node", "index.js"]
