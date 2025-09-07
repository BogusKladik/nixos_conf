{
  imports = [ ./hardware-configuration.nix ] ++ (import ./modules);
  system.stateVersion = "25.05";
}
