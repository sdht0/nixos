{
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
    checksec

    perf-tools
    bcc
    # bpftrace

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
  services.orca.enable = false;
  services.speechd.enable = false;
}
