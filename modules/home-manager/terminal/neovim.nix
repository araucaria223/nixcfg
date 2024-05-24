{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  cfg = config.neovim;
in {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.neovim = {
    enable = lib.mkEnableOption "Enables neovim";
  };

  config = lib.mkIf cfg.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      #colorschemes.base16 = {
      #  enable = true;
      #	colorscheme = "${config.colorscheme.slug}";
      #};

      colorschemes.rose-pine.enable = true;

      clipboard = {
	register = "unnamedplus";
	providers.wl-copy.enable = true;
      };

      opts = {
        number = true;
        shiftwidth = 2;
      };

      keymaps = [
        {
          mode = "n";
          key = "j";
          action = "jzz";
        }
        {
          mode = "n";
          key = "n";
          action = "nzzzv";
        }
        {
          mode = "n";
          key = "k";
          action = "kzz";
        }
        {
          mode = "n";
          key = "fm";
          action = "<cmd>%!${pkgs.alejandra}/bin/alejandra -qq<CR>";
        }
      ];

      globals.mapleader = ",";

      plugins = {
        lualine.enable = true;

        telescope.enable = true;
        treesitter = {
	  enable = true;
	  #folding = true;
	  indent = true;
	  nixvimInjections = true;
	};

        lsp = {
          enable = true;

          servers = {
            lua-ls.enable = true;
          };
        };

	better-escape = {
	  enable = true;
	  mapping = ["jk"];
	  timeout = 100;
	};

        cmp = {
          enable = true;
          settings = {
            autoEnableSources = true;
            sources = [
              {name = "nvim_lsp";}
              {name = "path";}
              {name = "buffer";}
            ];
          };
        };
      };
    };
  };
}
