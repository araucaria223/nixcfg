{
  pkgs,
  inputs,
  settings,
  ...
}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nix-colors.homeManagerModules.default
  ];

  home.username = "${settings.username}";
  home.homeDirectory = "/home/${settings.username}";

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;

  colorScheme = inputs.nix-colors.colorSchemes.${settings.colorScheme};

  kitty.enable = true;
  alacritty.enable = false;
  bemenu.enable = false;
  ags.enable = false;

  hyprland.monitor = ",preferred,auto,1";

  librewolf.enable = false;
  brave.enable = false;
}
