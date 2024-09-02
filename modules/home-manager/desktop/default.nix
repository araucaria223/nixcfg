{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./waybar
    ./mako.nix
    ./ags
    ./cursor.nix
    ./font.nix
    ./gtk.nix
    ./qt.nix
    ./gammastep.nix
    ./bemenu.nix
    ./fuzzel.nix
  ];

  home.packages = with pkgs; [
    swayimg
  ];

  # wm / compositor
  hyprland.enable = lib.mkDefault true;

  # idle manager
  hypridle.enable = lib.mkDefault true;

  # screen locker
  hyprlock.enable = lib.mkDefault true;

  # wallpaper setter
  hyprpaper.enable = lib.mkDefault true;

  # notification daemon
  mako.enable = lib.mkDefault true;

  # theming
  cursor.enable = lib.mkDefault true;
  font.enable = lib.mkDefault true;
  gtkTheme.enable = lib.mkDefault true;
  qtTheme.enable = lib.mkDefault true;

  # redshift
  gammastep.enable = lib.mkDefault true;

  # application launchers
  bemenu.enable = lib.mkDefault false;
  fuzzel.enable = lib.mkDefault true;

  # widget framework
  ags.enable = lib.mkDefault true;

  # system bar
  waybar.enable = lib.mkDefault true;
}
