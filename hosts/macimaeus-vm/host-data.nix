{
  system = "aarch64-linux";
  timezone = "America/Toronto";
  locale = "en_CA.UTF-8";
  users = {
    mainuser = rec {
      username = "artimaeus";
      uid = 1000;
      gid = uid;
    };
  };
}
