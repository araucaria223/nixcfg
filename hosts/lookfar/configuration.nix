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

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.secrets.adzuki-password = {};

  networking.hostName = "${settings.hostname}";

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  # firmware updates
  services.fwupd.enable = true;

  hardware.enableRedistributableFirmware = true;
  #hardware.cpu.intel.updateMicrocode = true;

  colorScheme = inputs.nix-colors.colorSchemes.${settings.colorScheme};

  system.stateVersion = "24.05";
}
