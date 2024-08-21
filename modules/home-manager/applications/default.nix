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
    ./chromium.nix
    ./emacs.nix
    ./zathura.nix
    ./pcmanfm.nix
    ./discord.nix
    ./vscode.nix
    ./steam.nix
    ./gaming.nix
    ./stremio.nix
    ./tidal.nix
    ./spotify.nix
    ./element.nix
    ./mpv.nix
  ];

  # programs that don't need their own module
  home.packages = with pkgs; [
    telegram-desktop
    # torrent client
    qbittorrent
    # password manager
    keepassxc
  ];

  # terminal emulators
  alacritty.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;

  # file manager
  pcmanfm.enable = lib.mkDefault true;

  # browsers
  firefox.enable = lib.mkDefault true;
  librewolf.enable = lib.mkDefault false;
  chromium.enable = lib.mkDefault true;

  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  # EMACS
  emacs.enable = lib.mkDefault true;

  # media centre
  stremio.enable = lib.mkDefault true;

  # video player
  mpv.enable = lib.mkDefault true;

  # music streaming
  tidal.enable = lib.mkDefault true;
  spotify.enable = lib.mkDefault true;

  # chat clients
  discord.enable = lib.mkDefault true;
  #element.enable = lib.mkDefault true;

  # pdf viewer
  zathura.enable = lib.mkDefault true;

  # ide
  vscode.enable = lib.mkDefault true;
  # game launchers
  steam.enable = lib.mkDefault false;
  gaming.enable = lib.mkDefault false;
}
