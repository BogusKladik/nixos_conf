# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ outputs, config, pkgs, lib, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    overlays = [ outputs.overlays.unstable-packages ];
    config.allowUnfree = true;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];

    auto-optimise-store = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = false;

    forceFullCompositionPipeline = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    # package = config.boot.kernelPackages.nvidiaPackages.stable;
    # lib.fakeSha256
    package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      version = "560.35.03"; 
      sha256_64bit = "sha256-8pMskvrdQ8WyNBvkU/xPc/CtcYXCa7ekP73oGuKfH+M=";
      sha256_aarch64 = lib.fakeSha256;
      openSha256 = lib.fakeSha256;
      settingsSha256 = "sha256-kQsvDgnxis9ANFmwIwB7HX5MkIAcpEEAHc8IBOLdXvk=";
      persistencedSha256 = lib.fakeSha256;
    };
  };

  networking.hostName = "NixOS-PC"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable =
    true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";
  console = {
    earlySetup = true;
    packages = with pkgs; [ terminus_font ];
    #   font = "Lat2-Terminus16";
    font = "ter-v16n";
    keyMap = "ru";
    #    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:win_space_toggle";
  };
  #services.xserver.xkb.layout = "us,ru";
  #services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        alsa = {
          "monitor.alsa.rules" = [
            {
              matches = [
                { "node.name" = "alsa_card.*"; }
              ];
              actions = {
                update-props = {
                  "api.alsa.use-acp" = true;
                  "api.alsa.use-ucm" = true;
                  "audio.format" = "S16LE";
                  "audio.rate" = 48000;
                };
              };
            }
          ];
        };
      };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [{
    users = [ "boguskladik" ];
    # Optional, retains environment variables while running commands 
    # e.g. retains your NIX_PATH when applying your config
    keepEnv = true;
    persist = true; # Optional, only require password verification a single time
  }];

  programs.fish.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.boguskladik = {
    initialPassword = "123";
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
    packages = with pkgs; [
      firefox
      #discord
      #vesktop
      telegram-desktop
      #    tree
    ];
  };
  
  programs.gamemode.enable = true;

  # Autologin
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "boguskladik";

  # For autologin work correct
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #   wget
    neofetch
    vulkan-tools
    nerdfonts
  ];

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "demo" "pulse" ];
  };


  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}

