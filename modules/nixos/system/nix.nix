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
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;

      # use the nix community cachix
      substituters = ["https://nix-community.cachix.org"];
      trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    };

    nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    nixpkgs.config.allowUnfree = true;
  };
}
