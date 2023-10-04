{ config, lib, pkgs, ... }:
let
  keyFile = "root.luks.bin";
in
{
  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/579f8166-d13f-4128-abf7-a19d845bc82a";
    keyFile = "/${keyFile}";
  };
  boot.initrd.secrets = { "/${keyFile}" = /var/lib/secrets/${keyFile}; };

  # Allow systemd automount
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
}

/*

== Option 4: Copy key as file into the initrd (not recommended) ==
If you want to temporarily enable booting without having to enter a passphrase, you can copy the keyfile into the initrd itself.

Warning: This method is not recommended as anyone with physical access to your boot partition will be able to retrieve the key file and use it to decrypt your luks partition. Make sure you eventually remove the generated initrd when automatic booting is no longer needed.

First move the key to a safe location.
<syntaxhighlight lang="bash">
# mkdir /var/lib/secrets
# chown root:root /var/lib/secrets
# chmod 700 /var/lib/secrets
# mv -v hdd.key /var/lib/secrets/
# chmod 600 /var/lib/secrets/hdd.key
</syntaxhighlight>

Then add the key to the initrd.
<syntaxhighlight lang="nix">
let
  keyFile = "hdd.key";
in
{
  boot.initrd.luks.devices."root" = {
    device = "/dev/disk/by-uuid/<uuid>";
    keyFile = "/${keyFile}";
  };
  boot.initrd.secrets = { "/${keyFile}" = /var/lib/secrets/${keyFile}; };
}
</syntaxhighlight>

*/
