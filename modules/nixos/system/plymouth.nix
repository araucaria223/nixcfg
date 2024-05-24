{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.plymouth;
in {
  options.plymouth = {
    enable = lib.mkEnableOption "Enables plymouth";
    theme = lib.mkOption {
      type = with lib.types; str;
      default = "spinner_alt";
      description = ''
	See https://github.com/adi1090x/plymouth-themes
	for a full list of themes.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = cfg.theme; 
        themePackages = with pkgs; [
          (adi1090x-plymouth-themes.override {
            selected_themes = [cfg.theme];
          })
        ];
      };
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
      ];

      loader.timeout = 0;
    };
  };
}
