{ config, pkgs, ...}:

with import <nixpkgs> { };

{
  programs.home-manager.enable = true;

  home.stateVersion = "22.11";
  home.username = "antoine";
  home.homeDirectory = "/home/antoine";

  home.packages = with pkgs; [
     spotify
     nb
     bat
     w3m
     tidal-hifi
     neovim
     gcc
     nodejs
     cargo
  ];

  home = {
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.bash = {
     enable = true; 
     shellAliases = {
        "la" = "ls -la";
        "..." = "cd ../..";
     };
     initExtra = ''
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
     '';
  };

  programs.vscode = {
     enable = true;
     extensions = with pkgs.vscode-extensions; [
	vscodevim.vim
     ];
  };
  programs.git = {
     enable = true;
     userName = "Antoine Philibert";
     userEmail = "antoine.philibert@gmail.com";
  };
  
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
     "vscode"
     "spotify"
  ];
}
