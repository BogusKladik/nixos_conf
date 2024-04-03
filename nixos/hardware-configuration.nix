# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9169f2f1-e015-4f6a-93c9-70b3cb0aa8c3";
    fsType = "btrfs";
    options = [ "subvol=@" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/9169f2f1-e015-4f6a-93c9-70b3cb0aa8c3";
    fsType = "btrfs";
    options = [ "subvol=@home" ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/9169f2f1-e015-4f6a-93c9-70b3cb0aa8c3";
    fsType = "btrfs";
    options = [ "subvol=@log" ];
  };

  fileSystems."/.snapshots" = {
    device = "/dev/disk/by-uuid/9169f2f1-e015-4f6a-93c9-70b3cb0aa8c3";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/1C09-1D4E";
    fsType = "vfat";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp42s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}