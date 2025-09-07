{ pkgs, ... }: {
  virtualisation.docker.enable = true;

  programs.amnezia-vpn = {
    enable = true;
    package = pkgs.unstable.amnezia-vpn;
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "demo" "pulse" ];
  };
}
