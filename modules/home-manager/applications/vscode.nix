{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.vscode;
in {
  options.vscode = {
    enable = lib.mkEnableOption "Enables vscode";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [nixd];

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with inputs.nix-vscode-extensions.extensions.${pkgs.system}.vscode-marketplace; [
        vscodevim.vim
        yzhang.markdown-all-in-one
        mvllow.rose-pine
	jnoortheen.nix-ide
	esbenp.prettier-vscode
      ];

      userSettings = {
        workbench.colorTheme = "Rosé Pine";
	editor.defaultFormatter = "esbenp.prettier-vscode";
	editor.formatOnSave = true;
        #"[nix]"."editor.tabSize" = 2;
      };
    };
  };
}
