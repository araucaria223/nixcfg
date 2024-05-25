{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./kitty.nix
    ./alacritty.nix
    ./firefox.nix
    ./librewolf.nix
    ./brave.nix
    ./zathura.nix
    ./pcmanfm.nix
    ./discord.nix
    ./vscode.nix
    ./steam.nix
    ./gaming.nix
  ];

  # programs that don't need their own module
  home.packages = with pkgs; [
    # matrix client
    element-desktop
    # torrent client
    qbittorrent
  ];

  # terminal emulators
  alacritty.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;

  # file manager
  pcmanfm.enable = lib.mkDefault true;

  # browsers
  firefox.enable = lib.mkDefault true;
  librewolf.enable = lib.mkDefault true;
  brave.enable = lib.mkDefault true;

  # pdf viewer
  zathura.enable = lib.mkDefault true;
  # chat clients
  discord.enable = lib.mkDefault true;
  # ide
  vscode.enable = lib.mkDefault true;
  # game launchers
  steam.enable = lib.mkDefault false;
  gaming.enable = lib.mkDefault false;
}
