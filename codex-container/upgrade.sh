#!/bin/bash

cd $HOME/codex-container
docker build --pull --no-cache -t codex-cli .

