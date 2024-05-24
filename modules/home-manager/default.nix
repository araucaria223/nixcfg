{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # specify stuff to keep on reboot
    ./services/impermanence.nix

    # compositor
    ./desktop/hyprland.nix

    # idle hibernation / locking
    ./desktop/hypridle.nix

    # lock screen
    ./desktop/hyprlock.nix

    # wallpaper
    ./desktop/hyprpaper.nix

    # bar
    ./desktop/waybar/waybar.nix

    # notifications
    ./desktop/mako.nix
    # widgets (will replace mako eventually)
    ./desktop/ags/ags.nix

    # theming
    ./desktop/cursor.nix
    ./desktop/font.nix
    ./desktop/gtk.nix

    # dmenu / launchers
    ./desktop/bemenu.nix
    ./desktop/fuzzel.nix

    # shell
    ./terminal/zsh.nix
    ./terminal/starship.nix
    ./terminal/git.nix
    
    # text editor
    ./terminal/neovim.nix

    # file managers
    ./terminal/lf/lf.nix
    ./terminal/yazi.nix

    # system monitor
    ./terminal/bottom.nix

    # fuzzy finder
    ./terminal/fzf.nix

    # terminals
    ./applications/kitty.nix
    ./applications/alacritty.nix

    # browsers
    ./applications/firefox.nix
    ./applications/librewolf.nix
    ./applications/brave.nix

    # pdf reader
    ./applications/zathura.nix

    # file manager
    ./applications/pcmanfm.nix

    # chat client
    ./applications/discord.nix

    # ide
    ./applications/vscode.nix
  ];

  impermanence.enable = lib.mkDefault true;
  zsh.enable = lib.mkDefault true;
  starship.enable = lib.mkDefault true;
  neovim.enable = lib.mkDefault true;
  git.enable = lib.mkDefault true;

  hyprland.enable = lib.mkDefault true;
  hypridle.enable = lib.mkDefault true;
  hyprlock.enable = lib.mkDefault true;
  hyprpaper.enable = lib.mkDefault true;

  mako.enable = lib.mkDefault true;
  cursor.enable = lib.mkDefault true;
  font.enable = lib.mkDefault true;
  gtkTheme.enable = lib.mkDefault true;
  bemenu.enable = lib.mkDefault true;
  fuzzel.enable = lib.mkDefault true;
  ags.enable = lib.mkDefault true;
  waybar.enable = lib.mkDefault true;

  alacritty.enable = lib.mkDefault false;
  kitty.enable = lib.mkDefault true;
  lf.enable = lib.mkDefault true;
  yazi.enable = lib.mkDefault true;
  pcmanfm.enable = lib.mkDefault true;
  bottom.enable = lib.mkDefault true;
  
  firefox.enable = lib.mkDefault true;
  librewolf.enable = lib.mkDefault true;
  brave.enable = lib.mkDefault true;
  
  zathura.enable = lib.mkDefault true;
  discord.enable = lib.mkDefault true;
  vscode.enable = lib.mkDefault true;
  fzf.enable = lib.mkDefault true;
}
