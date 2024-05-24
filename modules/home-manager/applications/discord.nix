{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.discord;
in {
  options.discord = {
    enable = lib.mkEnableOption "Enables discord";
  };

  config = lib.mkIf cfg.enable {
    # install vesktop
    home.packages = with pkgs; [vesktop];

    # persist vesktop's data
    home.persistence."/persist/home/${config.home.username}".directories = [".config/vesktop"];

    #xdg.configFile."vesktop/settings.json".text = with config.colorScheme.palette; ''
   #   "discordBranch": "ptb",
   #   "arRPC": "on",
   #   "splashColor": "rgb(219, 222, 223)",
   #   "splashBackground": "rgb(${inputs.nix-colors.lib.conversions.hexToRGBString ", " "${base00}"})"
   # '';
  };
}
