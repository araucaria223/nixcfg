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

    programs.gamemode.enable = true;
  };
}
