{ config, pkgs, ... }:

{
  hardware.logitech.wireless.enable = true;

  # nixpkgs.overlays = [(final: prev: {
  #   solaar-mod = prev.solaar.overrideAttrs (old: {
  #     name = "solaar-mod-${old.version}";
  #     postFixup = ''
  #       sed -i 's/Exec=solaar/Exec=solaar --window hide/' $out/share/applications/solaar.desktop
  #     '';
  #   });
  # })];
  environment.systemPackages = with pkgs; [ solaar ];
}
