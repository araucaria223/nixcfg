{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.font;
in {
  options.font = {
    enable = lib.mkEnableOption "Enable custom fonts";
  };

  config = lib.mkIf cfg.enable {
    fonts.fontconfig = {
      enable = true;

      defaultFonts = {
	monospace = ["JetBrainsMono Nerd Font"];
      };
    };

    home.packages = [
      (pkgs.nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono" "Iosevka"];})
    ];
  };
}
