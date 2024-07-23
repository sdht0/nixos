{ lib, config, pkgs, hostData, inputs, ... }:
let
  lib' = import ../../lib { inherit config lib; };

  nixpkgsLink = "/etc/nix/nixpkgs";

  f_userMap = user: {
    users.${user.username} = {
      uid = user.uid or null;
      group = user.groupname or user.username;
      isNormalUser = true;
      shell = pkgs.zsh;
      extraGroups = [ "wheel" ];
    };
    groups.${user.username}.gid = user.gid or null;
  };
  f_userFold = list: builtins.foldl' (final: l: lib.attrsets.recursiveUpdate final l)  {} list;
  users = f_userFold (map f_userMap (lib.attrsets.attrValues hostData.users));
in
{
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;
  documentation.doc.enable = false;

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

  networking.hostName = hostData.hostname;
  nixpkgs.hostPlatform = hostData.system;
  time.timeZone = hostData.timezone;
  i18n.defaultLocale = hostData.locale;
  services.fwupd.enable = true;

  networking.networkmanager = {
    enable = true;
    wifi.macAddress = "stable";
    ethernet.macAddress = "stable";
    insertNameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
    };
  };
  networking.firewall.enable = false;
  services.resolved = {
    enable = true;
    fallbackDns = [ "1.1.1.1" "8.8.8.8" ];
  };

  environment.systemPackages = with pkgs; [
    linux-firmware sof-firmware
  ];

  inherit users;

  environment.etc = (lib'.f_extraScript "dotfilesClone" ''
    [[ -d ~/.dotfiles ]] || git clone https://github.com/sdht0/dotfiles ~/.dotfiles
    cd ~/.dotfiles
    git submodule init
    git submodule update --recursive --remote
    git remote set-url origin git@github.com:sdht0/dotfiles.git
  '');

  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.shellAliases = { ls = null; l = null; ll = null; }; # Remove defaults
}
