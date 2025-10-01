rec {
  system = "x86_64-linux";
  timezone = "America/Toronto";
  locale = "en_CA.UTF-8";
  users = {
    mainuser = rec {
      username = "artimaeus";
      uid = 1000;
      gid = uid;
    };
  };
  disk1 = "/dev/nvme0n1";
  disk2 = "/dev/nvme1n1";
  zfsKeyDir = "/var/lib/secrets";
  zfsKeyFile = "${zfsKeyDir}/zroot.key";
}