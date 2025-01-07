{ config, lib, pkgs, hostData, inputs, ... }:
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

  myPythonPkgs = [
      "pandas"
      #vincenty folium numba
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
    libreoffice-qt
    obsidian
    ffmpeg vlc
    mcomix foliate
    activitywatch
    inputs.nixOlde.packages.${system}.nix-olde
    vscode rustup gnumake
    gcc temurin-bin-21
    # thunderbird
    # zoom-us slack
    # jetbrains-toolbox
    # drawio
    # zotero # no aarch64
    (python312.withPackages (ps: lib.attrsets.attrVals config.myPythonPkgs ps))
  ]);

  systemd.timers."backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "11:00";
      Unit = "backup.service";
    };
  };

  systemd.services."backup" = {
    path = with pkgs; [ coreutils gitFull openssh python312 ];
    script = ''
      set -eu

      exit=0

      cp ${home}/.mozilla/firefox/xkbrcpl0.default/places.sqlite ${home}/Downloads/Media/ff-places.sqlite && \
      python ${home}/Downloads/projects/notes/notes/+personal/scripts/ff-history.py ${home}/Downloads/Media/ff-places.sqlite && \
      cd ${home}/Downloads/projects/ff-history && \
      git add . && git commit -m "Update" || true

      cd ${home}/.config/dotfiles.safe &&
      git add . && git commit -m "update" || true

      # Network operations
      git -C ${home}/.config/dotfiles.safe push || exit=1
      git -C ${home}/Downloads/projects/ff-history push || exit=1
      ssh -o ForwardAgent=yes artimaeus@medialando.sdht.in \
        'git -C ${home}/.config/dotfiles.safe push && git -C /opt/mnt/xScripts push' || exit=1

      exit $exit
    '';
    serviceConfig = {
      Type = "oneshot";
      User = mainUser;
    };
    environment =  {
      SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
    };
  };

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
