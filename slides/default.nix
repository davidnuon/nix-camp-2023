{nix2html}: let
  components = import ./components {inherit nix2html;};
in {
  slides = components.slides [
    ''
      # Nix.Camp 2023
      ## My journey through to Nix
    ''

    ''
      # I started using Nix ~4 months ago in May
      - I wanted a better way to provision workstations vs. Ansible
      - Nix dev-shells was my gateway drug
    ''

    ''
      # I love ansible
      ## But it's imperative nature
    ''
  ];
}
