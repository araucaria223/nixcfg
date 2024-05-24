{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.impermanence;
in {
  options.impermanence = {
    enable = lib.mkEnableOption "Enables home directory impermanence";
  };

  config = lib.mkIf cfg.enable {
    home.persistence."/persist/home/${config.home.username}" = {
      directories = [
        "docs"
        "media"
        "junk"
	"loads"
	"nixos"
        ".ssh"
	".config/sops/age"
        ".local/share/keyrings"
        ".local/share/direnv"
        #{
        #  directory = ".local/share/Steam";
        #  method = "symlink";
        #}
      ];
      allowOther = true;
    };
  };
}
