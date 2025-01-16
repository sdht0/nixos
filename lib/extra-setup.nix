{ config, pkgs, ... }:
let
  scriptDir = "/etc/extra-setup";
  script = pkgs.writeShellScriptBin "extra-setup" ''
    set -euo pipefail; shopt -s nullglob

    dir="${scriptDir}"
    [[ -d "$dir" ]] || { echo "Nothing to do in '$dir'"; exit 0; }
    cd "$dir"

    for module in *;do
      extra-setup-single "$module"
    done
  '';
  script2 = pkgs.writeShellScriptBin "extra-setup-single" ''
    set -euo pipefail; shopt -s nullglob

    module="$1"
    shift

    rundir="/var/cache/extra-setup-runs"
    [[ -d "$rundir" ]] || { sudo mkdir -pv "$rundir"; sudo chmod o+rwx "$rundir"; }

    [[ -f "$rundir/$module" ]] && echo "Done: $module" && exit 0
    echo "Running: $module"
    source "${scriptDir}/$module"
    toRun "$@"
    echo "Success: $module"
    touch "$rundir/$module"
  '';
in
{
  environment.systemPackages = [
    script
    script2
  ];
}
