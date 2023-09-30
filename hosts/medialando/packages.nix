{ config, pkgs, user, ... }:

{
  imports = [
    ../../configs/system/sshd.nix
    ../../configs/system/syncthing.nix
    ../../configs/system/yt-dlp/package.nix
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

  users.users.nixosbld = {
    isSystemUser = true;
    shell = pkgs.zsh;
    group = "nixosbld";
  };
  users.groups.nixosbld = {};
  security.sudo.extraRules = [
    {
      users = [ "nixosbld" ];
      commands = [{ command = "ALL"; options = [ "NOPASSWD" ]; }];
    }
  ];
  users.users.nixosbld.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBnJMzanuL6IILWY0SvzzdNsixjCTSt30LLhdlqY3TDc niximaeus"
  ];
}
