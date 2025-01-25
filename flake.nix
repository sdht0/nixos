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
    plasmaManager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "homeManager";
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

  outputs =
    { ... }@inputs:
    let
      lib = inputs.nixpkgs.lib;
      lib' = import ./lib { inherit (inputs.nixpkgs) lib; };

      hmUserConfigs_f =
        hostname: userId: userData:
        let
          username = userData.username;
        in
        lib.nameValuePair username (
          { ... }:
          {
            home.username = username;
            imports =
              (lib'.filesInDir_f ./hosts/${hostname}/hm-common)
              ++ (lib'.filesInDir_f ./hosts/${hostname}/hm-${userId});
          }
        );

      nixosConfigs_f =
        hostname: hostData:
        lib.nixosSystem {
          system = hostData.system;
          specialArgs = {
            hostData = hostData // {
              inherit hostname;
            };
            inherit lib' inputs;
          };
          modules = (lib'.filesInDir_f ./hosts/${hostname}/modules) ++ [
            ./overlays
            inputs.homeManager.nixosModules.home-manager
            {
              home-manager = {
                users = lib.mapAttrs' (hmUserConfigs_f hostname) hostData.users;
                extraSpecialArgs = {
                  inherit (hostData) users;
                  inherit lib';
                };
                useGlobalPkgs = true;
                useUserPackages = true;
                sharedModules = [ inputs.plasmaManager.homeManagerModules.plasma-manager ];
              };
            }
          ];
        };

      darwinConfigs_f =
        hostname: hostData:
        inputs.nix-darwin.lib.darwinSystem {
          system = hostData.system;
          specialArgs = {
            hostData = hostData // {
              inherit hostname;
            };
            inherit inputs;
          };
          modules = [
            ./hosts/${hostname}/configuration.nix
            ./overlays
          ] ++ lib'.filesInDir_f ./hosts/${hostname}/modules;
        };

      hosts = lib'.hostsData_f false;
      hostsDarwin = lib'.hostsData_f true;
    in
    {
      nixosConfigurations = lib.mapAttrs nixosConfigs_f hosts;

      darwinConfigurations = lib.mapAttrs darwinConfigs_f hostsDarwin;
    };
}
