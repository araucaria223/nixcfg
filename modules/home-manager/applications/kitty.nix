{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.kitty;
in {
  options.kitty = {
    enable = lib.mkEnableOption "Enable kitty";
    fontSize = lib.mkOption {
      type = with lib.types; uniq int;
      default = 12;
    };
  };

  config = lib.mkIf cfg.enable {
    programs.kitty.enable = true;

    programs.kitty.settings = with config.colorScheme.palette; {
      scrollback_lines = 10000;
      enable_audio_bell = false;
      disable_ligatures = "never";

      font_size = cfg.fontSize;
      font_family = "Fira Code Nerd Font";
      bold_font = "auto";
      italic_font = "auto";
      bold_italic_font = "auto";

      window_padding_width = 10;
      confirm_os_window_close = "0";

      background = "#${base00}";
      foreground = "#${base05}";
      selection_background = "#${base05}";
      selection_foreground = "#${base00}";
      url_color = "#${base04}";
      cursor = "#${base05}";
      active_border_color = "#${base03}";
      inactive_border_color = "#${base01}";
      active_tab_background = "#${base00}";
      active_tab_foreground = "#${base05}";
      inactive_tab_background = "#${base01}";
      inactive_tab_foreground = "#${base04}";
      tab_bar_background = "#${base01}";

      # normal
      color0 = "#${base00}";
      color1 = "#${base08}";
      color2 = "#${base0B}";
      color3 = "#${base0A}";
      color4 = "#${base0D}";
      color5 = "#${base0E}";
      color6 = "#${base0C}";
      color7 = "#${base05}";

      # bright
      color8 = "#${base03}";
      color9 = "#${base09}";
      color10 = "#${base01}";
      color11 = "#${base02}";
      color12 = "#${base04}";
      color13 = "#${base06}";
      color14 = "#${base0F}";
      color15 = "#${base07}";
    };
  };
}
