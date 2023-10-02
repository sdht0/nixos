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
    system = "x86_64-linux";
    hosts = {
      niximaeus = {
        inherit system;
        timezone = "America/Toronto";
        locale = "en_CA.UTF-8";
      };
      medialando =  {
        inherit system;
        timezone = "America/Toronto";
        locale = "en_US.UTF-8";
      };
    };
    mainuser = rec {
      username = "artimaeus";
      uid = 1000;
      groupname = username;
      gid = uid;
    };
    testuser = {
      username = "sdhtest";
    };
    testuser2 = {
      username = "sdhtest2";
    };
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    nixosConfigurations =  nixpkgs.lib.mapAttrs (host: values: nixpkgs.lib.nixosSystem {
        system = values.system;
        specialArgs = { inherit mainuser; host = values // { hostname = host; }; };
        modules = [
          ./hosts/${host}/system.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = {
              ${mainuser.username} = import ./hosts/${host}/home.nix;
              ${testuser.username} = import ./hosts/${host}/home-${testuser.username}.nix;
              ${testuser2.username} = import ./hosts/${host}/home-${testuser2.username}.nix;
            };
            home-manager.extraSpecialArgs = { inherit mainuser testuser testuser2; };
          }
        ];
      }) hosts;
  };
}
