{
  hostData,
  ...
}:
{
  systemd.tmpfiles.rules = [
    "d ${hostData.secretsDir} 0700 root root -"
    "f ${hostData.zfsKeyFile} 0400 root root -"
    "f ${hostData.cloudflareKeyFile} 0400 root root -"
    "f ${hostData.secretsDir}/try.key 0400 root root -"
    "f ${hostData.secretsDir}/doe.key 0400 root root -"
  ];
}
