ARG BASE_VERSION=latest
FROM browserless/base:${BASE_VERSION}

# Application parameters and variables
ENV APP_DIR=/usr/src/app
ENV CONNECTION_TIMEOUT=480000
ENV HOST=0.0.0.0
ENV IS_DOCKER=true
ENV LANG="C.UTF-8"
ENV NODE_ENV=production
ENV PORT=3000
ENV WORKSPACE_DIR=$APP_DIR/workspace

RUN mkdir -p $APP_DIR $WORKSPACE_DIR

WORKDIR $APP_DIR

# Install app dependencies
COPY . .

RUN npm ci && npm run postinstall && npm run build && npm prune --production && chown -R blessuser:blessuser $APP_DIR

# Run everything after as non-privileged user.
USER blessuser

# Expose the web-socket and HTTP ports
EXPOSE 3000

CMD ["./start.sh"]
