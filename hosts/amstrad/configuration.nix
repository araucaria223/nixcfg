{
  config,
  lib,
  pkgs,
  inputs,
  settings,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nix-colors.homeManagerModules.default
  ];

  networking.hostName = "${settings.hostname}";

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  systemd-boot.enable = true;

  hardware.enableRedistributableFirmware = true;

  colorScheme = inputs.nix-colors.colorSchemes.${settings.colorScheme};
  
  system.stateVersion = "24.05"; # Did you read the comment?
}
