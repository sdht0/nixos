{
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = (
    with pkgs;
    [
      rustup
      (jetbrains.rust-rover.overrideAttrs  (old: {
        postFixup = ''
          ${old.postFixup}
          patchelf --replace-needed libxml2.so.2 libxml2.so $out/rust-rover/bin/lldb/linux/*/lib/liblldb.so
        '';
      }))
    ]
  );
}
