#!/usr/bin/env bash
set -euo pipefail

[[ "${DEBUG:-}" == "true" ]] && set -x

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SYMLINK_PATH="${HOME}/dotfiles"
BASHRC="${HOME}/.bashrc"
SOURCE_LINE="source ${SYMLINK_PATH}/sourceme"

create_symlink() {
    if [[ -L "${SYMLINK_PATH}" ]]; then
        local current_target
        current_target="$(readlink "${SYMLINK_PATH}")"
        if [[ "${current_target}" == "${DOTFILES_DIR}" ]]; then
            echo "Symlink already exists and points to the correct location."
            return
        fi
        echo "Symlink exists but points to ${current_target}. Updating..."
        rm "${SYMLINK_PATH}"
    elif [[ -e "${SYMLINK_PATH}" ]]; then
        echo "Error: ${SYMLINK_PATH} exists and is not a symlink. Remove it manually."
        exit 1
    fi

    ln -s "${DOTFILES_DIR}" "${SYMLINK_PATH}"
    echo "Created symlink: ${SYMLINK_PATH} -> ${DOTFILES_DIR}"
}

add_to_bashrc() {
    if grep -qF "${SOURCE_LINE}" "${BASHRC}" 2>/dev/null; then
        echo "Source line already present in ${BASHRC}."
        return
    fi

    printf '\n%s\n' "${SOURCE_LINE}" >> "${BASHRC}"
    echo "Added source line to ${BASHRC}."
}

configure_gitignore_global() {
    local gitignore_path="${DOTFILES_DIR}/gitignore_global"
    local current
    current="$(git config --global core.excludesFile 2>/dev/null || true)"

    if [[ "${current}" == "${gitignore_path}" ]]; then
        echo "Global gitignore already configured."
        return
    fi

    if [[ -n "${current}" ]]; then
        echo "Note: overriding existing core.excludesFile (was: ${current})."
    fi

    git config --global core.excludesFile "${gitignore_path}"
    echo "Set global gitignore to ${gitignore_path}."
}

main() {
    echo "Installing dotfiles from ${DOTFILES_DIR}..."
    create_symlink
    add_to_bashrc
    configure_gitignore_global
    echo "Done. Restart your shell or run: source ${BASHRC}"
}

main
