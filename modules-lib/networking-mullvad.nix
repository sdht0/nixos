{
  lib,
  lib',
  config,
  pkgs,
  ...
}:
let
  nftExe = "${pkgs.nftables}/bin/nft";
in
{
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  systemd.services.mullvad-daemon.environment = {
    TALPID_NET_CLS_MOUNT_DIR = "/run/net_cls";
  };

  # Make mullvad play well with tailscale
  systemd.services.mullvad-daemon = {
    preStart = ''
      ${nftExe} -f '${./files/mullvad-ts.nft}'
    '';
    postStop = ''
      ${nftExe} -f '${./files/mullvad-ts-cleanup.nft}'
    '';
  };

  environment.etc = lib'.deepMerge_f [
    (lib'.extraScript_f "mullvadLogin" ''
      mullvad account login
    '')
    (lib'.extraScript_f "mullvadSetupRelay" ''
      mullvad relay set location "$@"
    '')
    (lib'.extraScript_f "mullvadSetup" ''
      mullvad relay set tunnel-protocol wireguard
      mullvad auto-connect set on
      mullvad lan set allow
      mullvad lockdown-mode set on
    '')
  ];
}
