{ config, pkgs, user, ... }:

{
  imports = [
    ../../configs/system/sshd.nix
    ../../configs/system/syncthing.nix
  ];

  environment.systemPackages = with pkgs; [ ];

  virtualisation.docker.enable = true;

  security.acme.acceptTerms = true;
  security.acme.defaults.email = "letsencrypt@sdht.in";
  security.acme.certs."sdht.in" = {
    domain = "*.sdht.in";
    dnsProvider = "cloudflare";
    credentialsFile = "/var/lib/secrets/cloudflare.secret";
  };
}
