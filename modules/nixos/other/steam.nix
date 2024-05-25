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
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    # REQUIRES MANUAL IMPERATIVE INTERVENTION
    # Run `protonup` to install ProtonGE
    
    environment.systemPackages = [pkgs.protonup];
    
    environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
      ”\${HOME}/.steam/root/compatibilitytools.d”;
    };
  };
}
