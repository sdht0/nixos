{
  config,
  pkgs,
  hostData,
  ...
}:

{
  security.acme.acceptTerms = true;
  security.acme.defaults = {
    email = "letsencrypt@sdht.in";
    dnsResolver = "1.1.1.1:53";
  };
  security.acme.certs."sdht.in" = {
    domain = "*.sdht.in";
    dnsProvider = "cloudflare";
    environmentFile = hostData.cloudflareKeyFile;
  };
}
