{ config, pkgs, host, user, ... }:
{
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = host.hostname;
  nixpkgs.hostPlatform = host.system;
  time.timeZone = host.timezone;
  i18n.defaultLocale = host.locale;
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

  users.users.${user.username} = {
    uid = user.uid;
    group = "${user.groupname}";
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
  };
  users.groups.${user.username}.gid = user.gid;
  programs.zsh.enable = true;
  environment.shells = with pkgs; [ zsh ];
  environment.shellAliases = { ls = null; l = null; ll = null; }; # Remove defaults

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
}
