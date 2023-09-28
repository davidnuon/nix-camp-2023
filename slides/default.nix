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
        (
          slidesContainer (map mdSlide [
            ''
              # Nix.Camp 2023
            ''

            ''
              Hello world!
            ''
          ])
        )
      ];
      scripts = [
        "./reveal.js"
        "./plugin/markdown/markdown.js"
      ];
      stylesheets = [
        # "./reset.css"
        "./reveal.css"
      ];

      footer = [
        (nix2html.script
          {
            children = [
              (plainText ''                      
                  Reveal.initialize({ plugins: [ RevealMarkdown ]});'')
            ];
          })
      ];
    };
  }
