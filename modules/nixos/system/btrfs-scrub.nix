{
  config,
  lib,
  ...
}: let
  cfg = config.btrfs-scrub;
in {
  options.btrfs-scrub = {
    enable = lib.mkEnableOption ''
      Enable btrfs autoscrubbing
    '';
  };

  config = lib.mkIf cfg.enable {
    services.btrfs.autoScrub = {
      enable = true;
      interval = "monthly";
      fileSystems = [
	"/persist"
	"/nix"
	"/"
      ];
    };
  };
}
