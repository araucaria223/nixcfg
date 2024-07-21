{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.fprintd;
in {
  options = {
    fprintd.enable = lib.mkEnableOption "Enables fingerprint scanner";
  };

  config = lib.mkIf cfg.enable {
    services.fprintd.enable = true;
    security.pam.services.login.fprintAuth = true;
  };
}
