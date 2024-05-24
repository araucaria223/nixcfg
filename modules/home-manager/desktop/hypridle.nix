{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.hypridle;

  dim-screen = pkgs.writeShellApplication {
    name = "dim-screen";
    runtimeInputs = with pkgs; [brightnessctl];
    text = ''
           until [ "$(brightnessctl g)" -lt 5000 ]
           do
      brightnessctl set 5%-
      sleep 0.005
           done
    '';
  };
in {
  options.hypridle = {
    enable = lib.mkEnableOption "Enables hypridle";
  };

  config = lib.mkIf cfg.enable {
    services.hypridle.enable = true;

    services.hypridle.settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = let
	bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
	in [
        {
          timeout = 150;
          on-timeout = "${dim-screen}/bin/dim-screen";
          on-resume = "${bctl} -s set 60%";
        }

        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }

        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        {
          timeout = 600;
          on-timeout = "systemctl hibernate";
        }
      ];
    };
  };
}
