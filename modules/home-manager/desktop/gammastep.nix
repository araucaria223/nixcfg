{
  config,
  lib,
  ...
}: let
  cfg = config.gammastep;
in {
  options.gammastep = {
    enable = lib.mkEnableOption "Enables gammastep";
  };

  config = lib.mkIf cfg.enable {
    services.gammastep = {
      enable = true;
      provider = "manual";
      latitude = 51.5;
      longitude = 0.1;
    };
  };
}
