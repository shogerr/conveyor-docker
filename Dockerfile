FROM node:latest as build-stage
RUN git clone https://github.com/shogerr/conveyor-ui.git && cd conveyor-ui && git checkout development
#WORKDIR /app
#COPY ./conveyor-ui/package*.json ./
#COPY ./conveyor-ui/tsconfig.json ./
WORKDIR /conveyor-ui
RUN yarn install
#COPY ./conveyor-ui ./
RUN yarn build

FROM nginx as production-stage
RUN mkdir /conveyor-ui
COPY --from=build-stage /conveyor-ui/dist /app
COPY nginx.conf /etc/nginx/nginx.conf