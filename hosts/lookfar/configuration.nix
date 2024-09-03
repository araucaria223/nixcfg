{
  config,
  lib,
  pkgs,
  inputs,
  settings,
  self,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nix-colors.homeManagerModules.default
  ];

  networking.hostName = "${settings.hostname}";

  time.timeZone = "Europe/London";

  i18n.defaultLocale = "en_GB.UTF-8";

  colorScheme = inputs.nix-colors.colorSchemes.${settings.colorScheme};

  services.openssh.enable = true;

  nh.enable = false;
  doas.enable = false;

  environment.systemPackages = [pkgs.bun];

  system.stateVersion = "24.05";
}
