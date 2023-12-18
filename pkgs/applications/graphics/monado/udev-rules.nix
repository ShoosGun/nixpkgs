{
  stdenv,
  python,
  make,
  fetchFromGitLab
}:
stdenv.mkDerivation rec {
  pname = "monado-xr-hardware";
  version = "main-2023-12-17";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "monado";
    repo = "xr-hardware";
    rev = "9204de323210d2a5ab8635c2ee52127100de67b1";
    hash = "";
  };
  buildInputs = [ make python ];
  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/etc/udev/rules.d
    cp $src/70-xrhardware.rules $out/etc/udev/rules.d/70-xrhardware.rules
    chmod 644 $out/etc/udev/rules.d/70-xrhardware.rules
  '';

}
