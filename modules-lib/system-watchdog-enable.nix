{ ... }:
{
  systemd.settings.Manager = {
    RuntimeWatchdogSec = "20s";
    RebootWatchdogSec = "10min";
  };
}
