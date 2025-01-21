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

  outputs =
    { ... }@inputs:
    let
      lib = inputs.nixpkgs.lib;
      lib' = import ./lib { inherit (inputs.nixpkgs) lib; };

      mainuser = rec {
        username = "artimaeus";
        uid = 1000;
        gid = uid;
      };

      hosts = {
        macimaeus-vm = {
          system = "aarch64-linux";
          timezone = "America/Toronto";
          locale = "en_CA.UTF-8";
          users = { inherit mainuser; };
        };
        medialando = {
          system = "x86_64-linux";
          timezone = "America/Toronto";
          locale = "en_US.UTF-8";
          users = { inherit mainuser; };
        };
        medialandoo = {
          system = "x86_64-linux";
          timezone = "America/Toronto";
          locale = "en_CA.UTF-8";
          users = { inherit mainuser; };
        };
      };

      hostsDarwin = {
        macimaeus = {
          system = "aarch64-darwin";
        };
      };

      f_hmUserConfigs =
        hostname: user: userData:
        lib.nameValuePair userData.username (
          import ./hosts/${hostname}/hm-${user}.nix { inherit (userData) username; }
        );

      f_nixosConfigs =
        hostname: hostData:
        lib.nixosSystem {
          system = hostData.system;
          specialArgs = {
            hostData = hostData // {
              inherit hostname;
            };
            inherit lib' inputs;
          };
          modules =
            [
              ./hosts/${hostname}/configuration.nix
              ./hosts/${hostname}/hardware.nix
              ./overlays
              inputs.homeManager.nixosModules.home-manager
              {
                home-manager = {
                  users = lib.mapAttrs' (f_hmUserConfigs hostname) hostData.users;
                  extraSpecialArgs = {
                    inherit (hostData) users;
                    inherit lib';
                  };
                  useGlobalPkgs = true;
                  useUserPackages = true;
                };
              }
            ]
            ++ lib.optionals (builtins.pathExists ./hosts/${hostname}/modules) (
              lib'.f_allPathsInDir ./hosts/${hostname}/modules
            );
        };

      f_darwinConfigs =
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
          ];
        };
    in
    {
      nixosConfigurations = lib.mapAttrs f_nixosConfigs hosts;

      darwinConfigurations = lib.mapAttrs f_darwinConfigs hostsDarwin;
    };
}
