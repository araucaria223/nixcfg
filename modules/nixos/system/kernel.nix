{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.kernel-patches;
in {
  options.kernel-patches = {
    enable = lib.mkEnableOption ''
      Enable some kernel patches
    '';
  };

  config = lib.mkIf cfg.enable {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  };
}
