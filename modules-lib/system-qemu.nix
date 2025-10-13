{ modulesPath, pkgs, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  systemd.user.services.spice-vdagent = {
    description = "spice-vdagent user daemon";
    after = [ "spice-vdagentd.service" "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
    };
    unitConfig = {
      ConditionPathExists = "/run/spice-vdagentd/spice-vdagent-sock";
    };
  };
}
