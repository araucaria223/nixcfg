{ config, lib, pkgs, ... }:

let
  cfg = config.fuzzel;
in
{
  options.fuzzel = {
    enable = lib.mkEnableOption "Enable fuzzel";
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel = {
      enable = true;

      settings = {
	main = {
	  terminal = "${pkgs.kitty}/bin/kitty";
	  icon-theme = "${config.gtk.iconTheme.name}";
	  #prompt = "❯ ";
	  prompt = "​";
	  password-character = "*";
	  fuzzy = true;
	  show-actions = false;
	  icons-enabled = false;
	  dpi-aware = "auto";
	  font = "monospace:size=11";


	  anchor = "center";
	  lines = 10;
	  width = 20;
	  tabs = 4;
	  horizontal-pad = 18;
	  vertical-pad = 8;
	  inner-pad = 0;
	  image-size-ratio = 0.5;
	  
	  line-height = 20;
	  letter-spacing = 0;
	  layer ="top";
	  exit-on-keyboard-focus-loss = true;
	};

	border = {
	  width = 0;
	  radius = 8;
	};

	colors = with config.colorScheme.palette; {
	  background = "${base00}ef";
	  text = "${base05}ff";
	  match = "${base0A}ff";
	  selection = "${base03}ff";
	  selection-text = "${base05}ff";
	  selection-match = "${base0A}ff";
	  border = "${base0D}ff";
	};
      };
    };
  };
}
