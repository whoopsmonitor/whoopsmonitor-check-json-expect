
FROM node:14.13.0-alpine3.12
LABEL maintainer="Daniel Rataj <daniel.rataj@centrum.cz>"
LABEL org.opencontainers.image.source="https://github.com/whoopsmonitor/whoopsmonitor-check-json-expect"
LABEL com.whoopsmonitor.documentation="https://github.com/whoopsmonitor/whoopsmonitor-check-json-expect"
LABEL com.whoopsmonitor.env.WM_API_ENDPOINT="https://"
LABEL com.whoopsmonitor.env.WM_EXPECT="status/number/=/200"

WORKDIR /app
COPY ./src/index.js ./src/index.js
COPY ./package.json ./package.json
COPY ./package-lock.json ./package-lock.json

RUN npm install

CMD [ "npm", "start", "--silent" ]
