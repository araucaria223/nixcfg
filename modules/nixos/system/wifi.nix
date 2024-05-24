{ config, lib, pkgs, ... }:

let
  cfg = config.wifi;
in
{
  options.wifi = {
    enable = lib.mkEnableOption "Enables wifi";
  };

  config = lib.mkIf cfg.enable {
    networking.wireless = {
      enable = true;
      userControlled.enable = true;
      networks = {
	"jet wireless" = {
	  pskRaw = "a3cb6f2aa33972dfb9f79cabfc554061bbdb9bd65524079ed5ad1d244defdec4";
	};
      };
    };
  };
}
