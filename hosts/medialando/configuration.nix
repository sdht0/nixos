{
  config,
  lib,
  pkgs,
  hostData,
  ...
}:
let
  keyFile = "root.luks.bin";
in
{
  imports = [
    ../../modules/option-python.nix

    ../../modules/system-nix-common.nix
    ../../modules/system-nix-linux.nix

    ../../modules/hardware-firmware.nix
    ../../modules/hardware-intel.nix
    ../../modules/hardware-ssd.nix

    ../../modules/system-basic.nix
    ../../modules/system-users.nix
    ../../modules/system-audio.nix
    ../../modules/system-zfs.nix
    ../../modules/system-systemd-boot.nix
    ../../modules/system-initrd-systemd.nix
    ../../modules/system-watchdog-disable.nix

    ../../modules/networking-networkmanager.nix
    ../../modules/networking-mullvad.nix
    ../../modules/networking-sshd.nix
    ../../modules/networking-tailscale.nix
    ../../modules/networking-letsencrypt.nix

    ../../modules/pkgs-common.nix
    ../../modules/pkgs-docker.nix
    ../../modules/pkgs-syncthing.nix
  ];

  environment.systemPackages = with pkgs; [
    rclone
    getmail6
  ];

  systemd.timers."mullvad-reset" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "30m";
      OnUnitActiveSec = "30m";
      Unit = "mullvad-reset.service";
    };
  };

  systemd.services."mullvad-reset" = {
    path = with pkgs; [
      mullvad
      systemd
      coreutils
      gnugrep
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/mullvad-reset.sh";
      User = "root";
    };
  };

  systemd.timers."backup-root" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "16:00";
      Unit = "backup-root.service";
    };
  };

  systemd.services."backup-root" = {
    path = with pkgs; [
      bash
      coreutils
      gnutar
      gnupg
      zstd
      gitFull
      rclone
      getmail6
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/backup-gitea.sh";
      User = "root";
    };
  };

  systemd.timers."backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "11:00";
      Unit = "backup.service";
    };
  };

  systemd.services."backup" = {
    path = with pkgs; [
      coreutils
      gawk
      gitFull
      rclone
      getmail6
    ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash /opt/mnt/xScripts/system/backup.sh";
      User = hostData.users.mainuser.username;
    };
  };

  # boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "usb_storage"
    "sd_mod"
  ];

  services.logind.lidSwitch = "ignore";

  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/579f8166-d13f-4128-abf7-a19d845bc82a";
    keyFile = "/${keyFile}";
  };
  boot.initrd.secrets = {
    "/${keyFile}" = /var/lib/secrets/${keyFile};
  };
  ### Commented out to allow systemd automount ###
  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/D935-10CE";
  #     fsType = "vfat";
  #   };
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/6773e347-eee3-4078-980d-542ef28b9c4e";
    fsType = "btrfs";
    options = [
      "subvol=@nixos"
      "compress=zstd"
      "noatime"
    ];
  };
  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/6773e347-eee3-4078-980d-542ef28b9c4e";
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
