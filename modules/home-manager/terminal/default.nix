{...}: {
  imports = [
    ./zsh.nix
    ./starship.nix
    ./git.nix
    ./neovim.nix
    ./lf/lf.nix
    ./yazi.nix
    ./bottom.nix
    ./fzf.nix
  ];

  # shell
  zsh.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;

  # version manager
  git.enable = lib.mkDefault true;

  # text editor
  neovim.enable = lib.mkDefault true;

  # file managers
  lf.enable = lib.mkDefault true;
  yazi.enable = lib.mkDefault true;

  # system monitor
  bottom.enable = lib.mkDefault true;
}
