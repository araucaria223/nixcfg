{
  config,
  lib,
  pkgs,
  settings,
  ...
}: let
  cfg = config.wifi;

  getFileName = lib.stringAsChars (x:
    if x == " "
    then "-"
    else x);

  createSops = ssid: {
    secrets."${ssid}-psk" = {};
    templates."${getFileName ssid}.nmconnection".content = ''
      [connection]
      id=${ssid}
      type=wifi

      [wifi]
      ssid=${ssid}

      [wifi-security]
      key-mgmt=wpa-psk
      psk=${config.sops.placeholder."${ssid}-psk"}
    '';
  };

  createWifi = ssid: {
    name = "NetworkManager/system-connections/${getFileName ssid}.nmconnection";
    value = {
      mode = "0400";
      source = config.sops.templates."${getFileName ssid}".path;
    };
  };

  createNMConfig = ssid: ''
    [connection]
    id=${ssid}
    type=wifi

    [wifi]
    ssid=${ssid}

    [wifi-security]
    key-mgmt=wpa-psk
    psk=${config.sops.placeholder."${getFileName ssid}-psk"}
  '';
in {
  options.wifi = {
    enable = lib.mkEnableOption ''
      Enables wifi
    '';
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
    users.users.${settings.username}.extraGroups = ["networkmanager"];

    sops = {
      secrets.jet-wireless-psk = {};
      templates."jet-wireless.nmconnection".content = createNMConfig "jet wireless";
    };

    environment.etc."NetworkManager/system-connections/jet-wireless.nmconnection" = {
      mode = "0400";
      source = config.sops.templates."jet-wireless.nmconnection".path;
    };

    systemd.services.NetworkManager-predefined-connections = {
      restartTriggers = [ "/etc/NetworkManager/system-connections/jet-wireless.nmconnection" ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        ExecStart = "${pkgs.coreutils}/bin/true";
        ExecReload = "${pkgs.networkmanager}/bin/nmcli connection reload";
      };
      reloadIfChanged = true;
      wantedBy = ["multi-user.target"];
    };
  };
}
