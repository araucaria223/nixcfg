{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.ags;
in {
  imports = [inputs.ags.homeManagerModules.default];

  options.ags = {
    enable = lib.mkEnableOption "Enables ags";
  };

  config = lib.mkIf cfg.enable {
    # needed for bar brightness module
    home.packages = with pkgs; [
      brightnessctl
    ];

    programs.ags = {
      enable = true;
      configDir = ./config;

      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
  };
}
