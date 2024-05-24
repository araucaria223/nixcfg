{
  config,
  lib,
  ...
}: let
  cfg = config.pipewire;
in {
  options.pipewire = {
    enable = lib.mkEnableOption "Enables pipewire";
  };

  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
  };
}
