{ config, lib, pkgs, hostData, nixOlde, ... }:

{
  imports = [
    ../../configs/system/common.nix
    ../../configs/system/intel.nix
    ../../configs/system/nvidia.nix
    ../../configs/system/ssd.nix
    ../../configs/system/logitech.nix
    ../../configs/system/fingerprintreader.nix
    ../../configs/system/canon-ts3420.nix

    ../../configs/packages/systemd-boot.nix
    ../../configs/packages/common.nix
    ../../configs/packages/plasma6.nix
    ../../configs/packages/syncthing.nix

    ./partitions.nix
  ];

  boot.loader.efi.efiSysMountPoint = "/efi";
  boot.loader.systemd-boot.xbootldrMountPoint = "/boot";

  boot.initrd.systemd.enable = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usbhid" "sdhci_pci" ];
  boot.kernelParams = [ "quiet" ];
  boot.blacklistedKernelModules = [ "iTCO_wdt" "iTCO_vendor_support" ]; # Disable watchdog

  boot.kernelPackages = pkgs.linuxPackages_latest;

  hardware.bluetooth.enable = true;

  services.dbus.implementation = "broker";

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = hostData.users.mainuser.username;
  };
  # services.xserver.displayManager.startx.enable = true;
  programs.ssh.startAgent = true;

  environment.systemPackages = (with pkgs; [
    firefox
    thunderbird zotero libreoffice-qt
    ffmpeg vlc
    mcomix foliate
    zoom-us slack
    obsidian fava
    activitywatch
    nil nixfmt
    rustup cargo rustc jetbrains-toolbox
    vscode
    gcc lldb temurin-bin-21
    gnumake
    bibtool drawio texliveFull
    (pkgs.python3.withPackages (ps: with ps; [
        beancount notebook pandas
        titlecase selenium bibtexparser # publications
        #vincenty folium numba
    ]))
    chromedriver
    nixOlde.packages.${pkgs.system}.nix-olde
  ]);
  fonts.packages = with pkgs; [
    jetbrains-mono meslo-lgs-nf
    noto-fonts noto-fonts-cjk-sans noto-fonts-color-emoji
  ];

  system.stateVersion = "23.05";
}
