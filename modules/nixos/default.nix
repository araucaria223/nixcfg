{
  config,
  lib,
  inputs,
  outputs,
  ...
}: {
  imports = [
    ./system
    ./other
  ];

  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.stable-packages
      outputs.overlays.master-packages
    ];

    config.allowUnfree = true;
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # enable flakes
      experimental-features = ["nix-command" "flakes"];
      # disable global registry
      flake-registry = "";
      # workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
      # optimise the nix store on rebuild
      auto-optimise-store = true;

      # use the nix community cachix
      substituters = ["https://nix-community.cachix.org"];
      trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    };
    # disable channels
    channel.enable = false;

    # make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;

    # enable automatic garbage collection of generations older than 7 days
    gc = lib.mkIf (!config.nh.enable) {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  # firmware updates
  services.fwupd.enable = true;
  hardware.enableAllFirmware = true;
}
