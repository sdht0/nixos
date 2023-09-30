{ config, pkgs, ... }:

{
  boot.kernelModules = [ "kvm-intel" ];
  hardware.cpu.intel.updateMicrocode = true;
  hardware.opengl.extraPackages = with pkgs; [ intel-media-driver ];
  powerManagement.cpuFreqGovernor = "powersave";

  environment.systemPackages = with pkgs; [
    intel-gpu-tools libva-utils
  ];
}
