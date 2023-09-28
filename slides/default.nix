{nix2html}: let
  components = import ./components {inherit nix2html;};
  pt = with components;
  with nix2html;
    t:
      p {
        children = [
          (plainText t)
        ];
      };
in
  with components; {
    slides = document {
      pageTitle = "Nix Camp 2023";
      children = [
        (pt "this is the first")
        (pt "this is the second")
        (pt "this is the third")
      ];
      scripts = [
        "./reveal.js"
      ];
      stylesheets = [
        "./reset.css"
      ];
    };
  }
