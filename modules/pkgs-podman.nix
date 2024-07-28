{ config, pkgs, ... }:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
    autoPrune.enable = true;
  };
  environment.systemPackages = (with pkgs; [
    docker-compose
  ]);
}
