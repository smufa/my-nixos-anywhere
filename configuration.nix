{
  modulesPath,
  lib,
  pkgs,
  ...
} @ args:
{
  imports = [
    "${fetchTarball "https://github.com/nix-community/disko/tarball/master"}/module.nix"
    ./disk-config.nix
    { hardware.facter.reportPath = ./facter.json; }
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.systemPackages = map lib.lowPrio [
    pkgs.curl
    pkgs.gitMinimal
    pkgs.helix
  ];

  users.users.enei = {
    isNormalUser = true;
    description = "enei";
    extraGroups = [
      "networkmanager"
      "wheel"
      "uinput"
      "podman"
    ];
    packages = with pkgs; [
      nixfmt-rfc-style
      nil
    ];
  };

  system.stateVersion = "25.1";
}
