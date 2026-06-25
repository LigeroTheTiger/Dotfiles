{
  description = "Ligero's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      mac-app-util,
      home-manager,
      nixpkgs,
    }:
    let
      configuration = { pkgs, config, ... }: {

        nixpkgs.config.allowUnfree = true;
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget

        environment.systemPackages = [
          pkgs.neovim
          pkgs.ffmpeg
          pkgs.mkalias
          pkgs.keepassxc
          pkgs.telegram-desktop
          pkgs.ripgrep
          pkgs.zoxide
          pkgs.lazygit
          pkgs.wireguard-go
          pkgs.wireguard-tools
          pkgs.tree-sitter
          pkgs.lua51Packages.tree-sitter-cli
          pkgs.claude-code
          pkgs.google-chrome
          pkgs.discord
          pkgs.spotify
          pkgs.postman
          pkgs.bruno
          pkgs.betterdisplay
          pkgs.android-tools
          pkgs.docker
          pkgs.docker-compose
          pkgs.git
          pkgs.mas
          pkgs.openconnect
          pkgs.imagemagick
          pkgs.jetbrains.idea
          pkgs.proton-vpn
        ];

        homebrew.enable = true;
        homebrew.casks = [
          "hyperkey"
          "docker-desktop"
          "thunderbird"
          "android-studio"
          "proton-drive"
          "affinity"
          "tailscale-app"
          "raycast"
          "mattermost"
          "seafile-client"
          "nextcloud"
        ];

        homebrew.masApps = {
          Wireguard = 1451685025;
        };

        homebrew.onActivation.cleanup = "zap";

        users.users.ligero.home = "/var/empty";
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.ligero = import ./home.nix;

        environment.variables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };

        environment.shellAliases = {
          mci = "mvn clean install";
          dcu = "docker compose up -d";
          dcd = "docker compose down";
          dps = "docker ps";
          rebuild-system = "sudo darwin-rebuild switch --flake ~/.config/nix#Ligeros";
          upgrade-system = "sudo nix flake update --flake ~/.config/nix && rebuild-system";
        };

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";
        nix.settings.auto-optimise-store = true;

        networking.knownNetworkServices = [
          "USB 10/100/1000 LAN"
          "AX88179A"
          "Thunderbolt Bridge"
          "Wi-Fi"
        ];

        networking.dns = [
          "192.168.2.124"
          "1.1.1.1"
          "8.8.8.8"
        ];

        # Enable alternative shell support in nix-darwin.
        #programs.zsh.enableAutosuggestions = true;
        #programs.zsh.enableBashCompletion = true;
        #programs.zsh.enableCompletion = true;
        #programs.zsh.enableFastSyntaxHighlighting = true;
        #programs.zsh.enableFzfCompletion = true;
        #programs.zsh.enableFzfGit = true;
        #programs.zsh.enableGlobalCompInit = true;
        #programs.zsh.histSize = 5000;

        #services.aerospace.enable = true;

        security.pam.services.sudo_local.touchIdAuth = true;

        services.jankyborders.enable = true;
        services.jankyborders.active_color = "0xFF10C0E3";

        system.primaryUser = "ligero";
        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 6;

        system.defaults.".GlobalPreferences"."com.apple.mouse.scaling" = 1.0;
        system.defaults.NSGlobalDomain.AppleIconAppearanceTheme = "RegularDark";
        system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
        system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
        system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
        system.defaults.controlcenter.BatteryShowPercentage = true;
        system.defaults.dock.autohide = true;
        system.defaults.dock.magnification = false;
        system.defaults.finder.AppleShowAllFiles = true;
        system.defaults.finder.FXPreferredViewStyle = "Nlsv";
        system.defaults.finder.NewWindowTarget = "Recents";
        system.defaults.finder.ShowPathbar = true;
        #system.defaults.loginwindow.LoginwindowText = "Ligero";
        system.defaults.menuExtraClock.FlashDateSeparators = true;
        system.defaults.menuExtraClock.Show24Hour = true;
        system.defaults.menuExtraClock.ShowDate = 1;
        system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
        system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
        system.defaults.NSGlobalDomain."com.apple.trackpad.scaling" = 1.5;
        system.defaults.loginwindow.GuestEnabled = false;
        system.defaults.WindowManager.GloballyEnabled = false;
        system.defaults.WindowManager.HideDesktop = true;
        system.defaults.WindowManager.AutoHide = false;
        system.defaults.WindowManager.AppWindowGroupingBehavior = false;
        system.defaults.trackpad.Clicking = false;
        system.defaults.trackpad.TrackpadThreeFingerDrag = false;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#simple
      darwinConfigurations."Ligeros" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        modules = [
          configuration
          home-manager.darwinModules.home-manager
          mac-app-util.darwinModules.default
        ];
      };

      darwinPackages = self.darwinConfigurations."Ligeros".pkgs;
    };
}
