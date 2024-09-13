{ lib, config, pkgs, hostData, ... }:
{
  nix.package = pkgs.nixVersions.latest;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    use-xdg-base-directories = true;
    warn-dirty = false;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = hostData.system;

  documentation.doc.enable = false;

  environment.systemPackages = (with pkgs; [
    nix-output-monitor nvd
  ]);
}
