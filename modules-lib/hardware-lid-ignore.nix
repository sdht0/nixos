{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.logind.settings.Login.HandleLidSwitch = "ignore";
}
