{
  config,
  lib,
  ...
}: let
  cfg = config.steam;
in {
  options.steam = {
    enable = lib.mkEnableOption "Enables steam";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [protonup];
    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    home.persistence."/persist/home/${config.home.username}".directories = [
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
  };
}
