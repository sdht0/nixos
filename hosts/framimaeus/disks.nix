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
              content = {
                type = "filesystem";
                format = "vfat";
                label = "BOOT";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            ZFS = {
              size = "925G";
              type = "8300";
              content = {
                type = "zfs";
                pool = "zroot";
                label = "ZFS";
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
              content = {
                type = "filesystem";
                format = "vfat";
                label = "BOOTMIRROR";
              };
            };
            ZFSMIRROR = {
              size = "925G";
              type = "8300";
              content = {
                type = "zfs";
                pool = "zroot";
                label = "ZFSMIRROR";
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
          compression = "zstd";
          acltype = "posixacl";
          xattr = "sa";
            encryption = "aes-256-gcm";
            keyformat = "passphrase";
            keylocation = "file://${config.zfsKeyFile}";
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
