{ lib, config, pkgs, hostData, ... }:
{
  nix.useDaemon = true;
  nix.package = pkgs.nixVersions.latest;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    use-xdg-base-directories = true;
    warn-dirty = false;
  };
  nix.gc.automatic = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = hostData.system;

  documentation.doc.enable = false;
}
