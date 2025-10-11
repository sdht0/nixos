{
  lib,
  config,
  pkgs,
  hostData,
  ...
}:
{
  networking.hostName = hostData.hostname;
  time.timeZone = hostData.timezone;
  i18n.defaultLocale = hostData.locale;

  boot.tmp.useTmpfs = true;
  services.dbus.implementation = "broker";

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "kernel.nmi_watchdog" = 0;
    "kernel.kexec_load_disabled" = 1;
  };
}
