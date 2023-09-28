{nix2html}:
with nix2html; rec {
  plainText = str: (text {text = [str];});

  document = {
    pageTitle ? "Nix Camp 2023",
    children ? [],
    scripts ? [],
    stylesheets ? [],
  }: let
    scriptTags = map (src:
      script {
        attributes = {inherit src;};
      })
    scripts;

    styleTags = map (href:
      style {
        attributes = {inherit href;};
      })
    stylesheets;
  in
    html {
      children = [
        (head {
          children = [
            (title {
              children =
                [
                  (
                    plainText pageTitle
                  )
                ]
                ++ styleTags;
            })
          ];
        })
        (body {
          children = children ++ scriptTags;
        })
      ];
    };
}
