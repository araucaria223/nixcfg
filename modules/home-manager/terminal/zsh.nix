{
  config,
  lib,
  pkgs,
  settings,
  ...
}: let
  cfg = config.zsh;
in {
  options.zsh = {
    enable = lib.mkEnableOption ''
      Enable zsh - the z shell
    '';
  };

  config = lib.mkIf cfg.enable {
    # persist zsh history
    home.persistence."/persist/home/${config.home.username}".files = ["${config.xdg.dataHome}/zsh/history"];

    programs.zsh = {
      enable = true;

      dotDir = ".config/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";

      shellAliases = {
        ls = "${pkgs.eza}/bin/eza";
        lsa = "${pkgs.eza}/bin/eza -la";
        lst = "${pkgs.eza}/bin/eza --tree --icons";
        cat = "${pkgs.bat}/bin/bat --theme=base16";
        f = "${pkgs.fastfetch}/bin/fastfetch --load-config examples/9.jsonc";

	up = "nix flake update ${config.home.homeDirectory}/nixos";
	reb = "sudo nixos-rebuild switch --flake ~/nixos#${settings.hostname}";
      };
    };
  };
}
