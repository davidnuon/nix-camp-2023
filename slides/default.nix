{nix2html}: let
  components = import ./components {inherit nix2html;};
in {
  slides = components.slides [
    ''
      ## My journey through to Nix

      [github.com/davidnuon/nix2html](https://github.com/davidnuon/nix2html)
      [github.com/davidnuon/nix-camp-2023](https://github.com/davidnuon/nix-camp-2023)
      [nixcamp.tardyscholar.dev](http://nixcamp.tardyscholar.dev/)
    ''

    ''
      ### I was working with @djacu on a project when he said to me:
    ''

    ''
      Dan said

      > David, I want to control npm with nix

      and I said

      > Why, what is wrong with you.
    ''

    ''
      ## How I got in
        - I started using Nix ~4 months ago in May
        - I wanted a better way to provision workstations vs. Ansible
        - Nix dev-shells was my gateway drug
    ''

    ''
      - I have immense repsect for ansible
      - But it has shown its flaws
        - State of hosts is hard to determine
        - Doing sophisicated computation involes britle text-based templating
        - Narrative of reusing playbooks and roles is dicey
    ''

    ''
      - Writing the nixconfigs for multiple hosts was quick
      - I've had experience with other functional languages, learning nix low friction
    ''
    ''
      ## Multi-language support was a struggle
      - Khmer and Korean took a bit to figure out
      - I didn't have Japanese (mozc) didn't work until 2 weeks ago
    ''
    ''
      ### But now I'm looking to swtich to NixOS on all my Linux hosts

      - TODOs:
        - Write configs to use flakes
        - Use Home Manager (or should I bother)?
    ''
    ''
      # These slides are written in Nix
    ''
    ''
      ## Introducing `nix2html`
      - Written this morning at 6am
      - "Component-based" html writing
      - elmlang inspired
    ''

    ''
      ## Inspiration
      - htmx
      - What if nix, but beyond config?
      - it came to me in a dream
        - before nixcamp
      - I got tired of working on the SoCal NUG site
    ''

    ''
      ## How it works
      - Each component returns an `attrset` with the form
         ```
          {
            attributes = {}; children = []; name = "TagName"
          }
          ```
      - a `render` function turns `Component -> String`
        - a Component can have any number of children, any depth
    ''
    ''
      ## It's all functions

      Generic Element
        ```
          basicElement = {
            name,
            attributes ? {},
            children ? [],
          }: {
            inherit name attributes children;
          };
        ```
    ''
    ''
        Function Element factory

        ```
          genericElementFactory = name: {
            attributes ? {},
            children ? [],
          }:
          basicElement {
            inherit name
              attributes
              children;
          };
      ```
    ''
    ''
      Defining more elements

      ```
        html = genericElementFactory "html";
        head = genericElementFactory "head";
        body = genericElementFactory "body";
        h1 = genericElementFactory "h1";
        p = genericElementFactory "p";
      ```
    ''

    ''
      Defining Components
      ```
          slidesContainer = children: div {
            attributes = {
              class = "slide-container";
            };
            inherit children;
          };
          slides = text : seciton {
            attributes = {
              class = "slide-container";
            };
            children = [text];
          };
      ```
    ''

    ''
      Using the components
      ```
      slides = slidesContainer (map slides [
        "Slide 1"
        "Hello World"
        "Bark bark bark"
      ]);

      pkgs.writeText "index.html" (render slides)
      ```
    ''

    ''
      ## Next steps

      - Burn this &#128293;
      - Add HTMX support
      - Add support to evaluate nix on backend
        - Take inspiration from React Server Components
    ''

    ''
      ### Questions?

      `nix-build https://github.com/davidnuon/nix-camp-2023`
    ''
  ];
}
