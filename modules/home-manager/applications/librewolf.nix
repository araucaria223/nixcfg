{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.librewolf;
in {
  options.librewolf = {
    enable = lib.mkEnableOption "Enables librewolf";
    defaultBrowser = lib.mkEnableOption ''
      Sets librewolf as the default browser
    '';
  };

  config = lib.mkIf cfg.enable {
    # persist librewolf's data
    home.persistence."/persist/home/${config.home.username}".directories = [".librewolf"];

    # set librewolf as default browser
    xdg.mimeApps.defaultApplications = lib.mkIf cfg.defaultBrowser {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
    };

    home.sessionVariables.DEFAULT_BROWSER = 
      lib.mkIf cfg.defaultBrowser "${pkgs.librewolf}/bin/librewolf";

    programs.librewolf = {
      enable = true;
      package = pkgs.librewolf-wayland;

      settings = {
        "privacy.resistFingerprinting.letterboxing" = true;
      };
    };
  };
}
