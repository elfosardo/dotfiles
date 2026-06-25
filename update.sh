#!/usr/bin/env bash
set -euo pipefail

[[ "${DEBUG:-}" == "true" ]] && set -x

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_URL="https://raw.githubusercontent.com/git/git/master/contrib/completion"

FILES=(
    "git-prompt.sh"
    "git-completion.bash"
)

main() {
    echo "Updating upstream git completion files..."

    for file in "${FILES[@]}"; do
        local target="${DOTFILES_DIR}/bash/${file}"
        echo "  Downloading ${file}..."
        if curl -fsSL "${BASE_URL}/${file}" -o "${target}"; then
            echo "  Updated ${target}"
        else
            echo "  Error: failed to download ${file}" >&2
            exit 1
        fi
    done

    echo "Done. Restart your shell to use the updated files."
}

main
