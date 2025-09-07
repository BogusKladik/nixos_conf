{
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
    steam-hardware.enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];
  environment.sessionVariables.AMD_VULKAN_ICD = "RADV";
}
