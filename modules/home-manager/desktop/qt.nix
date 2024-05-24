{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.qtTheme;
in {
  options.qtTheme = {
    enable = lib.mkEnableOption "Enables qt theme";
  };

  config = lib.mkIf cfg.enable {
    qt = {
      platformTheme = "gtk";
      style = {
        name = "adwaita-dark";
        package = pkgs.adwaita-qt;
      };
    };
  };
}
