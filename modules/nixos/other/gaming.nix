{
  config,
  lib,
  ...
}: let
  cfg = config.gaming;
in {
  options.gaming = {
    enable = lib.mkEnableOption "Enables gaming functionality";
  };

  config = lib.mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    environment.systemPackages = with pkgs; [
      mangohud
      lutris
      herioc
      bottles
    ];
    
    programs.gamemode.enable = true;
  };
}
