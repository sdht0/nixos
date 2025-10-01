{
  lib,
  config,
  pkgs,
  hostData,
  ...
}:
let
  userMap_f = user: {
    users.${user.username} = {
      uid = user.uid or null;
      group = user.groupname or user.username;
      shell = user.shell or pkgs.zsh;
      extraGroups = [ "wheel" ];
      isNormalUser = true;
    };
    groups.${user.username}.gid = user.gid or null;
  };
  userFold_f = list: builtins.foldl' (final: l: lib.attrsets.recursiveUpdate final l) { } list;
in
{
  users = userFold_f (map userMap_f (lib.attrsets.attrValues hostData.users));
}
