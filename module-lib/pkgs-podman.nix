{
  config,
  pkgs,
  hostData,
  ...
}:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    autoPrune.enable = true;
  };
  environment.systemPackages = (with pkgs; [ docker-compose ]);
  users.users.${hostData.users.mainuser.username}.extraGroups = [ "podman" ];
}
