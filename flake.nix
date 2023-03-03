{
  description = "A very basic flake";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        antoine = lib.nixosSystem {
          inherit system;
          modules = [ ./configuration.nix ]; 
        };
      };

      hmConfig = {
        antoine = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
             ./home.nix
             {
                home = {
                  username = "antoine";
                  homeDirectory = "/home/antoine";
                  packages = [ pkgs.home-manager ];
                  stateVersion = "22.11";
                };
             }
          ];

          # username = "antoine";  
          # homeDirectory = "/home/antoine";
          # configuration = {
          #   imports = [
          #      ./home.nix
          #   ];
          # };
        };
      };
    };
}
