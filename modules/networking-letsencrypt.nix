{ config, pkgs, ... }:

{
  security.acme.acceptTerms = true;
  security.acme.defaults = {
    email = "letsencrypt@sdht.in";
    dnsResolver = "1.1.1.1:53";
  };
  security.acme.certs."sdht.in" = {
    domain = "*.sdht.in";
    dnsProvider = "cloudflare";
    credentialsFile = "/var/lib/secrets/cloudflare.secret";
  };
}
