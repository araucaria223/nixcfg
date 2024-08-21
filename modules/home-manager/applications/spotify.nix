{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.spotify;
in {
  options.spotify = {
    enable = lib.mkEnableOption ''
      Enable spotify
    '';
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.spotify];
    # persist spotify's data
    home.persistence."/persist/home/${config.home.username}".directories = [".config/spotify"];
  };
}
