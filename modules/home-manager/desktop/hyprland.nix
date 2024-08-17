{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  cfg = config.hyprland;

  screenshot = pkgs.writeShellApplication {
    name = "screenshot";
    runtimeInputs = with pkgs; [grim slurp swappy];
    text = ''
      pgrep slurp || grim -g "$(slurp)" - | swappy -f -
    '';
  };

  color-picker = pkgs.writeShellApplication {
    name = "color-picker";
    runtimeInputs = with pkgs; [hyprpicker];
    text = ''
      hyprpicker --autocopy
    '';
  };
in {
  options.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland";
    monitor = lib.mkOption {
      default = "eDP-1,2256x1504@60,0x0,1";
      description = "Primary monitor";
    };
  };

  config = lib.mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        extraPortals = [pkgs.xdg-desktop-portal-hyprland];
	configPackages = [pkgs.xdg-desktop-portal-hyprland];
      };

      mimeApps = {
        enable = true;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;

      plugins = with inputs.hyprland-plugins.packages."${pkgs.stdenv.hostPlatform.system}"; [
	hyprexpo
      ];

      settings = {
        monitor = [
          "${cfg.monitor}"
        ];

        input = {
          follow_mouse = "true";

          touchpad = {
            natural_scroll = "false";
            scroll_factor = "0.6";
	    disable_while_typing = "true";
          };
        };

        general = {
          gaps_in = "5";
          gaps_out = "10";
          border_size = "1";

          layout = "dwindle";
        };

        decoration = {
          rounding = "0";
          drop_shadow = "true";
          shadow_range = "4";
          shadow_render_power = "3";
        };

        animations = {
          enabled = "true";

          bezier = [
            "myBezier, 0.05, 0.9, 0.1, 1.05"

            "linear, 0, 0, 1, 1"
            "md3_standard, 0.2, 0, 0, 1"
            "md3_decel, 0.05, 0.7, 0.1, 1"
            "md3_accel, 0.3, 0, 0.8, 0.15"
            "overshot, 0.05, 0.9, 0.1, 1.1"
            "crazyshot, 0.1, 1.5, 0.76, 0.92"
            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
            "menu_decel, 0.1, 1, 0, 1"
            "menu_accel, 0.38, 0.04, 1, 0.07"
            "easeInOutCirc, 0.85, 0, 0.15, 1"
            "easeOutCirc, 0, 0.55, 0.45, 1"
            "easeOutExpo, 0.16, 1, 0.3, 1"
            "softAcDecel, 0.26, 0.26, 0.15, 1"
            "md2, 0.4, 0, 0.2, 1"
          ];

          animation = [
            "windows, 1, 7, myBezier"
            #"windows, 1, 7, default, popin 80%"
            "windowsIn, 1, 7, myBezier, slide"
            "windowsOut, 1, 7, default, slide"

            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
            "specialWorkspace, 1, 3, md3_decel, slidevert"
          ];
        };

        dwindle = {
          pseudotile = "true";
          preserve_split = "true";
        };

        gestures = {
          workspace_swipe = "true";
          workspace_swipe_distance = "400";
          workspace_swipe_invert = "false";
          workspace_swipe_min_speed_to_force = "0";
          workspace_swipe_cancel_ratio = "0.2";
        };

        misc = {
          disable_hyprland_logo = "true";
          vfr = "true";
	  vrr = 1;
          enable_swallow = "true";
          swallow_regex = "^(kitty)$";
	  swallow_exception_regex = "^(wev)$";

          focus_on_activate = "true";
        };

	windowrule = [
	  "move 0 0,title:^(Save Image)(.*)$"
	];

        windowrulev2 = [
          "suppressevent maximize, class:.*"

          "float, class:(qalculate-gtk)"
          "workspace special:calculator,class:(qalculate-gtk)"

	  #"fullscreenstate 0 2,class:(firefox)"
	  #"syncfullscreen 0,class:(firefox)"
        ];

        exec-once = [
          "[workspace special:system silent] ${pkgs.kitty}/bin/kitty -e ${pkgs.bottom}/bin/btm -b"
	  "${pkgs.waybar}/bin/waybar"
        ];

        "$mod" = "SUPER";

        bind = let
	  kty = "${pkgs.kitty}/bin/kitty";
	  pmx = "${pkgs.pamixer}/bin/pamixer";
	  fzl = "${pkgs.fuzzel}/bin/fuzzel";
	  bmj = "${pkgs.bemoji}/bin/bemoji";
	  scr = "${screenshot}/bin/screenshot";
	  cpk = "${color-picker}/bin/color-picker";
	  hpl = "${pkgs.hyprlock}/bin/hyprlock";
	  cal = "${pkgs.qalculate-gtk}/bin/qalculate-gtk";
	  btm = "${pkgs.kitty}/bin/kitty -e ${pkgs.bottom}/bin/btm -b";
	  bct = "${pkgs.brightnessctl}/bin/brightnessctl";
	in [
            "$mod, Q, killactive"
            "$mod, V, togglefloating"
            "$mod, F, fullscreen"

	    # deprecated
	    # "$mod SHIFT, F, fakefullscreen"

            "$mod, D, togglesplit"
	    "$mod SHIFT, Space, hyprexpo:expo, toggle"

            ",XF86AudioRaiseVolume, exec, ${pmx} -i 5"
            ",XF86AudioLowerVolume, exec, ${pmx} -d 5"
            ",XF86AudioMute, exec, ${pmx} --toggle-mute"

	    ",XF86MonBrightnessUp, exec, ${bct} s +5%"
	    ",XF86MonBrightnessDown, exec, ${bct} s 5%-"

            "$mod, Return, exec, ${kty}"
            "$mod, Space, exec, pgrep fuzzel || ${fzl}"
	    "$mod, e, exec, pgrep fuzzel || ${bmj}"

	    "$mod SHIFT, S, exec, ${scr}"
            "$mod SHIFT, L, exec, pgrep hyprlock || ${hpl}"
	    "$mod SHIFT, C, exec, ${cpk}"

            "$mod, L, movefocus, l"
            "$mod, H, movefocus, r"
            "$mod, K, movefocus, u"
            "$mod, J, movefocus, d"

            "$mod, mouse_down, workspace, e+1"
            "$mod, mouse_up, workspace, e-1"

            "$mod, I, exec, pgrep btm && hyprctl dispatch togglespecialworkspace system || ${btm} &"
	    "$mod SHIFT, I, movetoworkspace, system"

            "$mod, C, exec, pgrep qalculate-gtk && hyprctl dispatch togglespecialworkspace calculator || ${cal} &"
          ]
          ++ (
            builtins.concatLists (builtins.genList (
                x: let
                  ws = let
                    c = (x + 1) / 10;
                  in
                    builtins.toString (x + 1 - (c * 10));
                in [
                  "$mod, ${ws}, workspace, ${toString (x + 1)}"
                  "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
                ]
              )
              10)
          );

        bindm = [
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

	plugin = {
	  hyprexpo = {
	    columns = 3;
	    gap_size = 20;
	    #bg_col = "rgb(000000)";

	    workspace_method = "first 1";
	    enable_gesture = true;
	    gesture_fingers = 3;
	    gesture_distance = 200;
	    gesture_positive = true;
	  };
	};
      };
    };
  };
}
