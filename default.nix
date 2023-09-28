{pkgs ? import <nixpkgs> {}}: let
  nix2html = import (fetchTarball {
    url = "https://github.com/davidnuon/nix2html/archive/refs/tags/v0.0.2.tar.gz";
  }) {};
in
  pkgs.stdenv.mkDerivation rec {
    name = "inspect";
    unpackPhase = "true";

    buildPhase = '''';

    fileContents = with nix2html;
      render (html {
        children = [
          (head
            {})
          (body
            {
              children = [
              ];
            })
        ];
      });

    outputFile = pkgs.writeText "index.html" fileContents;

    installPhase = ''
      mkdir $out
      cp $outputFile $out/index.html
    '';
  }
