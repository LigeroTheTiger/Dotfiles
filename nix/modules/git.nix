{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "LigeroTheTiger";
      user.email = "ligero@ligerothetiger.com";
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
