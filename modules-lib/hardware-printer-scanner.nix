{ pkgs, hostData, ... }:
{
  services.printing.enable = true;
  services.saned.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];
  users.users.${hostData.users.mainuser.username}.extraGroups = [
    "lp"
    "scanner"
  ];
  environment.systemPackages = with pkgs; [ simple-scan ];
}
