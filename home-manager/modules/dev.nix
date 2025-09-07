{ pkgs, ... }: {
  home.packages = with pkgs; [
    # Java/Build
    jdk
    maven

    # Node
    yarn

    # Rust toolchain
    unstable.rustup
    unstable.diesel-cli
    unstable.gcc
    unstable.cmake
    unstable.clang-tools
    unstable.ninja
    unstable.meson
    unstable.pkg-config

    # DB/Net
    pgadmin4-desktopmode
    tcpdump
    nmap

    # Nix tooling
    nil
    nixfmt-classic

    # Utils
    ripgrep
    tree
    gdu
    pciutils
    usbutils
    powertop
  ];
}
