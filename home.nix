{ config, pkgs, ... }:

let
  systemType = builtins.currentSystem;
in
{
  imports = [ ./config.nix ];

  targets.genericLinux.enable = systemType == "x86_64-linux";
  home.username = systemType == "x86_64-linux" ? "ando" : "gauthsvenkat";
  home.homeDirectory = systemType == "x86_64-linux" ? "/home/ando" : "/Users/gauthsvenkat";
}
