{
  config,
  lib,
  ...
}: let
  cfg = config.root;
in {
  options.root = {
    enable = lib.mkEnableOption "Enables root password";
  };

  config = lib.mkIf cfg.enable {
    sops.secrets.root-password.neededForUsers = true;
    users.users.root.hashedPasswordFile = config.sops.secrets.root-password.path;
  };
}
