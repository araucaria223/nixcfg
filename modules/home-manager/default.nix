{...}: {
  imports = [
    ./services
    ./terminal
    ./desktop
    ./applications
  ];

  nixpkgs.config.allowUnfree = true;
}
