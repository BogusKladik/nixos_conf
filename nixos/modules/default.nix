(import ../../lib/collect-modules.nix {
  dir = ./.;
  pinned = [ "base.nix" "hardware.nix" ];
})
