FROM node:23.11-slim as build

#VOLUME ["/home/node/app"]
WORKDIR /home/node/app

COPY . /home/node/app/

RUN ./scripts/build-image.sh

FROM node:23.11-slim
COPY --from=build /home/node/app/staticrypt.tgz /home/node/
COPY --from=build /home/node/app/scripts/generate-passwords.sh /usr/bin/
COPY --from=build /home/node/app/scripts/entrypoint.sh /usr/bin/
WORKDIR /home/node/
RUN npm install -g /home/node/staticrypt.tgz

ENTRYPOINT ["entrypoint.sh"]

