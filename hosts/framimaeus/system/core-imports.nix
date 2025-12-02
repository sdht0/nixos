{
  ...
}:
{
  imports = [
    ../../../modules-lib/system-nix-linux.nix

    ../../../modules-lib/hardware-amd.nix
    ../../../modules-lib/hardware-amd-rocm.nix
    ../../../modules-lib/hardware-firmware.nix
    ../../../modules-lib/hardware-ssd.nix

    ../../../modules-lib/system-basic-linux.nix
    ../../../modules-lib/system-initrd-systemd.nix
    ../../../modules-lib/system-systemd-boot.nix
    ../../../modules-lib/system-users.nix
    ../../../modules-lib/system-zfs.nix
    ../../../modules-lib/system-oom.nix
    ../../../modules-lib/system-watchdog-disable.nix

    ../../../modules-lib/networking-networkmanager.nix
    ../../../modules-lib/networking-mullvad.nix
    ../../../modules-lib/networking-sshd.nix
    ../../../modules-lib/networking-tailscale.nix

    ../../../modules-lib/pkgs-common-linux.nix
    ../../../modules-lib/pkgs-docker.nix
    ../../../modules-lib/pkgs-ollama.nix
    ../../../modules-lib/pkgs-graphics.nix
    ../../../modules-lib/pkgs-beancount.nix
  ];
}
