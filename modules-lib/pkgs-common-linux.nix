{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [ ./pkgs-common.nix ];

  # Remove defaults
  environment.shellAliases = {
    ls = null;
    l = null;
    ll = null;
  };

  environment.systemPackages = with pkgs; [
    tldr # --help
    killall

    nftables
    wget
    curl
    rsync
    sshfs
    dig

    sqlite

    gptfdisk
    pciutils
    dmidecode
  ];
  programs.nano.enable = false;
}
