{
  lib,
  config,
  pkgs,
  hostData,
  ...
}:
{
  nix.package = pkgs.nixVersions.latest;
  documentation.doc.enable = false;

  # Use a purely flake-based system
  nix.channel.enable = false;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    use-xdg-base-directories = true;
    warn-dirty = false;
  };
  nixpkgs.config.allowUnfree = true;
  nix.optimise.automatic = true;

  nixpkgs.hostPlatform = hostData.system;

  environment.systemPackages = (
    with pkgs;
    [
      nix-output-monitor
      nvd
    ]
  );
}
