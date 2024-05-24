{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.brave;

  exts = {
    ublock = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
    yt-sponsorblock = "mnjggcdmjocbbbhaepdhchncahnbgone";
    old-reddit-redirect = "dneaehbmnbhcippjikoajpoabadpodje";
    reddit-enhancement-suite = "kbmfpngjjgdllneeigpgjifpgocmfgmb";
  };
in {
  options.brave = {
    enable = lib.mkEnableOption "Enables brave";
  };

  config = lib.mkIf cfg.enable {
    # persist brave's data
    home.persistence."/persist/home/${config.home.username}".directories = [
      ".config/BraveSoftware"
      ".cache/BraveSoftware"
    ];
    
    programs.chromium = {
      enable = true;
      package = pkgs.brave;
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
