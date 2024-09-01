{
  config,
  lib,
  settings,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.hyprpaper;
in {
  options.hyprpaper = {
    enable = lib.mkEnableOption "Enables hyprpaper";
  };

  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;

      settings = let
        wall = builtins.toString settings.wallpaper;
      in {
        preload = ["${wall}"];
        wallpaper = [",${wall}"];

        ipc = "off";
        splash = false;
      };
    };
  };
}
