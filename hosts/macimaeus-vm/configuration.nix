{ config, lib, pkgs, hostData, inputs, ... }:
let
  hostname = hostData.hostname;
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
      OnCalendar = "15,22:00";
      Unit = "backup.service";
    };
  };

  systemd.services."backup" = {
    path = with pkgs; [
      coreutils sqlite gitFull openssh curl rsync
      (python312.withPackages (ps: lib.attrsets.attrVals config.myPythonPkgs ps))
    ];
    script = ''
      set -eu

      exit=0

      scripts_dir="${home}/Downloads/projects/notes/notes/+personal/scripts"
      ff_tmp_path="/tmp/ff.db"
      aw_tmp_path="/tmp/aw.db"
      out_dir=${home}/.local/share/personal-data

      echo "ff..."
      cd "$out_dir" && \
      cp ${home}/.mozilla/firefox/*.default/places.sqlite "$ff_tmp_path" && \
      python \
        $scripts_dir/ff-history.py \
        "$ff_tmp_path" "$out_dir/firefox/history" && \
      python \
        $scripts_dir/ff-bookmarks.py \
        "$ff_tmp_path" "$out_dir/firefox/bookmarks.txt" || exit=1
      f="$out_dir/firefox/places.sql"
        sqlite3 "$ff_tmp_path" ".dump" > "$f.tmp" && mv "$f.tmp" "$f" || exit=1

      echo "aw..."
      cd "$out_dir" && \
      cp ${home}/.local/share/activitywatch/aw-server-rust/sqlite.db "$aw_tmp_path" && \
      python \
        $scripts_dir/aw-db.py \
        "${hostname}" "$out_dir/activitywatch/history" || exit=1
      f="$out_dir/activitywatch/${hostname}.buckets.json"
        python $scripts_dir/aw-bucket.py "$f.tmp" && mv "$f.tmp" "$f" || exit=1
      f="$out_dir/activitywatch/server-db.sql"
        sqlite3 "$aw_tmp_path" ".dump" > "$f.tmp" && mv "$f.tmp" "$f" || exit=1

      echo "rsync..."
      rsync -a --delete --exclude '*.tmp' \
        artimaeus@medialando.sdht.in:/opt/mnt/syncs/Devices/samimaeus/Collected/gps/ \
        "$out_dir/gps/" || exit=1
      rsync -a --delete --exclude '*.tmp' \
        artimaeus@medialando.sdht.in:/opt/mnt/syncs/Devices/samimaeus/Collected/periodical/ \
        "$out_dir/periodical/" || exit=1

      echo "git..."
      cd "$out_dir" && \
        { git add . && git commit --quiet -m "update" || true; } && git push --quiet || exit=1
      cd "${home}/.config/dotfiles.safe" && \
        { git add . && git commit --quiet -m "update" || true; } && git push --quiet || exit=1

      echo "ssh..."
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
