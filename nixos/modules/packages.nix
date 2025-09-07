{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    neofetch
    vulkan-tools
    nerd-fonts.jetbrains-mono
  ];
}
