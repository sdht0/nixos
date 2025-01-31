{
  lib,
  config,
  pkgs,
  hostData,
  ...
}:
let
  f_userMap = user: {
    users.${user.username} = {
      uid = user.uid or null;
      group = user.groupname or user.username;
      shell = user.shell or pkgs.zsh;
      extraGroups = [ "wheel" ];
      isNormalUser = true;
    };
    groups.${user.username}.gid = user.gid or null;
  };
  f_userFold = list: builtins.foldl' (final: l: lib.attrsets.recursiveUpdate final l) { } list;
in
{
  users = f_userFold (map f_userMap (lib.attrsets.attrValues hostData.users));
}
