{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "ligero";
  home.homeDirectory = lib.mkForce "/Users/ligero";
  home.stateVersion = "26.05";

  imports = [
    ./modules/nvim.nix
    ./modules/git.nix
    ./modules/terminal.nix
    ./modules/shell.nix
    ./modules/aerospace.nix
  ];

  home.packages = [
    pkgs.fzf
    pkgs.direnv
    pkgs.fira-code
    pkgs.fira-math
    pkgs.jetbrains-mono
    pkgs.nerd-fonts.hack
    pkgs.montserrat
  ];

  fonts.fontconfig.enable = true;

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

}
