{ modulesPath, pkgs, ... }:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  systemd.user.services.spice-vdagent = {
    description = "spice-vdagent user daemon";
    after = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.spice-vdagent}/bin/spice-vdagent -x";
      Restart = "on-failure";
      RestartSec = "30";
    };
    unitConfig = {
      ConditionPathExists = "/run/spice-vdagentd/spice-vdagent-sock";
    };
  };

  systemd.user.services.wayland-clipboard-bridge = {
    description = "Bridge Wayland clipboard to X11 for spice-vdagent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste -n --type text/plain --watch ${pkgs.bash}/bin/bash -c 'w=$(${pkgs.wl-clipboard}/bin/wl-paste -n 2>/dev/null); x=$(${pkgs.xsel}/bin/xsel -b -o 2>/dev/null); [ -n \"$w\" ] && [ \"$w\" != \"$x\" ] && sleep 0.1 && echo -n \"$w\" | ${pkgs.xsel}/bin/xsel -b -i'";
      Restart = "on-failure";
      RestartSec = "30";
    };
  };
}
