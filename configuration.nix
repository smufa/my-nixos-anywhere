
{ modulesPath, ... }:

let
  sources = import ./npins;
  pkgs = import sources.nixpkgs {};
in
{
  imports = [
    (sources.disko + "/module.nix")
    ./single-btrfs-luks-swap.nix
  ];

  disko.devices.disk.main.device = "/dev/nvme0n1";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh.enable = true;

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
      micro
    ];
    openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKB7piUC0mjzZyOjtgL2dZR4p8rCdM0HtsL4s4zx+GgX"
    ];
  };

  system.stateVersion = "25.11";
}