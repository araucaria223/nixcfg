{
  config,
  lib,
  ...
}: let
  cfg = config.systemd-boot;
in {
  options.systemd-boot = {
    enable = lib.mkEnableOption "Enables systemd-boot";
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
