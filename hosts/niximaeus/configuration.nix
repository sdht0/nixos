{
  config,
  lib,
  pkgs,
  hostData,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/system-nix-common.nix
    ../../modules/system-nix-linux.nix

    ../../modules/hardware-firmware.nix
    ../../modules/hardware-intel.nix
    ../../modules/hardware-nvidia-disable.nix
    ../../modules/hardware-ssd.nix
    ../../modules/hardware-fingerprintreader.nix
    ../../modules/hardware-canon-ts3420.nix
    ../../modules/hardware-logitech.nix

    ../../modules/system-basic.nix
    ../../modules/system-users.nix
    ../../modules/system-users-autologin.nix
    ../../modules/system-btrfs-home-snapshots.nix
    ../../modules/system-audio.nix
    ../../modules/system-bluetooth.nix
    ../../modules/system-plasma6.nix
    ../../modules/system-plymouth.nix
    ../../modules/system-systemd-boot.nix
    ../../modules/system-systemd-boot-xbootldr.nix
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
    ../../modules/pkgs-latex.nix
    ../../modules/pkgs-nixdev.nix
    ../../modules/pkgs-debuginfod.nix
    ../../modules/pkgs-script-publications.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "thunderbolt"
    "nvme"
    "usbhid"
    "sdhci_pci"
  ];

  environment.systemPackages = (
    with pkgs;
    [
      firefox
      (chromium.override {
        enableWideVine = true;
        commandLineArgs = [
          "--enable-features=VaapiVideoEncoder,VaapiVideoDecodeLinuxGL"
          "--ignore-gpu-blocklist"
          "--enable-zero-copy"
        ];
      })
      thunderbird
      zotero
      libreoffice-qt-fresh
      ffmpeg
      vlc
      mcomix
      foliate
      zoom-us
      slack
      obsidian
      fava
      activitywatch
      inputs.nixOlde.packages.${pkgs.system}.nix-olde
      jetbrains-toolbox
      vscode
      gcc
      lldb
      temurin-bin-21
      gnumake
      drawio
      (pkgs.python312.withPackages (
        ps: with ps; [
          beancount
          notebook
          pandas
          #vincenty folium numba
        ]
      ))
    ]
  );

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/9efed530-afe0-4ef8-aee4-24910d168a34";
  ### Commented out to allow systemd automount ###
  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/57D4-A2B2";
  #     fsType = "vfat";
  #   };
  # fileSystems."/efi" =
  #   { device = "/dev/disk/by-uuid/3280-5418";
  #     fsType = "vfat";
  #   };
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/06b5ee16-a040-465d-9e58-df9bc6c7329c";
    fsType = "btrfs";
    options = [
      "subvol=@nixos"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/06b5ee16-a040-465d-9e58-df9bc6c7329c";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd"
      "noatime"
    ];
  };
  swapDevices = [ ];

  system.stateVersion = "23.05";
}
