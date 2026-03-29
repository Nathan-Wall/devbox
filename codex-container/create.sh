#!/bin/bash

sudo tee /usr/local/bin/codex-docker >/dev/null <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

IMAGE="${CODEX_IMAGE:-codex-cli}"
repo_root="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
repo_id="$(printf '%s' "$repo_root" | sha256sum | cut -c1-12)"
CODEX_HOME_DIR="${CODEX_HOME_DIR:-$HOME/.codex-docker/$repo_id}"

mkdir -p "$CODEX_HOME_DIR"

CONFIG_FILE="$CODEX_HOME_DIR/config.toml"
if [ ! -f "$CONFIG_FILE" ]; then
  cat > "$CONFIG_FILE" <<'CFG'
cli_auth_credentials_store = "file"
approval_policy = "never"
sandbox_mode = "danger-full-access"
CFG
else
  ensure_setting() {
    local key="$1"
    local value="$2"
    if ! grep -qE "^${key}[[:space:]]*=" "$CONFIG_FILE"; then
      printf '%s = %s\n' "$key" "$value" >> "$CONFIG_FILE"
    fi
  }

  ensure_setting "cli_auth_credentials_store" '"file"'
  ensure_setting "approval_policy" '"never"'
  ensure_setting "sandbox_mode" '"danger-full-access"'
fi

if project_root="$(git rev-parse --show-toplevel 2>/dev/null)"; then
  :
else
  project_root="$PWD"
fi

if [ "$PWD" = "$project_root" ]; then
  container_workdir="/workspace"
else
  rel_path="${PWD#"$project_root"/}"
  container_workdir="/workspace/$rel_path"
fi

mount_args=(
  --mount "type=bind,src=$CODEX_HOME_DIR,dst=/codex-home"
  --mount "type=bind,src=$project_root,dst=/workspace"
)

if [ -f "$HOME/.gitconfig" ]; then
  mount_args+=(--mount "type=bind,src=$HOME/.gitconfig,dst=/codex-home/.gitconfig,readonly")
fi

env_args=(
  -e HOME=/codex-home
  -e CODEX_HOME=/codex-home
)

# Optional: uncomment these lines if you want the container to use your SSH agent
# for git push/pull. Be aware this expands the trust boundary.
# if [ -n "${SSH_AUTH_SOCK:-}" ] && [ -S "$SSH_AUTH_SOCK" ]; then
#   mount_args+=(--mount "type=bind,src=$SSH_AUTH_SOCK,dst=/ssh-agent")
#   env_args+=( -e SSH_AUTH_SOCK=/ssh-agent )
# fi

exec docker run --rm -it \
  --init \
  --user "$(id -u):$(id -g)" \
  "${env_args[@]}" \
  "${mount_args[@]}" \
  -w "$container_workdir" \
  "$IMAGE" \
  codex "$@"
EOF

sudo chmod +x /usr/local/bin/codex-docker

docker build --pull --no-cache -t codex-cli .

