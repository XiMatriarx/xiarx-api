FROM node:20-alpine AS express-build

ARG PORT=80

WORKDIR /app

COPY . .

RUN npm install --omit=dev
RUN npm run build

FROM node:20-alpine AS express

WORKDIR /app

COPY package.json .
COPY package-lock.json .
COPY --from=express-build /app/lib .

EXPOSE $PORT

CMD ["node", "index.js"]
