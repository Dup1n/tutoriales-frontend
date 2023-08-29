FROM node:14 as build-stage

WORKDIR /app-react
COPY package.json .
RUN npm install
COPY . .

RUN npm run build

FROM nginx:1.17.0-alpine

COPY --from=build-stage /app-react/build /usr/share/nginx/html
EXPOSE 80

CMD nginx -g 'daemon off;'