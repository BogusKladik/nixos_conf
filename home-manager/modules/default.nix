(import ../../lib/collect-modules.nix {
  dir = ./.;
  pinned = [ "common.nix" "desktop.nix" ];
})
