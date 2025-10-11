{ ... }:
{
  imports = [
    ../../../modules-lib/system-nix-linux.nix
    ../../../modules-lib/system-nix-ld.nix

    ../../../modules-lib/system-qemu.nix
    ../../../modules-lib/system-zfs.nix
    ../../../modules-lib/system-audio.nix
    ../../../modules-lib/system-basic-linux.nix
    ../../../modules-lib/system-initrd-systemd.nix
    ../../../modules-lib/system-oom.nix
    ../../../modules-lib/system-plasma6.nix
    ../../../modules-lib/system-systemd-boot.nix
    ../../../modules-lib/system-users.nix
    ../../../modules-lib/system-users-autologin.nix
    ../../../modules-lib/system-watchdog-disable.nix

    ../../../modules-lib/networking-networkmanager.nix
    ../../../modules-lib/networking-tailscale.nix

    ../../../modules-lib/pkgs-common-linux.nix
    ../../../modules-lib/pkgs-podman.nix
    ../../../modules-lib/pkgs-syncthing.nix
    ../../../modules-lib/pkgs-sshagent.nix
    ../../../modules-lib/pkgs-fonts.nix
    ../../../modules-lib/pkgs-dev-nix.nix
    ../../../modules-lib/pkgs-selfwatcher.nix
    ../../../modules-lib/pkgs-debuginfod.nix
  ];
}
