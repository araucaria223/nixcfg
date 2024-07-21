{lib, ...}: {
  imports = [
    ./systemd-boot.nix
    ./plymouth.nix
    ./impermanence.nix
    ./home-manager.nix
    ./sops.nix
    ./user.nix
    ./doas.nix
    ./fprintd.nix
    ./pipewire.nix
    ./wifi.nix
    ./nh.nix
    ./nix.nix
    ./btrfs-scrub.nix
  ];

  # bootloader
  systemd-boot.enable = lib.mkDefault true;
  # boot splash screen
  plymouth.enable = lib.mkDefault true;
  # manage ephemeral filesystem
  impermanence.enable = lib.mkDefault true;
  # userspace management
  homeManager.enable = lib.mkDefault true;
  # secrets management
  sops-nix.enable = lib.mkDefault true;
  # main user account
  mainUser.enable = lib.mkDefault true;
  # lightweight sudo replacement
  doas.enable = lib.mkDefault false;
  # fingerprint authentification
  fprintd.enable = lib.mkDefault true;
  # pipewire audio
  pipewire.enable = lib.mkDefault true;
  # wireless
  wifi.enable = lib.mkDefault true;
  # nix tool with pretty output
  nh.enable = lib.mkDefault true;
  # basic nix settings changes
  nix-settings.enable = lib.mkDefault true;
  # btrfs filesystem scrubbing
  btrfs-scrub.enable = lib.mkDefault true;

  services.upower.enable = true;
}
