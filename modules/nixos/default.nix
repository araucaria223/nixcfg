{
  pkgs,
  lib,
  settings,
  inputs,
  ...
}: {
  imports = [
    #./system/grub.nix
    ./system/systemd-boot.nix
    ./system/plymouth.nix
    ./system/impermanence.nix
    ./system/home-manager.nix 
    ./system/user.nix
    ./system/doas.nix
    ./system/nh.nix
    ./system/nix.nix
    ./system/pipewire.nix
    ./system/wifi.nix

    ./other/sddm/sddm.nix
    ./other/hyprland.nix
    ./other/hyprlock.nix
  ];

  systemd-boot.enable = lib.mkDefault false;
  #grub.enable = lib.mkDefault false;

  plymouth.enable = lib.mkDefault true;
  impermanence.enable = lib.mkDefault true;
  homeManager.enable = lib.mkDefault true;
  mainUser.enable = lib.mkDefault true;
  doas.enable = lib.mkDefault false;
  nh.enable = lib.mkDefault true;
  nix-settings.enable = lib.mkDefault true;
  pipewire.enable = lib.mkDefault true;
  wifi.enable = lib.mkDefault true;

  sddm.enable = lib.mkDefault true;
  hyprland.enable = lib.mkDefault true;
  hyprlock.enable = lib.mkDefault true;
}
