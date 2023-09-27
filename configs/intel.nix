{ config, pkgs, ... }:

{
  boot.kernelModules = [ "kvm-intel" ];
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;
  hardware.opengl.extraPackages = with pkgs; [ intel-media-driver ];
  powerManagement.cpuFreqGovernor = "powersave";
}
