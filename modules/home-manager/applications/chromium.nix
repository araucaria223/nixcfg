{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.chromium;

  exts = {
    ublock = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
    yt-sponsorblock = "mnjggcdmjocbbbhaepdhchncahnbgone";
    old-reddit-redirect = "dneaehbmnbhcippjikoajpoabadpodje";
    reddit-enhancement-suite = "kbmfpngjjgdllneeigpgjifpgocmfgmb";
  };
in {
  options.chromium = {
    enable = lib.mkEnableOption "Enables ungoogled chromium";
  };

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      package = pkgs.ungoogled-chromium;
      commandLineArgs = [
        "--enable-features=VaapiVideoDecodeLinuxGL"
        "--ignore-gpu-blocklist"
        "--enable-zero-copy"
      ];

      extensions = with exts; [
	ublock
	yt-sponsorblock
	old-reddit-redirect
	reddit-enhancement-suite
      ];
    };
  };
}
