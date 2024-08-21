{lib, pkgs, ...}: {
  imports = [
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./neovim.nix
    ./lf
    ./yazi.nix
    ./bottom.nix
    ./fzf.nix
    ./direnv.nix
    ./ncspot.nix
  ];

  home.packages = with pkgs; [
    # disk usage analyser
    ncdu
  ];

  # shell
  zsh.enable = lib.mkDefault true;
  # prompt
  starship.enable = lib.mkDefault true;
  # nix dev environments
  direnv.enable = lib.mkDefault true;

  # version manager
  git.enable = lib.mkDefault true;

  # text editor
  neovim.enable = lib.mkDefault true;

  # file managers
  lf.enable = lib.mkDefault true;
  yazi.enable = lib.mkDefault true;

  # system monitor
  bottom.enable = lib.mkDefault true;

  # spotify client
  ncspot.enable = lib.mkDefault true;

  programs.yt-dlp.enable = true;
}
