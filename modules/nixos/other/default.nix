{lib, ...}: {
  imports = [
    ./sddm/sddm.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./steam.nix
    ./opengl.nix
  ];

  # display manager
  sddm.enable = lib.mkDefault false;
  # wayland compositor
  hyprland.enable = lib.mkDefault true;
  # screen locker
  hyprlock.enable = lib.mkDefault true;
  # game launcher
  steam.enable = lib.mkDefault false;
  # graphics drivers
  opengl.enable = lib.mkDefault false;
}
