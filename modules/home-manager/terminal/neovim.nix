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
    enable = lib.mkEnableOption ''
      Enable neovim -
	a powerful text editor
    '';
  };

  config = lib.mkIf cfg.enable {
    # shell alias
    programs.zsh.shellAliases = {v = "nvim";};

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
        mouse = "";
      };

      extraConfigVim = ''
        " Trigger a highlight in the appropriate direction when pressing these keys:
        let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

        " Trigger a highlight only when pressing f and F.
        let g:qs_highlight_on_keys = ['f', 'F']
      '';

      autoGroups = {
	write_quit = {};
      };

      autoCmd = [
	{
	  group = "write_quit";
	  event = ["BufWritePost" "VimLeave"];
	  pattern = "*";
	  callback = {
	    __raw = ''
	      function()
		vim.cmd [[cabbrev wq execute "Format sync" <bar> wq]]
	      end
	    '';
	  };
	}
      ];

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
          key = "<leader>fm";
          action = "<cmd>%!${pkgs.alejandra}/bin/alejandra -qq<CR>";
        }
      ];

      globals.mapleader = ",";

      plugins = {
        # status line
        lualine.enable = true;
        # shows indents
        indent-blankline.enable = true;
        # trims whitespace
        trim.enable = true;
	# startpage
	startify.enable = true;

        zen-mode = {
          enable = true;
          settings.plugins.twilight.enabled = true;
        };

        twilight = {
          enable = true;
          settings = {
            treesitter = true;
            expand = [
              "function"
              "method"
              "table"
              "if_statement"
            ];
          };
        };

        # colour picker and highlighting
        ccc = {
          enable = true;
          settings = {
            default_color = "#${config.colorScheme.palette.base00}";
            highlight_mode = "fg";
            highlighter.auto_enable = true;
          };
        };

        treesitter = {
          enable = true;
          folding = false;
          nixvimInjections = true;
          nixGrammars = true;
	  grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;

          settings = {
            highlight = {
	      enable = true;
	      additional_vim_regex_highlighting = true;
	    };
            indent.enable = true;
          };
        };

        treesitter-context.enable = true;
	cmp-treesitter.enable = true;

        lsp = {
          enable = true;

          servers = {
            tsserver.enable = true;

            lua-ls = {
              enable = true;
              settings.telemetry.enable = false;
            };

            rust-analyzer = {
              enable = true;
              installCargo = true;
              installRustc = true;
            };
          };
        };

	lsp-format.enable = true;

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
              {name = "luasnip";}
	      {name = "treesitter";}
            ];
          };
        };
      };

      extraPlugins = with pkgs.vimPlugins; [
        quick-scope
      ];
    };
  };
}
