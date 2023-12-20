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
    rev = "0e4cddf7b9df611a75afb9969280e7b1d8bb55e2";
    hash = "sha256-BZfkU+I0IPvWsPeZ7Z5fhAl2GugEhdpy1fEHZByuK7s=";
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
