{ config, ... }:
{
  boot.kernelModules = [ "bbswitch" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ bbswitch ];
  boot.extraModprobeConfig = ''
    options bbswitch load_state=0 unload_state=0
  '';
  boot.blacklistedKernelModules = [ "nouveau" ];
}
