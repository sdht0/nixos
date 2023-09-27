{
  description = "Artimaeus NixOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {
    nixosConfigurations.niximaeus = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./hosts/niximaeus.nix ] ;
    };
  };
}
