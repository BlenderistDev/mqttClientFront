FROM node:12
ENV APP_ROOT /web
WORKDIR ${APP_ROOT}
ADD . ${APP_ROOT}
RUN npm run build
CMD ["npm", "run", "start"]