{
  stdenv,
  python3,
  fetchFromGitLab
}:
stdenv.mkDerivation rec {
  pname = "monado-xr-hardware";
  version = "main-2023-12-17";

  src = fetchFromGitLab {
    domain = "gitlab.freedesktop.org";
    owner = "locochoco";
    repo = "xr-hardware";
    rev = "f6b51f768a30d489a2c52a59933025b2f2b55837";
    hash = "sha256-ltLMYT/B66X2ToUimaVcymXsNDUQGeqMqvPJ+FMs9Y4=";
  };
  buildInputs = [ stdenv python3 ];
  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/etc/udev/rules.d
    cp $src/70-xrhardware.rules $out/etc/udev/rules.d/70-xrhardware.rules
    chmod 644 $out/etc/udev/rules.d/70-xrhardware.rules
  '';

}
