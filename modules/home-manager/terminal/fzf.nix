{
  config,
  lib,
  ...
}: let
  cfg = config.fzf;
in {
  options.fzf = {
    enable = lib.mkEnableOption ''
      Enable fzf - a powerful fuzzy finder
    '';
  };

  config = lib.mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;

      colors = with config.colorScheme.palette; {
	bg = "#${base00}";
	"bg+" = "#${base01}";
	spinner = "#${base0C}";
	hl = "#${base0D}";
	fg = "#${base04}";
	header = "#${base0D}";
	info = "#${base0A}";
	pointer = "#${base0C}";
	marker = "#${base0C}";
	"fg+" = "#${base06}";
	prompt = "#${base0A}";
	"hl+" = "#${base0D}";
      };
    };
  };
}
