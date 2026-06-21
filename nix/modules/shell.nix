{ config, pkgs, ... }:

let
  b64ToPdf = pkgs.writeShellScriptBin "b64ToPdf" (builtins.readFile ./sh/b64ToPdf.sh);
in
{

  home.packages = [ b64ToPdf ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 5000;
      path = "${config.home.homeDirectory}/.zsh_history";

      share = true;
      ignoreDups = true;
      ignoreSpace = true;
      saveNoDups = true;
      expireDuplicatesFirst = true;
    };

    initContent = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"

      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^[[A' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[[B' history-search-forward

      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' 'menu no'
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' 
      zstyle ':fzf-tab_complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      . "$HOME/.local/bin/env"

    '';

    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "master";
          hash = "sha256-YhTSu0P7mFlVx1zBvbT0jNstkamcZHhPYJHKMAHgyuM=";
        };
      }
    ];
  };

  programs.oh-my-posh = {
    enable = true;
    enableZshIntegration = true;
    configFile = ../assets/theme.omp.json;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd"
      "cd"
    ];
  };
}
