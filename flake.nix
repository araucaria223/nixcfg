{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    # alternative nix language implementation
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # user environment manager
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

    #hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    #hyprland.inputs.nixpkgs.follows = "nixpkgs-for-hyprland";
    # hyprland-plugins = {
    #   url = "git+https://github.com/hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    # extensible widgets
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #  hyprpanel = {
    #    url = "github:Jas-SinghFSU/HyprPanel";
    #    inputs.ags.follows = "ags";
    #    inputs.nixpkgs.follows = "nixpkgs";
    #  };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions?rev=2c15c14f9d4485b18d7cec54081bdfd76335cfc8";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    homeManagerModules.default = ./modules/home-manager;

    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    overlays = import ./overlays {inherit inputs;};

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
            (import ./hosts/amstrad/disko.nix {device = "/dev/sda";})

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
            inherit inputs outputs;
            settings = import ./hosts/lookfar/settings.nix;
          };

          modules = [
            inputs.disko.nixosModules.default
            (import ./hosts/lookfar/disko.nix {device = "/dev/nvme0n1";})

            ./hosts/lookfar/configuration.nix
	    ./modules/nixos

	    inputs.lix.nixosModules.default
            inputs.home-manager.nixosModules.default
            inputs.impermanence.nixosModules.impermanence
            inputs.nixos-hardware.nixosModules.framework-12th-gen-intel
            inputs.sops-nix.nixosModules.sops
          ];
        };
    };
  };
}
