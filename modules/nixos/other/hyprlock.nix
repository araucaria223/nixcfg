{ config, lib, ... }:

let
  cfg = config.hyprlock;
in
{
  options.hyprlock = {
    enable = lib.mkEnableOption "Enables hyprlock";
  };

  config = lib.mkIf cfg.enable {
    security.pam.services.hyprlock = {};
    security.pam.services.hyprlock.fprintAuth = true;
  };
}
