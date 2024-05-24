{ ... }:

{
  imports = [
    ./impermanence.nix
  ];
  
  # specify persistence in $HOME
  impermanence.enable = lib.mkDefault true;
}
