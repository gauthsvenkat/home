{
  description = "personal home-manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      agenix,
    }:
    {
      homeConfigurations."ando" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        # This will be passed to home.nix
        extraSpecialArgs = {
          inherit agenix;
        };
        modules = [
          agenix.homeManagerModules.default
          ./home.nix
        ];
      };
    };
}
