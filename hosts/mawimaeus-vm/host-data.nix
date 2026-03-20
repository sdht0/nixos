rec {
  system = "aarch64-linux";
  timezone = "America/Toronto";
  locale = "en_CA.UTF-8";
  hostId = "3eb4f87f";
  users = {
    mainuser = rec {
      username = "artimaeus";
      uid = 1000;
      gid = uid;
    };
  };
  disk1 = "/dev/vda";
  disk2 = "/dev/vdb";
  zfsKeyDir = "/var/lib/secrets";
  zfsKeyFile = "${zfsKeyDir}/zroot.key";
}
