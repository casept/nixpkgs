{ lib
, stdenv
, fetchFromGitHub
, python3
}:

stdenv.mkDerivation
{
  pname = "samsung-upload-client";
  version = "2023-06-11";

  src = fetchFromGitHub {
    owner = "bkerler";
    repo = "sboot_dump";
    rev = "3abc2cfd4c7d89c382122e65f0c8ad9bdb9116e4";
    sha256 = "sha256-8pKYHuHNKP7idJCHKElwg5Byvb55grrJQAt84eniTuM=";
  };

  installPhase = ''
    runHook preInstall
    install -Dm755 samupload.py $out/bin/samupload
    runHook postInstall
  '';

  propagatedBuildInputs = [
    (python3.withPackages (pythonPackages: with pythonPackages; [ pyusb ]))
  ];

  meta = with lib;
    {
      homepage = "https://github.com/bkerler/sboot_dump";
      description = "SUC - A tool to dump RAM using Samsung S-Boot Upload Mode ";
      license = licenses.mit;
      platforms = platforms.all;
      mainProgram = "samupload";
    };
}
