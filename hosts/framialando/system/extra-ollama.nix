{ config, pkgs, ... }:
{
  hardware.amdgpu.opencl.enable = true;

  services.ollama.enable = true;
  services.ollama.acceleration = "rocm";
}
