{
  description = "Artimaeus NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/master";
    # nixpkgs.url = "git+file:///home/artimaeus/Downloads/installations/osnixpkgs";
    # nixpkgs2311.url = "github:nixos/nixpkgs/release-23.11";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixOlde = {
      url = "github:trofi/nix-olde";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
  };

  outputs = { self, ... }@inputs:
  let
    lib = inputs.nixpkgs.lib;

    mainuser = rec {
      username = "artimaeus";
      uid = 1000;
      gid = uid;
    };

    hosts = {
      niximaeus = {
        system = "x86_64-linux";
        timezone = "America/Toronto";
        locale = "en_CA.UTF-8";
        users = { inherit mainuser; };
      };
      macimaeus-vm = {
        system = "aarch64-linux";
        timezone = "America/Toronto";
        locale = "en_CA.UTF-8";
        users = { inherit mainuser; };
      };
      medialando =  {
        system = "x86_64-linux";
        timezone = "America/Toronto";
        locale = "en_US.UTF-8";
        users = { inherit mainuser; };
      };
    };

    hostsDarwin = {
      macimaeus = {
        system = "aarch64-darwin";
      };
    };

    f_hmUserConfigs =
      hostname:
        user: userData:
          lib.nameValuePair
          userData.username
          (import ./hosts/${hostname}/hm-${user}.nix { inherit (userData) username; });

    f_nixosConfigs =
      hostname: hostData:
        lib.nixosSystem {
          system = hostData.system;
          specialArgs = { hostData = hostData // { inherit hostname; }; inherit inputs; };
          modules = [
            ./hosts/${hostname}/configuration.nix
            inputs.homeManager.nixosModules.home-manager {
              home-manager = {
                users = lib.mapAttrs' (f_hmUserConfigs hostname) hostData.users;
                extraSpecialArgs = { inherit (hostData) users; };
                useGlobalPkgs = true;
                useUserPackages = true;
              };
            }
            ({ lib, config, pkgs, ... }@args: { nixpkgs.overlays = import ./overlays args; })
          ];
        };

    f_darwinConfigs =
      hostname: hostData:
        inputs.nix-darwin.lib.darwinSystem {
          system = hostData.system;
          specialArgs = { hostData = hostData // { inherit hostname; }; inherit inputs; };
          modules = [
            ./hosts/${hostname}/configuration.nix
            ({ lib, config, pkgs, ... }@args: { nixpkgs.overlays = import ./overlays args; })
          ];
        };
  in
  {
    nixosConfigurations =  lib.mapAttrs f_nixosConfigs hosts;

    darwinConfigurations =  lib.mapAttrs f_darwinConfigs hostsDarwin;
  };
}
