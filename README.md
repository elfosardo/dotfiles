# dotfiles

Bash configuration files for git shell integration (prompt, completion, environment).

## Installation

Clone the repo anywhere and run the install script:

```bash
git clone git@github.com:elfosardo/dotfiles.git ~/git-repos/github/dotfiles
~/git-repos/github/dotfiles/install.sh
```

This will:

- Create a `~/dotfiles` symlink pointing to the repo
- Add `source ~/dotfiles/sourceme` to your `~/.bashrc`

Restart your shell or run `source ~/.bashrc` to activate.

## What's included

- **bash/git-env.bash** — git prompt environment variables (dirty state, untracked files, upstream info)
- **bash/git-prompt.sh** — `__git_ps1` function from [git/git contrib](https://github.com/git/git/tree/master/contrib/completion)
- **bash/git-completion.bash** — git tab-completion from the same upstream source
- **bash/bash_prompt** — custom `PROMPT_COMMAND` showing virtualenv, user@host, cwd, and git branch/status
- **gitignore_global** — global gitignore rules
