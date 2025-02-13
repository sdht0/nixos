{
  lib,
  ...
}:
{
  config = {
    system.activationScripts.applications.text = lib.mkForce "";
  };
}
