{
  config,
  lib,
  pkgs,
  inputs,
  settings,
  ...
}: let
  cfg = config.sddm;
in {
  options.sddm = {
    enable = lib.mkEnableOption "Enable sddm";
  };

  config = lib.mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      theme = "${import ./sugar-dark.nix {inherit pkgs settings config;}}";
      wayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5.qtgraphicaleffects
    ];
  };
}
