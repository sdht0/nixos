rec {
  system = "x86_64-linux";
  timezone = "America/Toronto";
  locale = "en_US.UTF-8";
  hostId = "f0a79e1a";
  users = {
    mainuser = rec {
      username = "artimaeus";
      uid = 1000;
      gid = uid;
    };
  };
  disk = "/dev/nvme0n1";
  secretsDir = "/var/lib/secrets";
  zfsKeyFile = "${secretsDir}/zroot.key";
  cloudflareKeyFile = "${secretsDir}/cloudflare.key";
}
