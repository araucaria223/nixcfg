{ config, lib, inputs, ... }:

let
  cfg = config.ags;
in
{
  imports = [ inputs.ags.homeManagerModules.default ];
  
  options.ags = {
    enable = lib.mkEnableOption "Enables ags";
  };

  config = lib.mkIf cfg.enable {
    programs.ags = {
      enable = true;

      configDir = ./config;
    };
  };
}
