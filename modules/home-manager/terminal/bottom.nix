{ config, lib, ... }:

let
  cfg = config.bottom;
in
{
  options.bottom = {
    enable = lib.mkEnableOption ''
      Enable bottom -
	a tui system monitor
    '';
  };

  config = lib.mkIf cfg.enable {
    programs.bottom.enable = true;
  };
}
