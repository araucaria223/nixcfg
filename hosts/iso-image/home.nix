{
  pkgs,
  inputs,
  settings,
  ...
}: {
  # imports = [
  #   inputs.impermanence.nixosModules.home-manager.impermanence
  #   inputs.nix-colors.homeManagerModules.default
  # ];

  home.stateVersion = "24.05";

  kitty.enable = true;
  alacritty.enable = false;
  bemenu.enable = false;

  librewolf.enable = false;
  emacs.enable = false;
  hyprpaper.enable = false;
  waybar.enable = false;
}
