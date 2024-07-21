{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.stremio;
in {
  options.stremio = {
    enable = lib.mkEnableOption "Enables stremio";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.stremio];
    # persist stremio's data
    home.persistence."/persist/home/${config.home.username}".directories = [
      ".stremio-server"
      ".pki"
    ];
  };
}
