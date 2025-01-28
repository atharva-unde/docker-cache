FROM node:18 AS builder 
WORKDIR /app 
COPY package*.json ./ 
RUN --mount=type=cache,target=/root/.npm npm install 
code COPY . . 
RUN npm run build 
FROM nginx:alpine 
COPY --from=builder /app/dist /usr/share/nginx/html 
COPY nginx.conf /etc/nginx/conf.d/default.conf 
EXPOSE 54350
CMD ["nginx", "-g", "daemon off;"]