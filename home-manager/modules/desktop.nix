{ lib, config, ... }: {
  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      font-name = "Roboto Condensed 11";
      document-font-name = "Roboto Condensed 11";
      # monospace-font-name = "JetBrainsMono Nerd Font Mono 10";
      accent-color = "purple";
      gtk-theme = "Adwaita-dark";
    };

    "org/gnome/desktop/wm/preferences" = {
      titlebar-font = "Roboto Condensed Bold 11";
      button-layout = "close,minimize,maximize:appmenu";
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.0;
      natural-scroll = true;
    };

    "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type =
      "nothing";

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
      night-light-temperature = lib.hm.gvariant.mkUint32 3700;
    };

    "org/gnome/mutter".edge-tiling = true;
    "org/gnome/desktop/sound".event-sounds = true;

    "org/gnome/shell" = {
      favorite-apps = [
        "google-chrome.desktop"
        "discord.desktop"
        "org.telegram.desktop.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
        "code.desktop"
        "obsidian.desktop"
        "org.gnome.TextEditor.desktop"
      ];
      enabled-extensions = [
        "appindicatorsupport@rgcjonas.gmail.com"
        "blur-my-shell@aunetx"
        "Vitals@CoreCoding.com"
        "status-area-horizontal-spacing@mathematical.coffee.gmail.com"
        "runcat@kolesnikov.se"
        "top-bar-organizer@julian.gse.jsts.xyz"
      ];
      disabled-extensions = [ ];
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      color-and-noise = false;
      sigma = 0;
      brightness = 0.6;
    };
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      blur = true;
      customize = true;
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

    "org/gnome/shell/extensions/runcat" = {
      displaying-items = "character-and-percentage";
      idle-threshold = 11;
    };

    "org/gnome/shell/extensions/top-bar-organizer" = {
      left-box-order = [ "activities" ];
      center-box-order = [ "dateMenu" ];
      right-box-order = [
        "runcat-indicator"
        "vitalsMenu"
        "screenRecording"
        "screenSharing"
        "dwellClick"
        "a11y"
        "keyboard"
        "quickSettings"
      ];
    };

    "org/gnome/desktop/background" = {
      picture-uri = "${config.home.homeDirectory}/.background";
      picture-uri-dark = "${config.home.homeDirectory}/.background";
      color-shading-type = "solid";
      picture-options = "zoom";
    };
    "org/gnome/desktop/screensaver" = {
      color-shading-type = "solid";
      picture-options = "zoom";
      picture-uri = "${config.home.homeDirectory}/.background";
    };
  };
}
