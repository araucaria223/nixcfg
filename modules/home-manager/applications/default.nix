{ pkgs, lib, ... }:

{
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
  home.packages = with pkgs; [ element-desktop ];

  # ide
  vscode.enable = lib.mkDefault true;

  # game launcher
  steam.enable = lib.mkDefault false;
}
