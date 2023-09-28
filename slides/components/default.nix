{nix2html}:
with nix2html; rec {
  plainText = str: (text {text = [str];});

  document = {
    pageTitle ? "Nix Camp 2023",
    children ? [],
  }:
    html {
      children = [
        (head {
          children = [
            (title {
              children = [
                (
                  plainText pageTitle
                )
              ];
            })
          ];
        })
        (body {
          inherit children;
        })
      ];
    };
}
