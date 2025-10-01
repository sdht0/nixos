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
                mountpoint = "/boot";
              };
            };
            LINUX = {
              size = "925G";
              type = "8300";
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
              content = {
                type = "filesystem";
                format = "vfat";
              };
            };
            LINUX = {
              size = "925G";
              type = "8300";
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
          };
          "home" = {
            type = "zfs_fs";
            options.mountpoint = "/home";
          };
        };
      };
    };
  };
}
