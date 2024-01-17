{ config, lib, pkgs, hostData, pkgsPrev, ... }:

{
  imports = [
    ../../configs/system/common.nix
    ../../configs/system/intel.nix
    ../../configs/system/nvidia.nix
    ../../configs/system/ssd.nix
    ../../configs/system/logitech.nix
    ../../configs/system/fingerprintreader.nix
    ../../configs/system/canon-ts3420.nix

    ../../configs/packages/systemd-boot-module/custom-systemd-boot.nix
    ../../configs/packages/systemd-boot.nix
    ../../configs/packages/common.nix
    ../../configs/packages/plasma5.nix
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

  services.xserver.displayManager.autoLogin = {
    enable = true;
    user = hostData.users.mainuser.username;
  };
  # services.xserver.displayManager.startx.enable = true;
  systemd.services.NetworkManager-wait-online = {
    serviceConfig = {
      ExecStart = [ "" "${pkgs.networkmanager}/bin/nm-online -q" ];
    };
  };

  environment.systemPackages = (with pkgs; [
    thunderbird zotero libreoffice-qt
    ffmpeg vlc
    calibre mcomix foliate
    zoom-us slack
    obsidian fava
    nil nixfmt
    rust-rover-overlay rustup cargo rustc
    vscode
    gcc lldb
    temurin-bin-21
    gnumake
    bibtool drawio (texlive.combine { inherit (texlive) scheme-medium
      standalone glossaries glossaries-extra newtx xstring multirow enumitem hyphenat ifoddpage biblatex
      fontaxes pdfcomment datetime2 zref marginnote soulpos titlesec doi pgfplots relsize minted ;
    })
    (pkgs.python3.withPackages (ps: with ps; [
        beancount notebook pandas
        titlecase selenium bibtexparser # publications
        #vincenty folium numba
    ]))
    chromedriver
    jetbrains-mono meslo-lgs-nf noto-fonts noto-fonts-cjk noto-fonts-emoji
  ]) ++ ([pkgsPrev.activitywatch]);
  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];

  system.stateVersion = "23.05";
}
