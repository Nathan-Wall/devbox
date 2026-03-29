FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git ripgrep ca-certificates openssh-client procps \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g @openai/codex@latest

WORKDIR /workspace
ENV CODEX_HOME=/codex-home

CMD ["codex"]

