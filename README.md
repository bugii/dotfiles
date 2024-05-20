# My dotfiles :)

## Setup/Usage

To use those dotfiles on a new machine install GNU Stow first. On mac this can be done via brew:

```bash
brew install stow
```

After that, clone this repo into ~/.dotfiles

Last but not least, run

```bash
stow .
```

to symlink the dotfiles to the parent directory (which is home).
Keep in mind that the structure of this repository has to match the structure the dotfiles are required to have in the home directory.

## Requirements

For all the tools to work properly you may need to install the following:

1. Terminal: Kitty
2. Shell: zsh
3. Tmux, and tpm (tmux plugin manager).
4. Neovim
5. Utilities: Fzf, git
