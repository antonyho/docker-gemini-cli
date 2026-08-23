FROM node:current-slim

ARG GEMINI_CLI_VERSION=latest

ENV WORKSPACE="/workspace"
ENV GEMINI_CLI_HOME="$WORKSPACE/.gemini-cfg"
WORKDIR $WORKSPACE
RUN npm install -g @google/gemini-cli@${GEMINI_CLI_VERSION#v}

CMD [ "gemini" ]

