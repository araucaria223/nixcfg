{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # secrets management
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # disk management
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    # hardware-specific optimisations
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # theming
    nix-colors.url = "github:misterio77/nix-colors";

    # home-manager module to configure neovim
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # emacs-overlay = {
    #   url = "github:nix-community/emacs-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.nixpkgs-stable.follows = "nixpkgs-stable";
    # };

    # nightly hyprland
    # removed currently due to issues with the cachix

    #hyprland.url = "git+https://github.com/andresilva/Hyprland?ref=nix-build-improvements&submodules=1";
    #hyprland.url = "github:hyprwm/Hyprland";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland-plugins = {
      url = "git+https://github.com/hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # extensible widgets
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: {
    homeManagerModules.default = ./modules/home-manager;
    nixosConfigurations = {
      amstrad =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit inputs;
            settings = import ./hosts/amstrad/settings.nix;
          };

          modules = [
            inputs.disko.nixosModules.default
            (import ./modules/nixos/system/disko.nix {device = "/dev/sda";})

            ./hosts/amstrad/configuration.nix
            ./modules/nixos

            inputs.home-manager.nixosModules.default
            inputs.impermanence.nixosModules.impermanence
            inputs.nixos-hardware.nixosModules.apple-macbook-air-6
            inputs.sops-nix.nixosModules.sops
          ];
        };
      lookfar =
        nixpkgs.lib.nixosSystem
        {
          specialArgs = {
            inherit inputs;
            settings = import ./hosts/lookfar/settings.nix;
          };

          modules = [
            inputs.disko.nixosModules.default
            (import ./hosts/lookfar/disko.nix {device = "/dev/nvme0n1";})

            ./hosts/lookfar/configuration.nix
            ./modules/nixos

            inputs.home-manager.nixosModules.default
            inputs.impermanence.nixosModules.impermanence
            inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
            inputs.sops-nix.nixosModules.sops
          ];
        };
    };
  };
}
