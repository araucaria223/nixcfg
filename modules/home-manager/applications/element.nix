{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.element;
in {
  options.element = {
    enable = lib.mkEnableOption ''
      Enables element - a matrix client
    '';
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.element-desktop];
    # persist element's data
    home.persistence."/persist/home/${config.home.username}".directories = [".config/Element"];
  };
}
