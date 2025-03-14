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
}
