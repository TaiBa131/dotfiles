{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "mutt-wizard-10-02-2020";

  src = fetchFromGitHub {
    owner = "lukesmithxyz";
    repo = "mutt-wizard";
    rev = "d8f57b57f6e4f7d07969a26775686b45b0e2b565";
    sha256 = "1nd1bnak4y9k0yzjllqqi65rlfkqy5v6zb24yphdlpgn61igyjp6";
  };

  patchPhase = ''
    substituteInPlace ./bin/mw \
      --replace /usr/local $out \
      --replace "prefix/share/mutt-wizard" "prefix/share"
    substituteInPlace ./share/mutt-wizard.muttrc \
      --replace "share/mutt-wizard/mailcap" "share/mailcap" \
      --replace /usr/local $out
  '';

  dontBuild = true;

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share
    mkdir -p $out/man
    cp -r bin/* $out/bin/
    cp -r share/* $out/share
    cp mw.1 $out/man/
  '';
}
