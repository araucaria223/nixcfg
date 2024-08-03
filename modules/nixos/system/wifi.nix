{ config, lib, pkgs, ... }:

let
  cfg = config.wifi;
in
{
  options.wifi = {
    enable = lib.mkEnableOption "Enables wifi";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."wireless.env" = {};

    networking.wireless = {
      enable = true;
      userControlled.enable = true;
      environmentFile = config.sops.secrets."wireless.env".path;

      networks = {
	"@home_ssid@".psk = "@home_psk@";

	"@hotspot_ssid@".psk = "@hotspot_psk@";
      };
    };
  };
}
