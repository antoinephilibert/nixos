{ config, pkgs, ...}:

with import <nixpkgs> { };

{
  imports = [
     ./programs.nix
  ];

}
