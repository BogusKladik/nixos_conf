{
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    xkb = {
      layout = "us,ru";
      options = "grp:win_space_toggle";
    };
  };
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
