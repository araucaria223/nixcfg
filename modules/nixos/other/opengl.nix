{
  config,
  lib,
  ...
}: let
  cfg = config.opengl;
in {
  options.opengl = {
    enable = lib.mkEnableOption "Enables OpenGL";
  };

  config = lib.mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
