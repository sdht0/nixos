{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.command-not-found.enable = false; # Does not work on flake-based systems
  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
  };
}
