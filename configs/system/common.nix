{ config, pkgs, host, user, ... }:
{
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System
  networking.hostName = host.hostname;
  nixpkgs.hostPlatform = host.system;
  time.timeZone = host.timezone;
  i18n.defaultLocale = host.locale;
  services.fwupd.enable = true;
  hardware.opengl.enable = true;

  # User
  users.users.${user.username} = {
    uid = user.uid;
    group = "${user.groupname}";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
  users.groups.${user.username}.gid = user.gid;
  # Additional setup for user: git clone git@github.com:sdht0/dotfiles.git ; git submodule update --recursive --remote

  # Networking
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  # System packages
  programs.zsh.enable = true;
  environment.shellAliases = { ls = null; l = null; ll = null; };
  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    linux-firmware sof-firmware
    gitFull wget curl rsync vim gnupg tmux htop ripgrep fzf eza peco sshfs
    firefox-devedition-bin chromium
    ffmpeg gcc gnumake
    nix-output-monitor
  ];
  services.tailscale.enable = true;
  # Additional setup for tailscale:
  # 1. Login: sudo tailscale login
  # 2. On signing node: a) Add new node: sudo tailscale lock sign ... ; b) Make it a signing node: sudo tailscale lock add ...
  # 3. On web: disable key expiry, add tag
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  systemd.services.mullvad-daemon.environment = {
    TALPID_NET_CLS_MOUNT_DIR= "/run/mullvad";
  };
}
