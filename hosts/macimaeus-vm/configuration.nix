{
  config,
  lib,
  pkgs,
  hostData,
  inputs,
  ...
}:
let
  mainUser = hostData.users.mainuser.username;
  home = "/home/${hostData.users.mainuser.username}";
in
{
  imports = [
    ../../modules/option-python.nix

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
    ../../modules/pkgs-nixdev.nix
    ../../modules/pkgs-debuginfod.nix

    ../../modules/pkgs-beancount.nix
    ../../modules/pkgs-publications.nix
    # ../../modules/pkgs-latex.nix
  ];

  myPythonVer = pkgs.python312;
  myPythonPkgs = [
    "pandas"
    #vincenty folium numba
  ];

  environment.systemPackages = (
    with pkgs;
    [
      firefox
      (chromium.override {
        enableWideVine = false;
        # commandLineArgs = [
        #   "--enable-features=VaapiVideoEncoder,VaapiVideoDecodeLinuxGL"
        #   "--ignore-gpu-blocklist"
        #   "--enable-zero-copy"
        # ];
      })
      libreoffice-qt
      obsidian
      ffmpeg
      vlc
      mcomix
      foliate
      activitywatch
      inputs.nixOlde.packages.${system}.nix-olde
      vscode
      rustup
      gnumake
      gcc
      temurin-bin-21
      # thunderbird
      # zoom-us slack
      # jetbrains-toolbox
      # drawio
      # zotero # no aarch64
      config.myPythonSet
    ]
  );

  systemd.timers."backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "11,15,22:00";
      Unit = "backup.service";
    };
  };

  systemd.services."backup" = {
    path = with pkgs; [
      coreutils
      sqlite
      gitFull
      openssh
      curl
      rsync
      nettools
      config.myPythonSet
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash ${home}/.config/dotfiles.safe/scripts/backup.sh";
      User = mainUser;
    };
    environment = {
      SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "uhci_hcd"
    "virtio_pci"
    "usbhid"
    "usb_storage"
    "sr_mod"
  ];

  ### Commented out to allow systemd automount ###
  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-label/BOOT";
  #     fsType = "vfat";
  #     options = [ "fmask=0022" "dmask=0022" ];
  #   };
  fileSystems."/" = {
    device = "/dev/disk/by-label/LINUX";
    fsType = "btrfs";
    options = [
      "subvol=@nixos"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-label/LINUX";
    fsType = "btrfs";
    options = [
      "subvol=@home"
      "compress=zstd"
      "noatime"
    ];
  };

  system.stateVersion = "24.05";
}
