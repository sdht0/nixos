{ pkgs, ... }:
{
  hardware.amdgpu.opencl.enable = true;
  
  environment.systemPackages = with pkgs.rocmPackages; [
    clr
    rocminfo
  ];
}
