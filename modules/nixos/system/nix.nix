{
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.nix-settings;
in {
  options.nix-settings = {
    enable = lib.mkEnableOption ''
      Enables some basic nix settings
    '';
  };

  config = lib.mkIf cfg.enable {
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    nixpkgs.config.allowUnfree = true;
  };
}
