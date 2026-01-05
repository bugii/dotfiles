# My dotfiles :)

## Setup/Usage

To use those dotfiles on a new machine install GNU Stow first. On mac this can be done via brew:

```bash
brew install stow
```

After that, clone this repo into the home dir

Last but not least, run

```bash
stow .
```

to symlink the dotfiles to the parent directory (which is home).
Keep in mind that the structure of this repository has to match the structure the dotfiles are required to have in the home directory.

## Requirements

For all the tools to work properly you may need to install the following:

1. Terminal: wezterm
2. Shell: zsh
3. Neovim
4. Utilities: Fzf, zoxide, git, ripgrep (for file picker)
5. Package managers: npm (i would recommend installing nvm), dotnet (via dotnet-sdk)
