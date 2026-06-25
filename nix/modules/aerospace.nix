{ config, pkgs, ... }:

let
  # The AeroSpace GUI launches with a minimal PATH (/usr/bin:/bin:/usr/sbin:/sbin),
  # so exec-and-forget can't resolve binaries from the nix profile. Bake absolute
  # store paths into the script (for the internal `aerospace` CLI call) and into the
  # bindings (for `focusapp` itself) so they work regardless of PATH.
  aerospace = config.programs.aerospace.package;
  focusapp = pkgs.writeShellScriptBin "focusapp" (
    builtins.replaceStrings [ "@aerospace@" ] [ "${aerospace}/bin/aerospace" ] (
      builtins.readFile ./sh/focusapp.sh
    )
  );

  # Aerospace Modifier
  hyper = "cmd-alt-ctrl";

  floatingAppIds = [
    "com.postmanlabs.mac"
    "com.apple.finder"
    "com.spotify.client"
    "com.usebruno.app"
  ];
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
      "${hyper}-period" = "layout tiles horizontal vertical";
      "${hyper}-comma" = "layout accordion horizontal vertical";
      "${hyper}-h" = "focus left";
      "${hyper}-j" = "focus down";
      "${hyper}-k" = "focus up";
      "${hyper}-l" = "focus right";
      "${hyper}-shift-h" = "move left";
      "${hyper}-shift-j" = "move down";
      "${hyper}-shift-k" = "move up";
      "${hyper}-shift-l" = "move right";
      "${hyper}-slash" = "resize smart -50";
      "${hyper}-rightSquareBracket" = "resize smart +50";
      "${hyper}-m" = "fullscreen --no-outer-gaps";
      "${hyper}-shift-m" = "macos-native-fullscreen";
      "${hyper}-f" = "layout floating tiling";
      "${hyper}-1" = "workspace 1";
      "${hyper}-2" = "workspace 2";
      "${hyper}-3" = "workspace 3";
      "${hyper}-4" = "workspace 4";
      "${hyper}-5" = "workspace 5";
      "${hyper}-6" = "workspace 6";
      "${hyper}-7" = "workspace 7";
      "${hyper}-8" = "workspace 8";
      "${hyper}-9" = "workspace 9";
      "${hyper}-shift-1" = "move-node-to-workspace 1";
      "${hyper}-shift-2" = "move-node-to-workspace 2";
      "${hyper}-shift-3" = "move-node-to-workspace 3";
      "${hyper}-shift-4" = "move-node-to-workspace 4";
      "${hyper}-shift-5" = "move-node-to-workspace 5";
      "${hyper}-shift-6" = "move-node-to-workspace 6";
      "${hyper}-shift-7" = "move-node-to-workspace 7";
      "${hyper}-shift-8" = "move-node-to-workspace 8";
      "${hyper}-shift-9" = "move-node-to-workspace 9";
      "${hyper}-tab" = "focus-back-and-forth";
      "${hyper}-shift-tab" = "move-workspace-to-monitor --wrap-around next";
      "${hyper}-a" = "mode apps";
      "${hyper}-s" = "mode service";
    };
    mode.apps.binding = {
      esc = "mode main";
      "${hyper}-b" = [
        ''exec-and-forget ${focusapp}/bin/focusapp "Firefox Developer Edition"''
        "mode main"
      ];
      "${hyper}-c" = [
        ''exec-and-forget open "/Applications/Google Chrome.app"''
        "mode main"
      ];
      "${hyper}-t" = [
        "exec-and-forget ${focusapp}/bin/focusapp kitty"
        "mode main"
      ];
      "${hyper}-a" = [
        ''exec-and-forget ${focusapp}/bin/focusapp "Android Studio"''
        "mode main"
      ];
      "${hyper}-i" = [
        ''exec-and-forget ${focusapp}/bin/focusapp "IntelliJ IDEA"''
        "mode main"
      ];
      "${hyper}-m" = [
        ''exec-and-forget open "/Applications/Thunderbird.app"''
        "mode main"
      ];
      "${hyper}-f" = [
        ''exec-and-forget ${focusapp}/bin/focusapp "Finder"''
        "mode main"
      ];
      "${hyper}-p" = [
        ''exec-and-forget ${focusapp}/bin/focusapp "Postman"''
        "mode main"
      ];
    };
    mode.service.binding = {
      esc = [
        "reload-config"
        "mode main"
      ];
      "${hyper}-r" = [
        "flatten-workspace-tree"
        "mode main"
      ];
      "${hyper}-b" = [
        "balance-sizes"
        "mode main"
      ];
      "${hyper}-h" = [
        "join-with left"
        "mode main"
      ];

      "${hyper}-j" = [
        "join-with down"
        "mode main"
      ];
      "${hyper}-k" = [
        "join-with up"
        "mode main"
      ];
      "${hyper}-l" = [
        "join-with right"
        "mode main"
      ];
    };
    on-window-detected = map (id: {
      "if".app-id = id;
      run = "layout floating";
    }) floatingAppIds;
    workspace-to-monitor-force-assignment = {
      "2" = [
        "secondary"
        "built-in"
      ];
    };
  };
}
