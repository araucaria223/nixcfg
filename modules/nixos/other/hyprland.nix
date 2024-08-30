{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.hyprland;
in {
  options.hyprland = {
    enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf cfg.enable {
    # enable the hyprland cachix
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
    };

    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
