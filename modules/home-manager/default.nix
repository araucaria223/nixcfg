{
  inputs,
  outputs,
  settings,
  ...
}: {
  imports = [
    ./services
    ./terminal
    ./desktop
    ./applications

    inputs.nix-colors.homeManagerModules.default
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.master-packages
    ];

    config.allowUnfree = true;
  };

  home = {
    username = "${settings.username}";
    homeDirectory = "/home/${settings.username}";
  };

  programs.home-manager.enable = true;

  colorScheme = inputs.nix-colors.colorSchemes.${settings.colorScheme};
}
