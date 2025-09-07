{ pkgs, ... }: {
  home.packages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.appindicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.status-area-horizontal-spacing
    gnomeExtensions.runcat
    gnomeExtensions.top-bar-organizer

    spotify
    drawing
    pavucontrol
    easyeffects
    discord
    vesktop
    onlyoffice-bin
    google-chrome
    obs-studio
    dconf-editor
    roboto
    nerd-fonts.jetbrains-mono
    (unstable.jetbrains.webstorm.override { jdk = pkgs.openjdk21; })
    prismlauncher
    virtualbox
    qemu
    cdrtools
    unstable.postman
    pulseaudio
  ];
}
