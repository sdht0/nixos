{
  lib,
  config,
  pkgs,
  ...
}:
{
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;
    "kernel.nmi_watchdog" = 0;
    "kernel.kexec_load_disabled" = 1;
  };
}
