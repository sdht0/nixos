{ config, pkgs, ... }:

{
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "amd_pstate=active" ];
  hardware.cpu.amd.updateMicrocode = true;
  hardware.graphics.enable = true;
  hardware.amdgpu.initrd.enable = true;
}