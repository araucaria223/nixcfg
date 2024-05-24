{
  config,
  lib,
  inputs,
  settings,
  ...
}: let
  cfg = config.homeManager;
in {
  options.homeManager = {
    enable = lib.mkEnableOption "Enable home-manager";
    userName = lib.mkOption {
      description = "Username of home-manager user";
    };
    hostName = lib.mkOption {
      description = "Name of host machine";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager = {
      extraSpecialArgs = {inherit inputs settings;};
      users = {
        "${settings.username}" = {...}: {
          imports = [
            (import ../../../hosts/${settings.hostname}/home.nix)
            inputs.self.outputs.homeManagerModules.default
          ];
        };
      };
    };

    systemd.tmpfiles.rules = [
      "d /persist/home/ 1777 root root -"
      "d /persist/home/adzuki 0770 adzuki users -"
    ];
  };
}
