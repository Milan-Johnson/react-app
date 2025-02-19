# Stage 1: Build the React app
FROM node:lts AS builder
WORKDIR /app
RUN git clone https://github.com/Milan-Johnson/react-app.git .
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
# Stage 2: Create the production image
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
