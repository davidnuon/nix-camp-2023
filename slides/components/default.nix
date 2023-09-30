{nix2html}: let
in
  with nix2html; rec {
    slidesContainer = slides:
      div {
        attributes = {
          style = "font-size:40px;";
          class = "reveal";
        };

        children = [
          (div
            {
              attributes = {
                class = "slides";
              };

              children = slides;
            })
        ];
      };

    slide = children:
      section {
        inherit children;
      };

    mdSlide = markdown:
      section {
        attributes = {
          "data-markdown" = "";
        };
        children = [
          (textarea
            {
              attributes = {
                "data-template" = "";
              };
              children = [
                markdown
              ];
            })
        ];
      };

    document = {
      pageTitle ? "Nix Camp 2023",
      children ? [],
      scripts ? [],
      stylesheets ? [],
      footer ? [],
    }: let
      scriptTags = map (src:
        script {
          attributes = {inherit src;};
        })
      scripts;

      styleTags = map (href:
        link {
          attributes = {
            rel = "stylesheet";
            inherit href;
          };
        })
      stylesheets;
    in
      html {
        children = [
          (head {
            children =
              [
                (title {
                  children = [
                    pageTitle
                  ];
                })
              ]
              ++ styleTags;
          })
          (body {
            children = children ++ scriptTags ++ footer;
          })
        ];
      };

    slides = mdContent:
      document {
        pageTitle = "Nix Camp 2023";
        children = [
          (
            slidesContainer (map mdSlide mdContent)
          )
        ];
        scripts = [
          "./reveal.js"
          "./plugin/markdown/markdown.js"
        ];
        stylesheets = [
          # "./reset.css"
          "./reveal.css"
          "./theme/sky.css"
        ];

        footer = [
          (nix2html.script
            {
              children = [
                ''Reveal.initialize({ plugins: [ RevealMarkdown ]});''
              ];
            })
        ];
      };
  }
