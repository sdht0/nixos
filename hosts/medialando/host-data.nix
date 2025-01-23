{
  system = "x86_64-linux";
  timezone = "America/Toronto";
  locale = "en_US.UTF-8";
  users = {
    mainuser = rec {
      username = "artimaeus";
      uid = 1000;
      gid = uid;
    };
  };
}
