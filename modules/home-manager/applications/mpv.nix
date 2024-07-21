{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.mpv;
in {
  options.mpv = {
    enable = lib.mkEnableOption "Enables mpv";
  };

  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;
      scripts = with pkgs.mpvScripts; [
        modernx
        thumbfast
      ];

      config = {
	osc = false;
	border = false;
      };
    };
  };
}
