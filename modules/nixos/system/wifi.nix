{
  config,
  lib,
  pkgs,
  settings,
  ...
}: let
  cfg = config.wifi;

  createNMConfig = network: ''
    [connection]
    id=${config.sops.placeholder."wireless/${network}/ssid"}
    type=wifi

    [wifi]
    ssid=${config.sops.placeholder."wireless/${network}/ssid"}

    [wifi-security]
    key-mgmt=wpa-psk
    psk=${config.sops.placeholder."wireless/${network}/psk"}
  '';

  # add more networks here
  # networks must have an ssid and psk defined in $FLAKEDIR/secrets/secrets.yaml
  networks = [
    "home1"
    "home2"
  ];

  forAllNetworks = f: lib.mkMerge (builtins.map f networks);
in {
  options.wifi = {
    enable = lib.mkEnableOption ''
      Enables wifi
    '';
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true;
    users.users.${settings.username}.extraGroups = ["networkmanager"];
    environment.persistence."/persist/system".directories = ["/etc/NetworkManager/system-connections"];

    sops = {
      secrets = forAllNetworks (network: {
        "wireless/${network}/ssid" = {};
        "wireless/${network}/psk" = {};
      });

      templates = forAllNetworks (network: {
        "${network}.nmconnection".content = createNMConfig network;
      });
    };

    environment.etc = forAllNetworks (network: {
      "NetworkManager/system-connections/${network}.nmconnection" = {
        mode = "0400";
        source = config.sops.templates."${network}.nmconnection".path;
      };
    });

    systemd.services.NetworkManager-predefined-connections = {
      restartTriggers = lib.lists.forEach networks (network: "/etc/NetworkManager/system-connections/${network}.nmconnection");
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
