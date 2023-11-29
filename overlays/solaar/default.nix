{ config, pkgs, ... }:

(final: prev: {
  solaar-overlay = prev.solaar.overrideAttrs (old: {
    postFixup = ''
      ${old.postFixup}
      sed -i 's/Exec=solaar/Exec=solaar --window hide/' $out/share/applications/solaar.desktop
    '';
  });
})
