let
  config = import ./host-data.nix;
in
{
  disko.devices = {
    disk = {
      disk1 = {
        type = "disk";
        device = config.disk1;
        content = {
          type = "gpt";
          partitions = {
            BOOT = {
              size = "2G";
              type = "EF00";
              label = "BOOT";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
                extraArgs = ["-n" "BOOT"];
              };
            };
            ZFS = {
              size = "925G";
              type = "8300";
              label = "ZFS";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
      disk2 = {
        type = "disk";
        device = config.disk2;
        content = {
          type = "gpt";
          partitions = {
            BOOTMIRROR = {
              size = "2G";
              type = "8300";
              label = "BOOTMIRROR";
              content = {
                type = "filesystem";
                format = "vfat";
                extraArgs = ["-n" "BOOTMIRROR"];
              };
            };
            ZFSMIRROR = {
              size = "925G";
              type = "8300";
              label = "ZFSMIRROR";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        mode = "mirror";
        rootFsOptions = {
          mountpoint = "none";
          canmount = "off";
          devices = "off";
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
          dnodesize = "auto";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "file://${config.zfsKeyFile}";
          atime = "off";
        };
        options.ashift = "12";
        datasets = {
          "nixos" = {
            type = "zfs_fs";
            options.mountpoint = "/";
            mountpoint = "/";
          };
          "home" = {
            type = "zfs_fs";
            options.mountpoint = "/home";
            mountpoint = "/home";
          };
        };
      };
    };
  };
}
