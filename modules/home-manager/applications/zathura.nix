{
  config,
  lib,
  ...
}: let
  cfg = config.zathura;
in {
  options.zathura = {
    enable = lib.mkEnableOption "Enables zathura";
  };

  config = lib.mkIf cfg.enable {
    # set zathura as default pdf viewer
    xdg.mimeApps = {
      associations.added = {
        "application/pdf" = ["zathura.desktop"];
      };
      defaultApplications = {
        "application/pdf" = ["zathura.desktop"];
      };
    };

    programs.zathura.enable = true;

    programs.zathura.options = with config.colorScheme.palette; {
      default-bg = "#${base00}";
      default-fg = "#${base04}";

      statusbar-fg = "#${base02}";
      statusbar-bg = "#${base01}";

      inputbar-bg = "#${base00}";
      inputbar-fg = "#${base04}";

      notification-bg = "#${base00}";
      notification-fg = "#${base04}";

      notification-error-bg = "#${base00}";
      notification-error-fg = "#${base08}";

      notification-warning-bg = "#${base00}";
      notification-warning-fg = "#${base08}";

      highlight-color = "#${base0A}";
      highlight-active-color = "#${base0D}";

      completion-bg = "#${base03}";
      completion-fg = "#${base0D}";

      completion-highlight-fg = "#${base04}";
      completion-highlight-bg = "#${base0D}";

      recolor-lightcolor = "#${base00}";
      recolor-darkcolor = "#${base04}";

      recolor = "true";
      recolor-keephue = "true";
    };
  };
}
