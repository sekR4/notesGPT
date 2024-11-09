# Stage 1: Install dependencies and build the app
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

# Stage 2: Copy the built app to a lightweight image for production
FROM node:18-alpine AS production

WORKDIR /app

COPY --from=build /app ./

EXPOSE 3000

CMD ["npm", "start"]
