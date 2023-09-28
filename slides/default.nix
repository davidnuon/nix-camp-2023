{nix2html}: let
  components = import ./components {inherit nix2html;};
in {
  slides = components.slides [
    ''
      # Nix.Camp 2023
    ''

    ''
      Hello world!
    ''
  ];
}
