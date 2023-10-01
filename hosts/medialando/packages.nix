{ config, pkgs, user, ... }:

{
  imports = [
    ../../configs/packages/common.nix

    ../../configs/packages/sshd.nix
    ../../configs/packages/syncthing.nix
    ../../configs/packages/yt-dlp/package.nix
  ];

  environment.systemPackages = with pkgs; [ nodejs ];

  virtualisation.docker.enable = true;
  programs.npm.enable = true;

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "letsencrypt@sdht.in";
  security.acme.certs."sdht.in" = {
    domain = "*.sdht.in";
    dnsProvider = "cloudflare";
    credentialsFile = "/var/lib/secrets/cloudflare.secret";
  };
}
