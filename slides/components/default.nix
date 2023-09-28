{nix2html}:
with nix2html; rec {
  plainText = str: (text {text = [str];});

  slidesContainer = slides:
    div {
      attributes = {
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
                  (
                    plainText pageTitle
                  )
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
}
