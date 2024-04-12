{ outputs, pkgs, lib, ... }:

let plugins = (import ./vscode_plugins.nix) { inherit pkgs lib; };
in rec {
  home.username = "boguskladik";
  home.homeDirectory = "/home/boguskladik";

  nixpkgs = { overlays = [ outputs.overlays.unstable-packages ]; };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    enableUpdateCheck = true; # false
    enableExtensionUpdateCheck = true; # false
    mutableExtensionsDir = true; # false
    # extensions = [
    #   plugins.jnoortheen.nix-ide
    #   plugins.rust-lang.rust-analyzer
    #   plugins.arrterian.nix-env-selector
    #   plugins.tamasfe.even-better-toml
    #   plugins.equinusocio.vsc-material-theme
    #   plugins.pkief.material-icon-theme
    #   plugins.nerg.clips-lang
    # ];
    # userSettings = {
    #   "nix.enableLanguageServer" = true;
    #   "nix.serverPath" = "nil";
    #   "workbench.colorTheme" = "Material Theme Darker High Contrast";
    #   "workbench.iconTheme" = "material-icon-theme";
    #   "rust-analyzer.check.command" = "clippy";
      # "rust-analyzer.cargo.sysroot" = "${pkgs.rustc}/lib/rustlib/rustc-src/";
    # };
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        font-name = "Roboto Condensed 11";
        document-font-name = "Roboto Condensed 11";
        monospace-font-name = "JetBrainsMono Nerd Font 10";
      };
      "org/gnome/desktop/wm/preferences" = {
        titlebar-font = "Roboto Condensed Bold 11";
        button-layout = "close,minimize,maximize:appmenu";
      };
      "org/gnome/desktop/interface".gtk-theme = "Adwaita-dark";
      "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type =
        "nothing";
      "org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-schedule-automatic = true;
        night-light-temperature = lib.hm.gvariant.mkUint32 3700;
      };
      "org/gnome/desktop/peripherals/mouse".natural-scroll = true;
      "org/gnome/mutter".edge-tiling = true;
      "org/gnome/shell".enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "Vitals@CoreCoding.com"
        "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
        "runcat@kolesnikov.se"
      ];
      "org/gnome/shell/extensions/blur-my-shell" = {
        color-and-noise = false;
        sigma = 0;
        brightness = 0.6;
      };
      "org/gnome/shell/extensions/blur-my-shell/overview" = {
        blur = true;
        style-components = 3;
        sigma = 44;
        brightness = 0.54;
      };
      "org/gnome/shell/extensions/blur-my-shell/appfolder".blur = false;
      "org/gnome/shell/extensions/blur-my-shell/applications".blur = false;
      "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
        blur = true;
        customize = true;
        sigma = 11;
        brightness = 0.6;
      };
      "org/gnome/shell/extensions/blur-my-shell/screenshot".blur = true;
      "org/gnome/desktop/background" = {
        picture-uri = "${home.homeDirectory}/.background";
        picture-uri-dark = "${home.homeDirectory}/.background";
        color-shading-type = "solid";
        picture-options = "zoom";
      };
      "org/gnome/shell/extensions/runcat" = {
        displaying-items = "character-and-percentage";
        idle-threshold = 11;
      };
      "org/gnome/desktop/screensaver" = {
        color-shading-type = "solid";
        picture-options = "zoom";
        picture-uri = "${home.homeDirectory}/.background";
      };
    };
  };

  programs.git = {
    enable = true;
    userName = "Bogus Kladik";
    userEmail = "boguskladik@gmail.com";
  };

  programs.helix = { enable = true; };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # wpsoffice
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.status-area-horizontal-spacing
    # gnomeExtensions.control-blur-effect-on-lock-screen

    discord
    # webcord
    unstable.obsidian
    onlyoffice-bin
    unstable.postman
    pgadmin4-desktopmode
    # jetbrains.jdk
    jdk
    maven
    unstable.yandex-browser
    google-chrome
    gnome.dconf-editor
    roboto
    nerdfonts

    # unstable.uwufetch

    minecraft

    # this is incorrect for declorative but its work, need check work in shell.nix
    unstable.rustup
    unstable.diesel-cli
    # unstable.rustc
    # unstable.cargo
    # unstable.clippy
    unstable.gcc

    clips

    nil
    nixfmt
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".background".source = ../resources/wp1.png;
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/boguskladik/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

