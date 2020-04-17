FROM node:10-alpine
ENV APP_ROOT /web
WORKDIR ${APP_ROOT}
ADD . ${APP_ROOT}
RUN npm run build
CMD ["npm", "run", "start"]