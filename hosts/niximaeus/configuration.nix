{ config, lib, pkgs, hostData, ... }:

{
  imports = [
    ../../configs/system/common.nix
    ../../configs/system/intel.nix
    ../../configs/system/nvidia.nix
    ../../configs/system/ssd.nix
    ../../configs/system/logitech.nix
    ../../configs/system/fingerprintreader.nix
    ../../configs/system/canon-ts3420.nix
    ../../configs/system/systemd-boot/custom-systemd-boot.nix

    ../../configs/packages/common.nix
    ../../configs/packages/plasma5.nix
    ../../configs/packages/syncthing.nix

    ./partitions.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 25;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "sdhci_pci" ];
  boot.kernelParams = [ "quiet" ];
  boot.blacklistedKernelModules = [ "iTCO_wdt" "iTCO_vendor_support" ]; # Disable watchdog

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth.enable = true;

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = hostData.users.mainuser.username;
  };
  # services.xserver.displayManager.startx.enable = true;

  environment.systemPackages = (with pkgs; [
    thunderbird activitywatch
    ffmpeg vlc calibre mcomix
    nil nixfmt
    rustup gcc lldb openjdk17-bootstrap gnumake vscode
    fava
    zotero
    bc
    (pkgs.python3.withPackages (ps: with ps; [
        beancount notebook
        #vincenty folium numba
    ]))
    noto-fonts noto-fonts-cjk noto-fonts-emoji
    jetbrains-mono meslo-lgs-nf
    rust-rover-latest
    zoom-us slack obsidian
  ]);

  system.stateVersion = "23.05";
}
