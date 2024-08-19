{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.ags;
in {
  imports = [inputs.ags.homeManagerModules.default];

  options.ags = {
    enable = lib.mkEnableOption ''
      Enable AGS widgets
    '';
  };

  config = lib.mkIf cfg.enable {
    programs.ags = {
      enable = true;
      configDir = ./.;
      extraPackages = with pkgs; [
        bun
      ];
    };

    home.packages = [pkgs.bun];
  };
}
