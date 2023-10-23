{
  description = "Artimaeus NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/master";
    nixpkgsMaster.url = "github:nixos/nixpkgs/master";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgsMaster, nixpkgs, homeManager }:
  let
    system = "x86_64-linux";
    pkgsMaster = import nixpkgsMaster {inherit system; config.allowUnfree = true; };

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

    hosts = {
      niximaeus = {
        inherit system;
        timezone = "America/Toronto";
        locale = "en_CA.UTF-8";
        users = { inherit mainuser testuser testuser2; };
      };
      medialando =  {
        inherit system;
        timezone = "America/Toronto";
        locale = "en_US.UTF-8";
        users = { inherit mainuser; };
      };
    };

    userMapAttrFn = hostname:
      user: userData: nixpkgs.lib.nameValuePair
        userData.username
        (import ./hosts/${hostname}/home-${user}.nix { inherit (userData) username; });

    hostMapFn = hostname: hostData: nixpkgs.lib.nixosSystem {
      system = hostData.system;
      specialArgs = { hostData = hostData // { inherit hostname; }; inherit pkgsMaster; };
      modules = [
        ./hosts/${hostname}/configuration.nix
        homeManager.nixosModules.home-manager {
          home-manager = {
            users = nixpkgs.lib.mapAttrs' (userMapAttrFn hostname) hostData.users;
            extraSpecialArgs = { inherit (hostData) users; };
            useGlobalPkgs = true;
            useUserPackages = true;
          };
        }
        ({ lib, config, pkgs, ... }@args: { nixpkgs.overlays = import ./overlays args; })
      ];
    };
  in
  {
    nixosConfigurations =  nixpkgs.lib.mapAttrs hostMapFn hosts;
  };
}
