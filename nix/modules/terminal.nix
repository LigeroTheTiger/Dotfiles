{ pkgs, ... }:

let
  kittyGrab = pkgs.fetchFromGitHub {
    owner = "yurikhan";
    repo = "kitty_grab";
    rev = "969e363295b48f62fdcbf29987c77ac222109c41";
    hash = "sha256-DamZpYkyVjxRKNtW5LTLX1OU47xgd/ayiimDorVSamE=";
  };
in
{

  xdg.configFile."kitty/kitty_grab".source = kittyGrab;
  xdg.configFile."kitty/grab.conf".source = "${kittyGrab}/grab-vim.conf.example";
  # yes im using a background image, no i dont care
  xdg.configFile."kitty/background.png".source = ../assets/space.png;

  programs.kitty = {
    enable = true;
    enableGitIntegration = true;
    shellIntegration.enableZshIntegration = true;

    themeFile = "DarkOneNuanced";

    font.name = "JetBrainsMono Nerd Font";
    font.package = pkgs.jetbrains-mono;
    font.size = 15;

    actionAliases = {
      launch_tab = "launch --cwd=last_reported --type=tab";
      edit_config = "launch --type=tab \"$EDITOR\" ~/.config/kitty/kitty.conf";
      reload_config = "combine : load_config_file : launch --type=overlay sh -c 'echo \"kitty config reloaded.\"; echo; read -r -p \"Press Enter to exit\"; echo \"\"'";
      launch_v_split = "launch --location=vsplit --cwd=last_reported";
      launch_h_split = "launch --location=hsplit --cwd=last_reported";
    };

    keybindings = {
      "ctrl+a>x" = "close_window";
      "ctrl+a>]" = "next_window";
      "ctrl+a>[" = "previous_window";
      "ctrl+a>c" = "launch_tab";
      "ctrl+a>," = "set_tab_title";
      "ctrl+plus" = "change_font_size all +2.0";
      "ctrl+kp_add" = "change_font_size all +2.0";
      "ctrl+minus" = "change_font_size all -2.0";
      "ctrl+kp_subtract" = "change_font_size all -2.0";
      "ctrl+0" = "change_font_size all 0";
      "ctrl+a>shift+e" = "edit_config";
      "ctrl+a>shift+r" = "reload_config";
      "ctrl+a>shift+d" = "debug_config";
      "ctrl+a>." = "launch_v_split";
      "ctrl+a>-" = "launch_h_split";
      "ctrl+z" = "resize_window narrower";
      "ctrl+o" = "resize_window wider";
      "ctrl+u" = "resize_window taller";
      "ctrl+i" = "resize_window shorter";
      "ctrl+h" = "neighboring_window left";
      "ctrl+l" = "neighboring_window right";
      "ctrl+j" = "neighboring_window down";
      "ctrl+k" = "neighboring_window up";
      "ctrl+a>q" = "close_window";
      "ctrl+a>s" = "kitten kitty_grab/grab.py";
      "ctrl+a>m" = "toggle_layout stack";
    };

    settings = {
      window_margin_width = 5;
      single_window_margin_width = 5;
      background_image = "background.png";
      background_image_layout = "scaled";
      background_tint = 0.95;
      background_tint_gaps = -10;

      active_border_color = "#00ffff";
      window_border_width = "2 pt";
      tab_title_template = "{fmt.fg.red}{bell_symbol}{activity_symbol}{fmt.fg.tab}{index: }{title}";
      scrollback_lines = "8000";
      show_hyperlink_targets = "always";
      underline_hyperlinks = "always";
      enabled_layouts = "splits,stack";
      notify_on_cmd_finish = "invisible 10.0";
      tab_bar_style = "powerline";
      tab_powerline_style = "round";
      dynamic_background_opacity = "yes";
      allow_remote_control = "yes";
    };
  };
}
