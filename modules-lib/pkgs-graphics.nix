{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libva-utils
    vulkan-tools
    vulkan-validation-layers
    mesa-demos
  ];
}
