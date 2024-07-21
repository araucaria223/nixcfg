{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.pcmanfm;
in {
  options.pcmanfm = {
    enable = lib.mkEnableOption "Enables pcmanfm";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [pcmanfm];

    # set pcmanfm as default file manager
    xdg.mimeApps = {
      associations.added = {
        "inode/directory" = ["pcmanfm.desktop"];
      };
      defaultApplications = {
        "inode/directory" = ["pcmanfm.desktop"];
      };
    };
  };
}
