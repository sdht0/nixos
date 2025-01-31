{
  ...
}:
{
  imports = [
    ../../../modules/option-python.nix

    ../../../modules/system-nix-common.nix
    ../../../modules/system-nix-linux.nix

    ../../../modules/hardware-firmware.nix

    ../../../modules/system-qemu.nix
    ../../../modules/system-basic.nix
    ../../../modules/system-users.nix
    ../../../modules/system-users-autologin.nix
    ../../../modules/system-btrfs-home-snapshots.nix
    ../../../modules/system-audio.nix
    ../../../modules/system-plasma6.nix
    ../../../modules/system-systemd-boot.nix
    ../../../modules/system-initrd-systemd.nix
    ../../../modules/system-watchdog-disable.nix
    ../../../modules/system-oom.nix

    ../../../modules/networking-networkmanager.nix
    ../../../modules/networking-mullvad.nix
    ../../../modules/networking-tailscale.nix

    ../../../modules/pkgs-common.nix
    ../../../modules/pkgs-podman.nix
    ../../../modules/pkgs-syncthing.nix
    ../../../modules/pkgs-sshagent.nix
    ../../../modules/pkgs-fonts.nix
    ../../../modules/pkgs-dev-nix.nix
    ../../../modules/pkgs-debuginfod.nix
    ../../../modules/pkgs-dev-python.nix
    ../../../modules/pkgs-beancount.nix
  ];
}
