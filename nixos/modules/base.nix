{ pkgs, ... }: {
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "ru_RU.UTF-8";

  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    font = "ter-v16n";
    keyMap = "ru";
  };
}
