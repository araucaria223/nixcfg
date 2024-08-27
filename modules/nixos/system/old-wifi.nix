{
  config,
  lib,
  pkgs,
  settings,
  ...
}:
with lib; let
  cfg = config.wifi;

  getFileName = stringAsChars (x:
    if x == " "
    then "-"
    else x);

  createWifi = ssid: opt: {
    name = "NetworkManager/system-connections/${getFileName ssid}.nmconnection";
    value = {
      mode = "0400";
      source = pkgs.writeText "${ssid}.nmconnection" ''
        [connection]
        id=${ssid}
        type=wifi

        [wifi]
        ssid=${ssid}

        [wifi-security]
        ${optionalString (opt.psk != null) ''
          key-mgmt=wpa-psk
          psk=${opt.psk}''}
      '';
    };
  };

  mkWifi = ssid: opt: {
    secrets."${ssid}" = {};
    templates."${getFilename ssid}.nmconnection".content = ''
      [connection]
      id=${ssid}
      type=wifi

      [wifi]
      ssid=${ssid}

      [wifi-security]
      ${optionalString (opt.psk != null) ''
        key-mgmt=wpa-psk
        psk=${opt.psk}''}
    '';
  };

  mkConnectionFile = ssid: source: {
    name = "NetworkManager/system-connections/${getFileName ssid}"
  #keyFiles = mapAttrs' createWifi config.networking.wireless.networks;
in {
  options.wifi = {
    enable = lib.mkEnableOption "Enables wifi";
  };

  config = lib.mkIf cfg.enable {
    #sops.secrets."wireless.env" = {};

    #environment.etc = keyFiles;
    sops = mapAttrs' mkWifi config.networking.wireless.networks;

    systemd.services.NetworkManager-predefined-connections = {
      restartTriggers = mapAttrsToList (name: value: value.source) keyFiles;
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.coreutils}/bin/true";
        ExecReload = "${pkgs.networkmanager}/bin/nmcli connection reload";
      };
      reloadIfChanged = true;
      wantedBy = ["multi-user.target"];
    };

    networking.networkmanager.enable = true;

    networking.wireless = {
      #enable = true;
      #userControlled.enable = true;
      #environmentFile = config.sops.secrets."wireless.env".path;

      # networks = {
      #   "@home1_ssid@".psk = "@home1_psk@";
      #   "@home2_ssid@".psk = "@home2_psk@";

      #   "@hotspot_ssid@".psk = "@hotspot_psk";
      # };
      networks = with config.sops.placeholder; {
	"jet wireless".psk = jet-wireless-psk;
	"CommunityFibre10Gb_02704".psk = community-fibre-psk;
      };
    };

    users.users.${settings.username}.extraGroups = ["networkmanager"];
  };
}
