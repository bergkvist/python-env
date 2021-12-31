{ pkgs ? (import <nixpkgs> {})
, python ? pkgs.python3
, nodejs ? pkgs.nodejs
, projectRoot
}:
let
  libraryPath = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc.lib ];
  pythonModules = "${toString projectRoot}/python_modules";
  pipPrefix = "${pythonModules}/pip";
  setupHook = ''
    export PIP_DISABLE_PIP_VERSION_CHECK=1
    export PIP_PREFIX="${pipPrefix}"
    export IPYTHONDIR="${pythonModules}/ipython"
    export JUPYTER_CONFIG_DIR="${pythonModules}/jupyter/config"
    export JUPYTER_DATA_DIR="${pythonModules}/jupyter/data"
    export JUPYTERLAB_DIR="${pythonModules}/jupyter/lab"
    export PYTHONPATH="${pipPrefix}/lib/${python.libPrefix}/site-packages"
    export LD_LIBRARY_PATH="${libraryPath}"
    export PATH="${pipPrefix}/bin"
  '';
  propagatedBuildInputs = builtins.concatStringsSep " " [
    python
    nodejs
    python.pkgs.pip
    python.pkgs.setuptools
    python.pkgs.wheel
    python.pkgs.pip-tools
  ];
in
pkgs.stdenv.mkDerivation rec {
  name = "${python.libPrefix}-environment";
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p "$out/nix-support"
    echo "${setupHook}" > "$out/nix-support/setup-hook"
    echo "${propagatedBuildInputs}" > "$out/nix-support/propagated-build-inputs"
  '';
}
