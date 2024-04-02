{
  description = "Artimaeus NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/master";
    # nixpkgsMaster.url = "github:nixos/nixpkgs/master";
    nixpkgs2311.url = "github:nixos/nixpkgs/release-23.11";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixOlde = {
      url = "github:trofi/nix-olde";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
  let
    lib = inputs.nixpkgs.lib;

    system = "x86_64-linux";

    mainuser = rec {
      username = "artimaeus";
      uid = 1000;
      groupname = username;
      gid = uid;
    };
    # testuser = {
    #   username = "sdhtest";
    # };
    # testuser2 = {
    #   username = "sdhtest2";
    # };

    hosts = {
      niximaeus = {
        inherit system;
        timezone = "America/Toronto";
        locale = "en_CA.UTF-8";
        users = { inherit mainuser; };
      };
      medialando =  {
        inherit system;
        timezone = "America/Toronto";
        locale = "en_US.UTF-8";
        users = { inherit mainuser; };
      };
    };

    f_userMapAttr = hostname:
      user: userData: lib.nameValuePair
        userData.username
        (import ./hosts/${hostname}/home-${user}.nix { inherit (userData) username; });

    f_hostMap = hostname: hostData: lib.nixosSystem {
      system = hostData.system;
      specialArgs = { hostData = hostData // { inherit hostname; }; inherit inputs; };
      modules = [
        ./hosts/${hostname}/configuration.nix
        inputs.homeManager.nixosModules.home-manager {
          home-manager = {
            users = lib.mapAttrs' (f_userMapAttr hostname) hostData.users;
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
    nixosConfigurations =  lib.mapAttrs f_hostMap hosts;
  };
}
