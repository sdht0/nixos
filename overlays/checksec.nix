{
  lib,
  fetchFromGitHub,

  buildGoModule,

  # tests
  testers,
  checksec,
}:

buildGoModule rec {
  pname = "checksec";
  version = "3.0.2";

  src = fetchFromGitHub {
    owner = "slimm609";
    repo = "checksec.sh";
    rev = version;
    hash = "sha256-ZpDowTmnK23+ZocOY1pJMgMSn7FiQQGvMg/gSbiL1nw=";
  };

  vendorHash = "sha256-7poHsEsRATljkqtfGxzqUbqhwSjVmiao2KoMVQ8LkD4=";

  passthru.tests = {
    version = testers.testVersion {
      package = checksec;
      version = "v${version}";
    };
  };

  meta = with lib; {
    description = "Tool for checking security bits on executables";
    mainProgram = "checksec";
    homepage = "https://slimm609.github.io/checksec/";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = with maintainers; [
      thoughtpolice
      globin
      sdht0
    ];
  };
}
