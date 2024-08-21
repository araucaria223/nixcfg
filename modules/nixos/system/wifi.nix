{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.wifi;
in {
  options.wifi = {
    enable = lib.mkEnableOption "Enables wifi";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."wireless.env" = {};

    networking.wireless = {
      enable = true;
      userControlled.enable = true;
      environmentFile = config.sops.secrets."wireless.env".path;

      networks = with builtins; let
        ntwk = name: {
          "@${name}_ssid@".psk = "@${name}_psk";
        };
      in
        listToAttrs [
          (ntwk "home1")
          (ntwk "home2")
          (ntwk "hotspot")
        ];
      #"@home1_ssid@".psk = "@home1_psk@";
      #"@home2_ssid@".psk = "@home2_psk@";

      #	"@hotspot_ssid@".psk = "@hotspot_psk@";
    };
  };
}
