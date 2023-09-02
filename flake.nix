{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ nixpkgs, ... }:
    let
      mkSystem = { system, ... }: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
          settings = import ./settings.nix;
        };
        modules = [
          ./iso.nix
          ./modules
          ./system
        ];
      };
    in
    {
      nixosConfigurations = rec {
        default = x86_64;
        x86_64 = mkSystem { system = "x86_64-linux"; };
        i686 = mkSystem { system = "i686-linux"; };
      };
    };
}
