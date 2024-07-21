{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.yazi;
in {
  options.yazi = {
    enable = lib.mkEnableOption ''
      Enable yazi -
	a terminal file manager
    '';
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      wl-clipboard
      unar
      jq
      poppler
      fd
      ripgrep
      zoxide
      ffmpegthumbnailer
    ];

    programs.yazi = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        manager = {
          #layout = [2 3 5];
        };

        input = {
          find_origin = "bottom-left";
          find_offset = [0 2 50 3];
        };
      };

      theme = with config.colorScheme.palette; {
        status = {
          separator_open = "█";
          separator_close = "█";
          separator_style = {
            fg = "#${base02}";
            bg = "#${base02}";
          };

          mode_normal = {
            fg = "#${base00}";
            bg = "#${base0A}";
            bold = true;
          };

          mode_select = {
            fg = "#${base05}";
            bg = "#${base0C}";
            bold = true;
          };

          mode_unset = {
            fg = "#${base05}";
            bg = "#${base08}";
            bold = true;
          };

          progress_label = {
            fg = "#${base05}";
            bold = true;
          };

          progress_normal = {
            fg = "#${base00}";
            bg = "#${base02}";
          };

          progress_error = {
            fg = "#${base08}";
            bg = "#${base02}";
          };

          permissions_t = {fg = "#${base0B}";};
          permissions_r = {fg = "#${base0E}";};
          permissions_w = {fg = "#${base08}";};
          permissions_x = {fg = "#${base0C}";};
          permissions_s = {fg = "#${base0F}";};
        };

        manager = {
          cwd = {fg = "#${base0C}";};

          hovered = {
            fg = "#${base06}";
            bg = "#${base02}";
          };

          preview_hovered = {
            underline = true;
          };

          find_keyword = {
            fg = "#${base0E}";
            italic = true;
          };

          find_position = {
            fg = "#${base08}";
            bg = "reset";
            italic = true;
          };

          marker_selected = {
            fg = "#${base0C}";
            bg = "#${base0C}";
          };

          marker_copied = {
            fg = "#${base09}";
            bg = "#${base09}";
          };

          marker_cut = {
            fg = "#${base08}";
            bg = "#${base08}";
          };

          tab_active = {
            fg = "#${base06}";
            bg = "#${base00}";
          };

          tab_inactive = {
            fg = "#${base06}";
            bg = "#${base02}";
          };

          border_symbol = "|";

          border_style = {
            fg = "#${base07}";
          };
          tab_width = 1;
        };

        input = {
          border = {fg = "#${base07}";};
          title = {};
          value = {};
          selected = {reversed = true;};
        };

        select = {
          border = {fg = "#${base07}";};
          active = {fg = "#${base08}";};
          inactive = {};
        };

        tasks = {
          border = {fg = "#${base07}";};
          title = {};
          hovered = {underline = true;};
        };

        which = {
          mask = {bg = "#${base02}";};
          cand = {fg = "#${base0C}";};
          rest = {fg = "#${base04}";};
          desc = {fg = "#${base08}";};
          separator = "  ";
          separator_style = {fg = "#${base07}";};
        };

        help = {
          on = {fg = "#${base08}";};
          exec = {fg = "#${base0C}";};
          desc = {fg = "#${base04}";};
          hovered = {
            bg = "#${base07}";
            bold = true;
          };

          footer = {
            fg = "#${base02}";
            bg = "#${base05}";
          };
        };

	filetype.rules = [
	  { mime = "application/zip"; fg = "#${base08}"; }
	  { mime = "application/gzip"; fg = "#${base08}"; }
	  { mime = "application/x-tar"; fg = "#${base08}"; }
	  { mime = "application/x-bzip"; fg = "#${base08}"; }
	  { mime = "application/x-bzip2"; fg = "#${base08}"; }
	  { mime = "application/x-7z-compressed"; fg = "#${base08}"; }
	  { mime = "application/x-rar"; fg = "#${base08}"; }

	  { name = "*"; fg = "#${base05}"; }
	  { name = "*/"; fg = "#${base07}"; }
	];
      };
    };

    # shell wrapper that allows yazi to change the working directory on exit
    programs.zsh.initExtra = ''
           function yy() {
      local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
           	yazi "$@" --cwd-file="$tmp"
           	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        cd -- "$cwd"
           	fi
           	rm -f -- "$tmp"
           }
    '';
  };
}
