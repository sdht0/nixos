{ lib, config, pkgs, ... }:
{
  nix.package = pkgs.nixVersions.latest;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    use-xdg-base-directories = true;
    warn-dirty = false;
  };
  nix.gc.automatic = false;
  nix.gc.dates = "daily";
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp/nix-daemon";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = hostData.system;

  documentation.doc.enable = false;
}
