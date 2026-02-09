let
  # replace nixos-24.11 with your preferred nixos version or revision from here: https://status.nixos.org/
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixos-25.11.tar.gz";
in
import (nixpkgs + "/nixos/lib/eval-config.nix") {
  modules = [ ./configuration.nix ];
}