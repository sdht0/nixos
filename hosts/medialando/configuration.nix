{ config, lib, pkgs, hostData, ... }:
let
  keyFile = "root.luks.bin";
in
{
  imports = [
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
    chromium yt-dlp deno
    rclone getmail6
    (pkgs.python3.withPackages (ps: with ps;
      [ pip beautifulsoup4 dateutil lxml ])
    )
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
    path = with pkgs; [ mullvad systemd coreutils gnugrep ];
    script = ''
      set -eu

      mullvad status | grep -qi connected && exit 0;

      echo "Reconnecting mullvad"
      mullvad reconnect;
      sleep 10
      mullvad status | grep -qi connected && { echo "OK"; exit 0; }

      echo "Restarting network"
      systemctl restart NetworkManager
      sleep 10
      systemctl restart mullvad-daemon
      sleep 10
      mullvad status | grep -qi connected && { echo "OKK"; exit 0; } || echo "Oops"
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };

  systemd.timers."backup" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "10,7:00";
      Unit = "backup.service";
    };
  };

  systemd.services."backup" = {
    path = with pkgs; [ coreutils gitFull rclone getmail6 ];
    script = ''
      set -eu

      cd /home/artimaeus/.config/dotfiles.safe && git add . && git commit -m "update"

      cd /opt/mnt/xScripts
      git add download.sh system *.sh *.ipynb *py singlefilejs Music single-file-cli && git commit -m "Code" || true
      git add . && git commit -m "Archive" || true

      if [[ -d /opt/mnt/backups/takeouts/ ]];then
        getmail --quiet \
          --getmaildir /opt/mnt/backups/takeouts/email/fastmail/getmail \
          --rcfile /opt/mnt/backups/takeouts/email/fastmail/getmailrc

        getmail --quiet \
          --getmaildir /opt/mnt/backups/takeouts/email/gmail/getmail \
          --rcfile /opt/mnt/backups/takeouts/email/gmail/getmailrc

        rclone sync --fast-list \
          --config /opt/mnt/backups/takeouts/myfiles/Saved-Files/logins-2fa-backup/rclone.conf \
          gdrive: /opt/mnt/backups/takeouts/google/drive/
      fi
    '';
    serviceConfig = {
      Type = "oneshot";
      User = hostData.users.mainuser.username;
    };
  };

  # boot.kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
  boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];

  services.logind.lidSwitch = "ignore";

  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/579f8166-d13f-4128-abf7-a19d845bc82a";
    keyFile = "/${keyFile}";
  };
  boot.initrd.secrets = { "/${keyFile}" = /var/lib/secrets/${keyFile}; };
  ### Commented out to allow systemd automount ###
  # fileSystems."/boot" =
  #   { device = "/dev/disk/by-uuid/D935-10CE";
  #     fsType = "vfat";
  #   };
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6773e347-eee3-4078-980d-542ef28b9c4e";
      fsType = "btrfs";
      options = [ "subvol=@nixos" "compress=zstd" "noatime" ];
    };
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/6773e347-eee3-4078-980d-542ef28b9c4e";
      fsType = "btrfs";
      options = [ "subvol=@home" "compress=zstd" "noatime" ];
    };
  swapDevices = [ ];

  system.stateVersion = "23.05";
}
