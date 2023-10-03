{
  description = "Artimaeus NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
  let
    system = "x86_64-linux";

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

    pkgs = nixpkgs.legacyPackages.${system};

    userMapAttrFn = hostname:
      user: userData: nixpkgs.lib.nameValuePair
        userData.username
        (import ./hosts/${hostname}/home-${user}.nix { inherit (userData) username; });

    hostMapFn = hostname: hostData: nixpkgs.lib.nixosSystem {
      system = hostData.system;
      specialArgs = { hostData = hostData // { inherit hostname; }; };
      modules = [
        ./hosts/${hostname}/system.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            users = nixpkgs.lib.mapAttrs' (userMapAttrFn hostname) hostData.users;
            extraSpecialArgs = { inherit (hostData) users; };
            useGlobalPkgs = true;
            useUserPackages = true;
          };
        }
      ];
    };
  in
  {
    nixosConfigurations =  nixpkgs.lib.mapAttrs hostMapFn hosts;
  };
}
