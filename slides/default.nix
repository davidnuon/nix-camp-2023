{nix2html}: let
  components = import ./components {inherit nix2html;};
in {
  slides = components.slides [
    ''
      # Nix.Camp 2023
      ## My journey through to Nix
    ''

    ''
      Hello world!
    ''
  ];
}
