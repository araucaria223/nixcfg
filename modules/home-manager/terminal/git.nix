{
  config,
  lib,
  settings,
  ...
}: let
  cfg = config.git;
in {
  options.git = {
    enable = lib.mkEnableOption ''
      Enable git
    '';
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = "${settings.name}";
      userEmail = "${settings.email}";
      extraConfig = {
	init.defaultBranch = "main";
	safe.directory = "${config.home.homeDirectory}/nixos";
      };
    };
  };
}
