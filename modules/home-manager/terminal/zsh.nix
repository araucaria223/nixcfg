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

      shellAliases = let
        flakeUp = "${pkgs.nix}/bin/nix flake update ${config.home.homeDirectory}/nixos";
	eza = "${pkgs.eza}/bin/eza";
	bat = "${pkgs.bat}/bin/bat";
	fastfetch = "${pkgs.fastfetch}/bin/fastfetch";
	nixos-rebuild = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
	git = "${pkgs.git}/bin/git -C ${config.home.homeDirectory}";
      in rec {
        ls = "${eza}";
        lsa = "${eza} -la";
        lst = "${eza} --tree --icons";
        cat = "${bat} --theme=base16";
        f = "${fastfetch} --load-config examples/9.jsonc";

        reb = "builtin command sudo ${nixos-rebuild} switch --flake ~/nixos#${settings.hostname} --option eval-cache false";
        up = "${flakeUp} && ${git} add flake.nix flake.lock && ${git} commit -m 'Flake update' && ${reb}";
      };
    };
  };
}
