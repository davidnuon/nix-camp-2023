{
  description = "Nix Flake for nixcamp2023-Slides";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    nix2html-src.url = "github:davidnuon/nix2html/v0.0.3";
    revealJS-src.url = "github:hakimel/reveal.js/v4.6.0";
    slides = {
      self,
      nix2html-src,
    }:
      import ./slides {
        inherit nix2html-src;
      };
  };

  outputs = {
    self,
    nixpkgs,
    nix2html-src,
    revealJS-src,
    slides,
  }: {
    defaultPackage =
      nixpkgs.stdenv.mkDerivation rec {
      };
  };
}
