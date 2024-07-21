{
  config,
  lib,
  pkgs,
  inputs,
  settings,
  ...
}: let
  cfg = config.hyprlock;
in {
  options.hyprlock = {
    enable = lib.mkEnableOption "Enables hyprlock";
    #wallpaper = lib.mkOption {
    #  type = with lib.types; uniq path;
    #};
  };

  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;

      settings = with config.colorScheme.palette; {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };

        background = [
          {
	    path = builtins.toString settings.wallpaper;
            #blur_passes = 2;
            #blur_size = 7;
            brightness = 0.4;
          }
        ];

        label = [
          {
            text = "$TIME";
            text_align = "center";
            color = "rgb(${base06})";
            font_size = 50;
            font_family = "monospace";

            position = "0, 80";
            halign = "center";
            valign = "center";
          }
        ];

        input-field = with inputs.nix-colors.lib.conversions; [
          {
            size = "180, 30";
            outline_thickness = 3;
            dots_size = 0.20;
            dots_spacing = 1;
            dots_center = false;
            dots_rounding = -1;
            outer_color = "rgba(0, 0, 0, 0)";
            inner_color = "rgba(${hexToRGBString ", " "${base01}"}, 0.7)";
            font_color = "rgb(${base06})";
            fade_on_empty = true;
            fade_timeout = 1000;
            placeholder_text = "<i>Input password</i>";
            hide_input = false;
            rounding = 10;
            check_color = "rgb(204, 136, 34)";
            fail_color = "rgb(204, 34, 34)";
            fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
            fail_transition = 300;
            capslock_color = -1;
            numlock_color = -1;
            bothlock_color = -1;
            invert_numlock = false;
            swap_font_color = false;

            position = "0, -20";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
