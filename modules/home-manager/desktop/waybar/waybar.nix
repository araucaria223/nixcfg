{
  config,
  lib,
  settings,
  pkgs,
  ...
}: let
  cfg = config.waybar;

  icons = {
    ws = "";
    ws-urgent = "";

    clock = "";
    calendar = "";

    cpu = "";
    backlight = ["" "" "" "" "" "" "" "" ""];

    mem = "";
    mem-alt = "";
  };
in {
  options.waybar = {
    enable = lib.mkEnableOption "Enables waybar";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [font-awesome];
    programs.waybar.enable = true;
    programs.waybar.style = ./style.css;
    programs.waybar.settings.main-bar = with config.colorScheme.palette; {
      layer = "top";
      height = 30;
      margin-top = 10;
      margin-left = 10;
      margin-bottom = 0;
      margin-right = 10;
      spacing = 5;

      modules-left = ["battery" "cpu" "memory" "backlight"]; #"keyboard-state"];
      modules-center = ["hyprland/workspaces"];
      modules-right = ["pulseaudio" "network" "clock"]; #"custom/power"];

      "hyprland/workspaces" = {
        format = "{icon}";
        #on-click = "activate";
        format-icons = with icons; {
          default = ws;
          active = ws;
          urgent = ws-urgent;
        };
      };

      clock = with icons; {
        format = "<span color='#${base08}'>${clock} </span>{:%I:%M %p}";
        format-alt = "<span color='#${base08}'>${calendar} </span>{:%a %b %d}";
        tooltip-format = "<big>{:%B %Y}</big>\\n<tt><small>{calendar}</small></tt>";
        min-length = 13;
      };

      cpu = with icons; {
        interval = 1;
        format = "${cpu} {usage}%";
        min-length = 6;
        max-length = 100;
        on-click = "";
      };

      memory = with icons; {
        interval = 30;
        format = "${mem} {}%";
        format-alt = "${mem-alt} {used:0.1f}G";
        min-length = 6;
        max-length = 10;
      };

      backlight = let
        bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
      in {
        device = settings.monitor;
        format = "{icon} {percent}%";
        format-icons = icons.backlight;
        on-click = "";

        on-scroll-down = "${bctl} s 1%-";
        on-scroll-up = "${bctl} s +1%";

        min-length = 6;
      };

      pulseaudio = {
        format = "{icon} {volume}%";
        format-icons = {
          headphone = "";
          hands-free = "";
          headset = "";
          phone = "";
          portable = "";
          car = "";
          default = ["" "" ""];
        };
      };

      battery = {
        interval = 1;
        states = {
          warning = 30;
          critical = 15;
        };

        max-length = 20;
        format = "{icon} {capacity}%";
        format-warning = "{icon} {capacity}%";
        format-critical = "{icon} {capacity}%";
        format-charging = "<span font-family='Font Awesome 6 Free'></span> {capacity}%";
        format-plugged = " {capacity}%";
        format-full = " {capacity}%";
        format-icons = [" " " " " " " " " "];
      };
    };
  };
}
