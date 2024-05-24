{ config, lib, ... }:

let
  cfg = config.bottom;
in
{
  options.bottom = {
    enable = lib.mkEnableOption "Enables bottom";
  };

  config = lib.mkIf cfg.enable {
    programs.bottom.enable = true;
  };
}
