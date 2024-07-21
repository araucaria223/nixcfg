{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.emacs;
in {
  options.emacs = {
    enable = lib.mkEnableOption ''
      Enable emacs, and achieve a higher
      state of being
    '';
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [(import inputs.emacs-overlay)];
    programs.emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
      #defaultEditor = true;
      extraConfig = ''
        (setq standard-indent 2)
      '';
    };
  };
}
