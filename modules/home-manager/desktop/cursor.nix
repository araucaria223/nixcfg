{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.cursor;
in {
  options.cursor = {
    enable = lib.mkEnableOption "Enable cursor theme";
  };

  config = lib.mkIf cfg.enable {
    home.pointerCursor = {
      gtk.enable = true;
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-dark";
      size = 4;
    };
  };
}
