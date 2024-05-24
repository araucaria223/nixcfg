{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    doas.enable = lib.mkEnableOption "Enable doas";
  };

  config = lib.mkIf config.doas.enable {
    # disable sudo
    security.sudo.enable = false;

    # enable & configure doas
    security.doas = {
      enable = true;

      extraRules = [
        {
          # allow the "wheel" group to use doas
          groups = ["wheel"];

          # retain environment variables set for the user
          keepEnv = true;

          # allow one authentication to work for multiple calls
          persist = true;
        }
      ];
    };
  };
}
