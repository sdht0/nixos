{
  description = "Artimaeus NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    hosts = {
      niximaeus = {
        system = "x86_64-linux";
        timezone = "America/Toronto";
        locale = "en_CA.UTF-8";
      };
      medialando =  {
        hostname = "medialando";
        system = "x86_64-linux";
        timezone = "America/Toronto";
        locale = "en_US.UTF-8";
      };
    };
    user = rec {
      username = "artimaeus";
      uid = 1000;
      groupname = username;
      gid = uid;
    };
  in
  {
    nixosConfigurations =  nixpkgs.lib.mapAttrs (host: values: nixpkgs.lib.nixosSystem {
        system = values.system;
        specialArgs = { inherit user; host = values // { hostname = host; }; };
        modules = [
          ./hosts/${host}/system.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user.username} = import ./hosts/${host}/home.nix;
            home-manager.extraSpecialArgs = { inherit user; };
          }
        ];
      }) hosts;
  };
}
