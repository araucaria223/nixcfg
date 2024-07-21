{
  config,
  lib,
  pkgs,
  settings,
  ...
}: let
  cfg = config.nh;
in {
  options.nh = {
    enable = lib.mkEnableOption "Enables nh";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 14d";
      flake = /home/${settings.username}/nixos;
    };

    environment.systemPackages = with pkgs; [
      nix-output-monitor
      nvd
    ];
  };

}
