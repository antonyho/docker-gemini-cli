FROM node:current-slim

ENV WORKSPACE="/workspace"
ENV GEMINI_CLI_HOME="$WORKSPACE/.gemini-cfg"
WORKDIR $WORKSPACE
RUN npm install -g @google/gemini-cli

CMD [ "gemini" ]
