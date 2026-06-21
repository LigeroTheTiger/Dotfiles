{ config, pkgs, ... }:

let
  focusapp = pkgs.writeShellScriptBin "focusapp" (builtins.readFile ./sh/focusapp.sh);
in
{
  home.packages = [
    focusapp
  ];

  programs.aerospace.enable = true;
  programs.aerospace.launchd.enable = true;
  programs.aerospace.settings = {
    after-startup-command = [
      "workspace 2"
      "workspace 1"
    ];
    enable-normalization-flatten-containers = true;
    enable-normalization-opposite-orientation-for-nested-containers = true;
    default-root-container-layout = "tiles";
    accordion-padding = 100;
    default-root-container-orientation = "auto";
    on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
    automatically-unhide-macos-hidden-apps = false;
    key-mapping.preset = "qwerty";
    gaps = {
      inner.horizontal = 10;
      inner.vertical = 10;
      outer.left = 10;
      outer.bottom = 10;
      outer.top = 10;
      outer.right = 10;
    };
    mode.main.binding = {
      cmd-alt-ctrl-period = "layout tiles horizontal vertical";
      cmd-alt-ctrl-comma = "layout accordion horizontal vertical";
      cmd-alt-ctrl-h = "focus left";
      cmd-alt-ctrl-j = "focus down";
      cmd-alt-ctrl-k = "focus up";
      cmd-alt-ctrl-l = "focus right";
      cmd-alt-ctrl-shift-h = "move left";
      cmd-alt-ctrl-shift-j = "move down";
      cmd-alt-ctrl-shift-k = "move up";
      cmd-alt-ctrl-shift-l = "move right";
      cmd-alt-ctrl-slash = "resize smart -50";
      cmd-alt-ctrl-rightSquareBracket = "resize smart +50";
      cmd-alt-ctrl-m = "fullscreen --no-outer-gaps";
      cmd-alt-ctrl-shift-m = "macos-native-fullscreen";
      cmd-alt-ctrl-f = "layout floating tiling";
      cmd-alt-ctrl-1 = "workspace 1";
      cmd-alt-ctrl-2 = "workspace 2";
      cmd-alt-ctrl-3 = "workspace 3";
      cmd-alt-ctrl-4 = "workspace 4";
      cmd-alt-ctrl-5 = "workspace 5";
      cmd-alt-ctrl-6 = "workspace 6";
      cmd-alt-ctrl-7 = "workspace 7";
      cmd-alt-ctrl-8 = "workspace 8";
      cmd-alt-ctrl-9 = "workspace 9";
      cmd-alt-ctrl-shift-1 = "move-node-to-workspace 1";
      cmd-alt-ctrl-shift-2 = "move-node-to-workspace 2";
      cmd-alt-ctrl-shift-3 = "move-node-to-workspace 3";
      cmd-alt-ctrl-shift-4 = "move-node-to-workspace 4";
      cmd-alt-ctrl-shift-5 = "move-node-to-workspace 5";
      cmd-alt-ctrl-shift-6 = "move-node-to-workspace 6";
      cmd-alt-ctrl-shift-7 = "move-node-to-workspace 7";
      cmd-alt-ctrl-shift-8 = "move-node-to-workspace 8";
      cmd-alt-ctrl-shift-9 = "move-node-to-workspace 9";
      cmd-alt-ctrl-tab = "focus-back-and-forth";
      cmd-alt-ctrl-shift-tab = "move-workspace-to-monitor --wrap-around next";
      cmd-alt-ctrl-a = "mode apps";
      cmd-alt-ctrl-s = "mode service";
    };
    # TODO: for some reason this entire mode is not working correctly
    mode.apps.binding = {
      esc = "mode main";
      cmd-alt-ctrl-b = [
        ''exec-and-forget focusapp "Firefox Developer Edition"''
        "mode main"
      ];
      cmd-alt-ctrl-c = [
        ''exec-and-forget open "/Applications/Google Chrome.app"''
        "mode main"
      ];
      cmd-alt-ctrl-t = [
        "exec-and-forget focusapp kitty"
        "mode main"
      ];
      cmd-alt-ctrl-a = [
        ''exec-and-forget focusapp "Android Studio"''
        "mode main"
      ];
      cmd-alt-ctrl-i = [
        ''exec-and-forget focusapp "IntelliJ IDEA"''
        "mode main"
      ];
      cmd-alt-ctrl-m = [
        ''exec-and-forget open "/Applications/Thunderbird.app"''
        "mode main"
      ];
      cmd-alt-ctrl-f = [
        ''exec-and-forget focusapp "Finder"''
        "mode main"
      ];
      cmd-alt-ctrl-p = [
        ''exec-and-forget focusapp "Postman"''
        "mode main"
      ];
    };
    mode.service.binding = {
      esc = [
        "reload-config"
        "mode main"
      ];
      cmd-alt-ctrl-r = [
        "flatten-workspace-tree"
        "mode main"
      ];
      cmd-alt-ctrl-b = [
        "balance-sizes"
        "mode main"
      ];
      cmd-alt-ctrl-h = [
        "join-with left"
        "mode main"
      ];

      cmd-alt-ctrl-j = [
        "join-with down"
        "mode main"
      ];
      cmd-alt-ctrl-k = [
        "join-with up"
        "mode main"
      ];
      cmd-alt-ctrl-l = [
        "join-with right"
        "mode main"
      ];
    };
    on-window-detected = [
      {
        "if".app-id = "com.postmanlabs.mac";
        run = "layout floating";
      }
      {
        "if".app-id = "com.apple.finder";
        run = "layout floating";
      }
      {
        "if".app-id = " com.spotify.client";
        run = "layout floating";
      }
    ];
    workspace-to-monitor-force-assignment = {
      "2" = [
        "secondary"
        "built-in"
      ];
    };
  };
}
