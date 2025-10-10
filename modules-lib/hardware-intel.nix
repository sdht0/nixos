{ pkgs, ... }:

{
  boot.kernelModules = [ "kvm-intel" ];
  hardware.cpu.intel.updateMicrocode = true;
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [ intel-media-driver ];
  powerManagement.cpuFreqGovernor = "powersave";

  environment.systemPackages = with pkgs; [
    intel-gpu-tools
    nvtopPackages.intel
  ];
  imports = [ ./pkgs-graphics.nix ];
}
