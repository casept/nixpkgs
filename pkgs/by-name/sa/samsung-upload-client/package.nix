{
  lib,
  fetchFromGitHub,
  python3Packages,
  unstableGitUpdater,
}:

python3Packages.buildPythonApplication {
  pname = "samsung-upload-client";
  version = "0-unstable-2026-04-25";
  pyproject = false;

  src = fetchFromGitHub {
    owner = "bkerler";
    repo = "sboot_dump";
    rev = "8c9f6eb79ffbe702152ca7810f6382bf5e1bfd58";
    hash = "sha256-yGyY94uAvfOWOCDbMVMxMKVcKI77+JtyoDqy7KQoNBk=";
  };

  dependencies = with python3Packages; [ pyusb ];

  installPhase = ''
    runHook preInstall
    install -Dm755 samupload.py $out/bin/samupload
    runHook postInstall
  '';

  passthru.updateScript = unstableGitUpdater { };

  meta = {
    homepage = "https://github.com/bkerler/sboot_dump";
    description = "Tool to dump RAM using Samsung S-Boot Upload Mode";
    mainProgram = "samupload";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
    maintainers = with lib.maintainers; [ casept ];
  };
}
