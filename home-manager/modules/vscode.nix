{ pkgs, lib, ... }:
let plugins = (import ../vscode_plugins.nix) { inherit pkgs lib; };
in {
  programs.vscode = {
    enable = true;
    package = pkgs.unstable.vscode;
    # enableUpdateCheck = true; # false
    profiles.default.enableUpdateCheck = true;
    profiles.default.enableExtensionUpdateCheck = true;
    # enableExtensionUpdateCheck = true; # false
    mutableExtensionsDir = true; # false
    # extensions = [
    #   plugins.jnoortheen.nix-ide
    #   plugins.rust-lang.rust-analyzer
    #   plugins.arrterian.nix-env-selector
    #   plugins.tamasfe.even-better-toml
    #   plugins.equinusocio.vsc-material-theme
    #   plugins.pkief.material-icon-theme
    #   plugins.nerg.clips-lang
    # ];
    # userSettings = {
    #   "nix.enableLanguageServer" = true;
    #   "nix.serverPath" = "nil";
    #   "workbench.colorTheme" = "Material Theme Darker High Contrast";
    #   "workbench.iconTheme" = "material-icon-theme";
    #   "rust-analyzer.check.command" = "clippy";
    # "rust-analyzer.cargo.sysroot" = "${pkgs.rustc}/lib/rustlib/rustc-src/";
    # };
  };
}
