{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.gaming;
in {
  options.gaming = {
    enable = lib.mkEnableOption "Enables some game launchers";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      mangohud
      lutris
      heroic
      bottles
    ];
  };
}
