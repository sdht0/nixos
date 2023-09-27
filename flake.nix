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
    host = {
      hostname = "niximaeus";
      system = "x86_64-linux";
      timezone = "America/Toronto";
      locale = "en_CA.UTF-8";
    };
    user = rec {
      username = "artimaeus";
      uid = 1000;
      groupname = username;
      gid = uid;
    };
  in
  {
    nixosConfigurations = {
      ${host.hostname} = nixpkgs.lib.nixosSystem {
        system = host.system;
        specialArgs = { inherit host user; };
        modules = [
          ./hosts/${host.hostname}/system.nix
          # home-manager.nixosModules.home-manager {
          #   home-manager.useGlobalPkgs = true;
          #   home-manager.useUserPackages = true;
          #   home-manager.users.${user.username} = import ./hosts/${host.hostname}/home.nix;
          #   home-manager.extraSpecialArgs = { inherit user; };
          # }
        ];
      };
    };
  };
}
