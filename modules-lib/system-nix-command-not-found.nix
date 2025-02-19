{
  lib,
  config,
  pkgs,
  ...
}:
{
  programs.command-not-found.enable = false; # Does not work on flake-based systems
  programs.zsh.interactiveShellInit = ''
    source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
  '';
}
