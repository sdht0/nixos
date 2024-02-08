{ config, pkgs, ... }:

{
  services.fprintd.enable = false;
  security.pam.services.sudo.fprintAuth = false;
}
