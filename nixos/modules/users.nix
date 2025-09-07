{ pkgs, ... }: {
  users.users.boguskladik = {
    isNormalUser = true;
    initialPassword = "123";
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
    packages = with pkgs; [ firefox telegram-desktop ];
  };

  programs.fish.enable = true;
}
