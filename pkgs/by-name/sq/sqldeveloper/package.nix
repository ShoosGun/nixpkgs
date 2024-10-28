{ lib, stdenv, makeDesktopItem, makeWrapper, fetchzip, jdk17 }:

let
  version = "24.3.0.284.2209";

  desktopItem = makeDesktopItem {
    name = "sqldeveloper";
    exec = "sqldeveloper";
    icon = "sqldeveloper";
    desktopName = "Oracle SQL Developer";
    genericName = "Oracle SQL Developer";
    comment = "Oracle's Oracle DB GUI client";
    categories = [ "Development" ];
  };
in stdenv.mkDerivation {

  inherit version;
  pname = "sqldeveloper";

  src = fetchzip {
    url =
      "https://download.oracle.com/otn_software/java/sqldeveloper/sqldeveloper-${version}-no-jre.zip";
    hash = "sha256-iW7M760niqO2jiqJjhD2xJDN/Imd3yiy2seRfuqoKvo=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/libexec $out/share/{applications,pixmaps}
    mv * $out/libexec/

    mv $out/libexec/icon.png $out/share/pixmaps/sqldeveloper.png
    cp ${desktopItem}/share/applications/* $out/share/applications

    makeWrapper $out/libexec/sqldeveloper/bin/sqldeveloper $out/bin/sqldeveloper \
      --set JAVA_HOME ${jdk17.home} \
      --chdir "$out/libexec/sqldeveloper/bin"
  '';

  meta = with lib; {
    description = "Oracle's Oracle DB GUI client";
    longDescription = ''
      Oracle SQL Developer is a free integrated development environment that
      simplifies the development and management of Oracle Database in both
      traditional and Cloud deployments. SQL Developer offers complete
      end-to-end development of your PL/SQL applications, a worksheet for
      running queries and scripts, a DBA console for managing the database,
      a reports interface, a complete data modeling solution, and a migration
      platform for moving your 3rd party databases to Oracle.
    '';
    homepage =
      "http://www.oracle.com/technetwork/developer-tools/sql-developer/overview/";
    license = licenses.unfreeRedistributable;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ardumont ];
  };
}
