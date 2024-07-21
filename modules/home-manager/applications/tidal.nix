{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.tidal;
in {
  options.tidal = {
    enable = lib.mkEnableOption ''
      Enable TIDAL desktop client
    '';
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.tidal-hifi];
    # persist tidal's data
    home.persistence."/persist/home/${config.home.username}".directories = [".config/tidal-hifi"];
  };
}
