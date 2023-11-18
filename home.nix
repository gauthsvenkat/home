{ config, pkgs, ... }:

{
  imports = [ ./config.nix ];
  
  # For generic linux machines
  targets.genericLinux.enable = true;
  home.username = "ando";
  home.homeDirectory = "/home/ando";
}
