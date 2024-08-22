{
  config,
  lib,
  ...
}: let
  cfg = config.bluetooth;
in {
  options.bluetooth = {
    enable = lib.mkEnableOption ''
      Enable bluetooth
    '';
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;

    };
  };
}
