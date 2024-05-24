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

    sops.age.keyFile = "/persist/home/${settings.username}/.config/sops/age/keys.txt";
    sops.secrets.adzuki-password.neededForUsers = true;

    users.users.${settings.username} = {
      isNormalUser = true;
      extraGroups = ["wheel"];
      #initialPassword = "password";
      hashedPasswordFile = config.sops.secrets.adzuki-password.path;
      shell = pkgs.zsh;
    };
  };
}
