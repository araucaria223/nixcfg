{
  config,
  lib,
  pkgs,
  inputs,
  settings,
  ...
}: let
  cfg = config.grub;
in {
  imports = [ inputs.grub2-themes.nixosModules.default ];
  
  options.grub = {
    enable = lib.mkEnableOption "Enables grub";
  };

  config = lib.mkIf cfg.enable {
    boot.loader = {
      efi.canTouchEfiVariables = true;
      grub = {
	enable = true;
	efiSupport = true;
	device = "nodev";
      };

      grub2-theme = {
	enable = true;
	theme = "vimix";
	icon = "white";

	splashImage = "${settings.splash}";
      };
    };
  };
}
