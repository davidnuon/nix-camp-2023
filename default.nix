{pkgs ? import <nixpkgs> {}}: let
  nix2html = import (fetchTarball {
    url = "https://github.com/davidnuon/nix2html/archive/refs/tags/v0.0.2.tar.gz";
  }) {};
  revealJS = fetchTarball {
    url = "https://github.com/hakimel/reveal.js/archive/refs/tags/4.6.0.tar.gz";
  };
  slides = import ./slides {inherit nix2html;};
in
  pkgs.stdenv.mkDerivation rec {
    inherit revealJS;

    name = "nixcamp2023-Slides";
    unpackPhase = "true";

    buildPhase = '''';

    fileContents = with nix2html;
      render slides.slides;

    outputFile = pkgs.writeText "index.html" fileContents;

    installPhase = ''
      mkdir $out
      cp $revealJS/dist/reset.css $out
      cp $revealJS/dist/reveal.css $out
      cp $revealJS/dist/reveal.js $out
      cp $outputFile $out/index.html
    '';
  }
