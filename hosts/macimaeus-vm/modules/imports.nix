{
  ...
}:
{
  imports = [
    ../../../module-lib/option-python.nix

    ../../../module-lib/system-nix-common.nix
    ../../../module-lib/system-nix-linux.nix

    ../../../module-lib/hardware-firmware.nix

    ../../../module-lib/system-qemu.nix
    ../../../module-lib/system-basic.nix
    ../../../module-lib/system-users.nix
    ../../../module-lib/system-users-autologin.nix
    ../../../module-lib/system-btrfs-home-snapshots.nix
    ../../../module-lib/system-audio.nix
    ../../../module-lib/system-plasma6.nix
    ../../../module-lib/system-systemd-boot.nix
    ../../../module-lib/system-initrd-systemd.nix
    ../../../module-lib/system-watchdog-disable.nix
    ../../../module-lib/system-oom.nix

    ../../../module-lib/networking-networkmanager.nix
    ../../../module-lib/networking-mullvad.nix
    ../../../module-lib/networking-tailscale.nix

    ../../../module-lib/pkgs-common.nix
    ../../../module-lib/pkgs-podman.nix
    ../../../module-lib/pkgs-syncthing.nix
    ../../../module-lib/pkgs-sshagent.nix
    ../../../module-lib/pkgs-fonts.nix
    ../../../module-lib/pkgs-dev-nix.nix
    ../../../module-lib/pkgs-debuginfod.nix
    ../../../module-lib/pkgs-dev-python.nix
    ../../../module-lib/pkgs-beancount.nix
  ];
}
