{ lib, config, nixpkgs, pkgs, hostData, ... }:
let
  lib' = import ../../lib { inherit config lib; };

  nixpkgsLink = "/etc/nix/nixpkgs";

  userMapFn = user: {
    users.${user.username} = {
      uid = user.uid or null;
      group = user.groupname or user.username;
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
    };
    groups.${user.username}.gid = user.gid or null;
  };
  userFoldFn = list: builtins.foldl' (final: l: lib.attrsets.recursiveUpdate final l)  {} list;
  users = userFoldFn (map userMapFn (lib.attrsets.attrValues hostData.users));
in
{
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  documentation.doc.enable = false;
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp/nix-daemon";

  # Normalize nixpkgs version
  nix.registry.nixpkgs.flake = nixpkgs;
  nix.nixPath = [
    "nixpkgs=${nixpkgsLink}"
    "nixos-config=/etc/nixos/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];
  systemd.tmpfiles.rules = [ "L+ ${nixpkgsLink}     - - - - ${nixpkgs}" ];

  networking.hostName = hostData.hostname;
  nixpkgs.hostPlatform = hostData.system;
  time.timeZone = hostData.timezone;
  i18n.defaultLocale = hostData.locale;
  services.fwupd.enable = true;
  hardware.opengl.enable = true;

  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  services.resolved = {
    enable = true;
    dnssec = "false";
    domains = [ "~." ];
    fallbackDns = [ "1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one" ];
  };

  environment.systemPackages = with pkgs; [
    linux-firmware sof-firmware
  ];

  inherit users;

  environment.etc = (lib'.extraScript "dotfilesClone" ''
    [[ -d ~/.dotfiles ]] || git clone https://github.com/sdht0/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    git submodule init
    git submodule update --recursive --remote
    git remote set-url origin git@github.com:sdht0/dotfiles.git
  '');

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.shellAliases = { ls = null; l = null; ll = null; }; # Remove defaults

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
}
