{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.stylua
    pkgs.prettierd
    pkgs.clang-tools
    pkgs.ktfmt
    pkgs.xmlformat
    pkgs.black
    pkgs.isort
    pkgs.pylint
    pkgs.jsonfmt
    pkgs.vscode-langservers-extracted
    pkgs.svelte-language-server
    pkgs.emmet-ls
    pkgs.pyright
    pkgs.lua-language-server
    pkgs.rust-analyzer
    pkgs.beamPackages.expert
    pkgs.kotlin-language-server
    pkgs.prettierd
    pkgs.jdt-language-server
    pkgs.google-java-format
    pkgs.nixd
    pkgs.nixfmt
    pkgs.bash-language-server
    pkgs.shfmt
  ];
}
