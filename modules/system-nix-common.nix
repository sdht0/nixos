{ lib, config, pkgs, hostData, ... }:
{
  nix.package = pkgs.nixVersions.latest;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    use-xdg-base-directories = true;
    warn-dirty = false;
  };
  nix.gc.automatic = true;
  nix.gc.dates = "daily";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = hostData.system;

  system.switch = {
    enable = false;
    enableNg = true;
  };

  documentation.doc.enable = false;

  environment.systemPackages = (with pkgs; [
    nix-output-monitor nvd
  ]);
}
