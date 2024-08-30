{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.ags;

  snapshot = pkgs.writeShellApplication {
    name = "snapshot";
    runtimeInputs = with pkgs; [grimblast libnotify coreutils yazi swayimg kitty];
    text = ''
      outputDir=${config.home.homeDirectory}/media/screenshots
      outputFile="snapshot_$(date +%Y-%m-%d_%H-%M-%S).png"
      outputPath="$outputDir/$outputFile"
      mkdir -p "$outputDir"

      mode=''${1:-area}

      case "$mode" in
      active)
	command="grimblast copysave active $outputPath"
	;;
      output)
	command="grimblast copysave output $outputPath"
	;;
      area)
	command="grimblast copysave area $outputPath"
	;;
      *)
	echo "Invalid option: $mode"
	echo "Usage: $0 {active|output|area}"
	exit 1
	;;
      esac

      if eval "$command"; then
	recentFile=$(find "$outputDir" -name 'snapshot_*.png' -printf '%T+ %p\n' | sort -r | head -n 1 | cut -d' ' -f2-)
	notify-send "Grimblast" "Your snapshot has been saved." \
	  -i video-x-generic \
	  -a "Grimblast" \
	  -t 7000 \
	  -u normal \
	  --action="scriptAction:-kitty -e yazi $outputDir=Directory" \
	  --action="scriptAction:-swayimg $recentFile=View"
      fi
    '';
  };
in {
  imports = [inputs.ags.homeManagerModules.default];

  options.ags = {
    enable = lib.mkEnableOption ''
      Enable AGS widgets
    '';
  };

  config = lib.mkIf cfg.enable {
    programs.ags = {
      enable = true;
      configDir = ./.;
      extraPackages = with pkgs; [
        bun
	gtksourceview
	webkitgtk
	accountsservice
      ];
    };

    home.packages = with pkgs; [
      bun
      libnotify
      swww
      sass
      brightnessctl
      hyprpanel
    ]
    ++ [snapshot];
  };
}
