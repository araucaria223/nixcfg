{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #hyprland.url = "git+https://github.com/andresilva/Hyprland?ref=nix-build-improvements&submodules=1";
    #hyprland.url = "github:hyprwm/Hyprland";
    #  hyprland-plugins = {
    #    url = "git+https://github.com/hyprwm/hyprland-plugins";
    #    inputs.hyprland.follows = "hyprland";
    #  };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    #  firefox-addons = {
    #    url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
    #    inputs.nixpkgs.follows = "nixpkgs";
    #  };
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
	    inputs.nixos-hardware.nixosModules.framework-12th-gen-intel;
            inputs.sops-nix.nixosModules.sops
          ];
        };
    };
  };
}
