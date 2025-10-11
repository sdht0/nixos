{ ... }:
{
  services.tailscale.enable = true;
  systemd.services.tailscaled.serviceConfig.Environment = [ "TS_NO_LOGS_NO_SUPPORT=true" ];
}
