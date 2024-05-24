{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.zsh;
in {
  options.zsh = {
    enable = lib.mkEnableOption "Enables zsh";
  };

  config = lib.mkIf cfg.enable {
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
        cat = "${pkgs.bat}/bin/bat";
        t = "${pkgs.eza}/bin/eza --tree --icons";
        f = "${pkgs.fastfetch}/bin/fastfetch --load-config examples/9.jsonc";
      };

      #  initExtra = ''
      #    eval $(${pkgs.thefuck}/bin/thefuck --alias)
      #  '';

      # initExtra = ''
      #   ${pkgs.fastfetch}/bin/fastfetch --load-config examples/9.jsonc
      # '';
    };
  };
}
