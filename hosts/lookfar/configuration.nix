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
  #time.timeZone = "UTC";
  #services.localtimed.enable = true;
  #services.automatic-timezoned.enable = true;
  #services.geoclue2 = {
  #  enable = true;
  #   appConfig."localtimed" = {
  #     isAllowed = true;
  #     isSystem = true;
  #     users = [ "325" ];
  #   };
  # };
  #location.provider = "geoclue2";

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
