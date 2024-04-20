{ lib
, fetchpatch
, rustPlatform
, fetchFromGitHub
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "difftastic";
  version = "0.57.0";

  src = fetchFromGitHub {
    owner = "wilfred";
    repo = pname;
    rev = version;
    hash = "sha256-APWwLf1Qw3h8U7sYQAq8IeQAgMW78An3VYSggZPMsfQ=";
  };

  cargoHash = "sha256-y2e1EV0q+bQaZc5i8ztBM6Ex1qIglVlTHZU373aY/Oc=";

  # skip flaky tests
  checkFlags = [
    "--skip=options::tests::test_detect_display_width"
  ];

  meta = with lib; {
    description = "A syntax-aware diff";
    homepage = "https://github.com/Wilfred/difftastic";
    changelog = "https://github.com/Wilfred/difftastic/blob/${version}/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ ethancedwards8 figsoda ];
    mainProgram = "difft";
  };
}
