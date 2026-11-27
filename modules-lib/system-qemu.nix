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
      ExecStart =
        let
          bridgeScript = pkgs.writeShellScript "wayland-clipboard-bridge-sync" ''
            set -u
            wl_paste="${pkgs.wl-clipboard}/bin/wl-paste"
            xclip="${pkgs.xclip}/bin/xclip"
            grep="${pkgs.gnugrep}/bin/grep"
            cmp="${pkgs.diffutils}/bin/cmp"

            types=$("$wl_paste" -l 2>/dev/null) || exit 0
            [ -n "$types" ] || exit 0

            wl_type=""
            x_target=""

            for t in image/png image/jpeg image/bmp image/tiff; do
              if printf '%s\n' "$types" | "$grep" -qxF "$t"; then
                wl_type="$t"
                x_target="$t"
                break
              fi
            done

            if [ -z "$wl_type" ]; then
              for t in "text/plain;charset=utf-8" "text/plain;charset=UTF-8" "UTF8_STRING" "text/plain"; do
                if printf '%s\n' "$types" | "$grep" -qxF "$t"; then
                  wl_type="$t"
                  x_target="UTF8_STRING"
                  break
                fi
              done
            fi

            [ -n "$wl_type" ] || exit 0

            tmp_wl=$(${pkgs.coreutils}/bin/mktemp)
            tmp_x=$(${pkgs.coreutils}/bin/mktemp)
            trap '${pkgs.coreutils}/bin/rm -f "$tmp_wl" "$tmp_x"' EXIT

            "$wl_paste" -n --type "$wl_type" > "$tmp_wl" 2>/dev/null || exit 0
            [ -s "$tmp_wl" ] || exit 0

            "$xclip" -selection clipboard -t "$x_target" -o > "$tmp_x" 2>/dev/null || true
            if ! "$cmp" -s "$tmp_wl" "$tmp_x"; then
              ${pkgs.coreutils}/bin/sleep 0.1
              "$xclip" -selection clipboard -t "$x_target" -i < "$tmp_wl" >/dev/null 2>&1
            fi
          '';
        in
        "${pkgs.wl-clipboard}/bin/wl-paste --watch ${bridgeScript}";
      Restart = "on-failure";
      RestartSec = "30";
    };
  };
}
