{ config, lib, pkgs, hostData, inputs, ... }:
{
  imports = [
    ../../modules/system-nix-common.nix
    ../../modules/system-nix-linux.nix

    ../../modules/hardware-firmware.nix

    ../../modules/system-qemu.nix
    ../../modules/system-basic.nix
    ../../modules/system-users.nix
    ../../modules/system-users-autologin.nix
    ../../modules/system-btrfs-home-snapshots.nix
    ../../modules/system-audio.nix
    ../../modules/system-plasma6.nix
    ../../modules/system-systemd-boot.nix
    ../../modules/system-initrd-systemd.nix
    ../../modules/system-watchdog-disable.nix
    ../../modules/system-oom.nix

    ../../modules/networking-networkmanager.nix
    ../../modules/networking-mullvad.nix
    ../../modules/networking-tailscale.nix

    ../../modules/pkgs-common.nix
    ../../modules/pkgs-podman.nix
    ../../modules/pkgs-syncthing.nix
    ../../modules/pkgs-sshagent.nix
    ../../modules/pkgs-fonts.nix
    # ../../modules/pkgs-latex.nix
    ../../modules/pkgs-nixdev.nix
    ../../modules/pkgs-debuginfod.nix
  ];

  environment.systemPackages = (with pkgs; [
    firefox
    (chromium.override {
      enableWideVine = false;
      # commandLineArgs = [
      #   "--enable-features=VaapiVideoEncoder,VaapiVideoDecodeLinuxGL"
      #   "--ignore-gpu-blocklist"
      #   "--enable-zero-copy"
      # ];
    })
    thunderbird
    libreoffice-qt
    # zotero
    ffmpeg vlc
    # mcomix
    foliate
    # zoom-us slack
    obsidian
    fava
    activitywatch
    inputs.nixOlde.packages.${pkgs.system}.nix-olde
    # jetbrains-toolbox
    vscode
    gcc lldb temurin-bin-21
    gnumake
    rustup
    #drawio
    chromedriver
    sqlite
    (pkgs.python312.withPackages (ps: with ps; [
        beancount notebook pandas
        notebook titlecase selenium bibtexparser
        #vincenty folium numba
    ]))
  ]);

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [ "xhci_pci" "uhci_hcd" "virtio_pci" "usbhid" "usb_storage" "sr_mod" ];

  ### Commented out to allow systemd automount ###
  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-label/BOOT";
  #     fsType = "vfat";
  #     options = [ "fmask=0022" "dmask=0022" ];
  #   };
  fileSystems."/" =
    { device = "/dev/disk/by-label/LINUX";
      fsType = "btrfs";
      options = [ "subvol=@nixos" "compress=zstd" "noatime" ];
    };
  fileSystems."/home" =
    { device = "/dev/disk/by-label/LINUX";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };

  system.stateVersion = "24.05";
}
