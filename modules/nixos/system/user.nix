{
  config,
  lib,
  pkgs,
  settings,
  ...
}: let
  cfg = config.mainUser;
in {
  options.mainUser = {
    enable = lib.mkEnableOption "Enable user module";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.enable = lib.mkDefault true;

    sops.secrets."${settings.username}-password" = {
      neededForUsers = true;
    };

    users.users.${settings.username} = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      #initialPassword = "password";
      hashedPasswordFile = config.sops.secrets."${settings.username}-password".path;
      shell = pkgs.zsh;
    };
  };
}
