{ ... }:
{
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = false;
}
