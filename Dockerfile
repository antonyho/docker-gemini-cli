FROM node:current-slim

RUN npm install -g @google/gemini-cli

CMD [ "gemini" ]