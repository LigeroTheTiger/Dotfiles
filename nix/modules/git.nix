{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "LigeroTheTiger";
      user.email = "42996211+LigeroTheTiger@users.noreply.github.com";
      color.ui = "auto";
      core.autocrlf = "input";
      gpg.format = "ssh";
      init.defaultBranch = "main";
    };
    # Keeping my wok stuff private
    includes = [
      {
        condition = "gitdir:~/Desktop/Projects/business/**";
        path = "~/.config/.gitconfig-business";
      }
    ];
    signing = {
      key = "/Users/ligero/.ssh/id_rsa";
      signByDefault = true;
    };
  };
}
