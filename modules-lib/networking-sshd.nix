{
  config,
  pkgs,
  hostData,
  ...
}:

{
  services.sshd.enable = true;
  services.openssh.settings = {
    PasswordAuthentication = false;
    PermitRootLogin = "no";
    X11Forwarding = true;
  };
  users.users.${hostData.users.mainuser.username}.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBKEvNaKu4pI+juLT91YpbON3ell6lQ8A+2rItGP2mUE artimaeus"
  ];
}
