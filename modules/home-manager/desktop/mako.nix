{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.mako;
in {
  options.mako = {
    enable = lib.mkEnableOption "Enables mako";
  };

  config = lib.mkIf cfg.enable {
    services.mako = with config.colorScheme.palette; {
      enable = true;
      backgroundColor = "#${base01}";
      borderColor = "#${base0E}";
      borderRadius = 5;
      borderSize = 2;
      textColor = "#${base04}";
      layer = "overlay";
    };
  };
}
