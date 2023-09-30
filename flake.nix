{
  description = "Nix Flake for nixcamp2023-Slides";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    nix2html-src.url = "github:davidnuon/nix2html/v0.0.3";
    nix2html-src.flake = false;
    revealJS-src.url = "github:hakimel/reveal.js";
    revealJS-src.flake = false;
    flake-compat.url = "github:edolstra/flake-compat";
    flake-compat.flake = false;
  };

  outputs = {
    self,
    nixpkgs,
    nix2html-src,
    revealJS-src,
    flake-compat,
  }: let
    nix2html = import nix2html-src {};
    revealJS = revealJS-src;

    slides = import ./slides {inherit nix2html;};
    fileContents = nix2html.render slides.slides;
  in {
    inherit fileContents;
    inherit revealJS;

    defaultPackage.x86_64-linux =
      # Notice the reference to nixpkgs here.
      with import nixpkgs {system = "x86_64-linux";};
        stdenv.mkDerivation {
          inherit revealJS fileContents;
          outputFile = writeText "index.html" self.fileContents;

          name = "nix-camp-slides";
          src = self;

          buildPhase = '''';
          installPhase = ''
            mkdir $out
            cp -r $revealJS/plugin $out
            cp $revealJS/dist/reset.css $out
            cp $revealJS/dist/reveal.css $out
            cp $revealJS/dist/reveal.js $out
            cp -R $revealJS/dist/theme $out/theme
            cp $outputFile $out/index.html
          '';
        };
  };
}
