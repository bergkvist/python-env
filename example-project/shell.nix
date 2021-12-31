{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/33da2dcc496668974369e15667db2c47e2dde6b7.tar.gz") {}
, python-env ? pkgs.callPackage (fetchTarball "https://github.com/bergkvist/python-env/archive/bcbc415905b63284ae4aaced652a40beab475d42.tar.gz")
}:

pkgs.mkShell {
  buildInputs = [
    (python-env { projectRoot = ./.; python = pkgs.python38; })
  ];
}
