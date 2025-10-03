{
  description = "Artimaeus NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/master";
    # nixpkgs.url = "github:nixos/nixpkgs/32fb99ba93fea2798be0e997ea331dd78167f814";
    # nixpkgs.url = "git+file:///home/artimaeus/Downloads/installations/osnixpkgs";
    # nixpkgs2505.url = "github:nixos/nixpkgs/release-25.05";

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
      inputs.utils.follows = "utils";
    };

    nixpkgs-darwin.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };

    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { ... }@inputs:
    let
      lib = inputs.nixpkgs.lib;
      lib' = import ./lib { inherit (inputs.nixpkgs) lib; };

      devShells_f =
        system:
        lib.mapAttrs (
          name: _: import ./shells/${name}/shell.nix { pkgs = import inputs.nixpkgs { inherit system; }; }
        ) (builtins.readDir ./shells);

      packages_f =
        system:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
          lib.mapAttrs (
            name: _: pkgs.callPackage ./packages/${name}/package.nix {  }
          ) (builtins.readDir ./packages);

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
              (lib'.filesInDir_f ./hosts/${hostname}/home/common)
              ++ (lib'.filesInDir_f ./hosts/${hostname}/home/${userId});
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
          modules = (lib'.filesInDir_f ./hosts/${hostname}/system) ++ [
            ./overlays
          ] ++ lib.optionals (!hostData.noHm or false) [
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
                sharedModules = [ inputs.plasmaManager.homeModules.plasma-manager ];
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
            ./overlays
          ] ++ lib'.filesInDir_f ./hosts/${hostname}/modules;
        };

      hostsData_f =
        isDarwin:
        lib.filterAttrs (_: hostData: (hostData.isDarwin or false) == isDarwin) (
          lib.mapAttrs (hostname: _: import ./hosts/${hostname}/host-data.nix) (builtins.readDir ./hosts)
        );

      hosts = hostsData_f false;
      hostsDarwin = hostsData_f true;
    in
    {
      nixosConfigurations = lib.mapAttrs nixosConfigs_f hosts;

      darwinConfigurations = lib.mapAttrs darwinConfigs_f hostsDarwin;
    }
    // inputs.utils.lib.eachDefaultSystem (system: {
      devShells = devShells_f system;
      packages = packages_f system;
    });
}
