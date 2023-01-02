FROM node:16.10.0-alpine AS builder

WORKDIR /workspace

COPY package.json /workspace/
COPY yarn.lock /workspace/

RUN yarn install --immutable --production=true

COPY . /workspace

FROM node:16.10.0-alpine AS runner

WORKDIR /workspace
RUN chown node:node /workspace

ENV PORT=3000

EXPOSE 3000

COPY --from=builder --chown=node /workspace/node_modules ./node_modules
COPY --from=builder --chown=node /workspace/package.json ./
COPY --from=builder --chown=node /workspace/index.js ./index.js

USER node

CMD ["node", "index.js"]

