{
  config,
  lib,
  inputs,
  pkgs,
  settings,
  ...
}: let
  cfg = config.sops-nix;
in {
  options.sops-nix = {
    enable = lib.mkEnableOption ''
      Enable sops-nix
    '';
  };

  config = lib.mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age = {
        #sshKeyPaths = ["/persist/system/etc/ssh/ssh_host_ed25519_key"];
        #keyFile = "/persist/system/var/lib/sops-nix/key.txt";
        keyFile = "/persist/home/${settings.username}/.config/sops/age/keys.txt";
      };
    };

    environment.systemPackages = [pkgs.sops];
  };
}
