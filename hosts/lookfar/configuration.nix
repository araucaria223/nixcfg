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

  #sops.defaultSopsFile = ../../secrets/secrets.yaml;
  #sops.defaultSopsFormat = "yaml";
  #sops.secrets.adzuki-password = {};

  networking.hostName = "${settings.hostname}";

  #time.timeZone = "Europe/London";
  services.automatic-timezoned.enable = true;
  i18n.defaultLocale = "en_GB.UTF-8";

  # firmware updates
  services.fwupd.enable = true;

  hardware.enableRedistributableFirmware = true;
  #hardware.cpu.intel.updateMicrocode = true;

  colorScheme = inputs.nix-colors.colorSchemes.${settings.colorScheme};

  services.openssh.enable = true;

  nh.enable = false;

  system.stateVersion = "24.05";
}
