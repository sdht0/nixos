{ hostData, ... }:
{
  networking.hostName = hostData.hostname;
  time.timeZone = hostData.timezone;
  i18n.defaultLocale = hostData.locale;

  boot.tmp.useTmpfs = true;
  services.dbus.implementation = "broker";

  boot.kernelParams = [ "nmi_watchdog=0" ];

  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "kernel.kexec_load_disabled" = 1;
  };
}
