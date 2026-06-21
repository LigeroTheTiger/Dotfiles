# Ligeros dotfiles

My personal macOS setup. The idea is to let Nix generate as much as possible so I can rebuild a machine from scratch without fiddling around.

## What's in here

- **nix/** - the whole system, managed with [nix-darwin](https://github.com/nix-darwin/nix-darwin) + [home-manager](https://github.com/nix-community/home-manager)
  - `flake.nix` - system packages, homebrew casks, macOS defaults
  - `home.nix` - user packages, fonts, direnv
  - `modules/` - split-out config for shell, git, terminal (oh-my-posh), aerospace, nvim
- **nvim/** - my Neovim config (still managed the old-fashioned way for now)

## Stuff I use

- Neovim as editor
- zsh + oh-my-posh prompt
- aerospace as tiling window manager

## Rebuild

```sh
darwin-rebuild switch --flake ./nix#Ligeros
```

## TODO

- [ ] Move the Neovim config into Nix, probably try out nixvim
