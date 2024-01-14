{ config, pkgs, ... }:

let
  linux_flag = builtins.currentSystem == "x86_64-linux";
in
{
  imports = [ ./config.nix ];

  targets.genericLinux.enable = linux_flag;
  home.username = if linux_flag then "ando" else "gauthsvenkat";
  home.homeDirectory = if linux_flag then "/home/ando" else "/Users/gauthsvenkat";
}
