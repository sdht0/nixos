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
      # Use the direct path to the binaries to avoid PATH issues in systemd
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text/plain --watch ${pkgs.xclip}/bin/xclip -selection clipboard";
      Restart = "on-failure";
      RestartSec = "2";
    };
  };
}
