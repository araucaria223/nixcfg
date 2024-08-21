{
  config,
  lib,
  ...
}: let
  cfg = config.ncspot;
in {
  options.ncspot = {
    enable = lib.mkEnableOption ''
      Enable ncspot
    '';
  };

  config = lib.mkIf cfg.enable {
    programs.ncspot = {
      enable = true;
      settings = {
	gapless = true;
      };
    };
  };
}
