{nix2html}: let
  components = import ./components {inherit nix2html;};
in {
  slides = components.slides [
    ''
      ## My journey to Nix

      [github.com/davidnuon/nix2html](https://github.com/davidnuon/nix2html)
      [github.com/davidnuon/nix-camp-2023](https://github.com/davidnuon/nix-camp-2023)
      [nixcamp.tardyscholar.dev](http://nixcamp.tardyscholar.dev/)
    ''

    ''
      ### I was working with Dan on a project when he said to me...
    ''

    ''
      Dan said

      > David, I want to control npm with nix

      and I said

      > Why, what is wrong with you.
    ''

    ''
      ## How I got in
        - I started using Nix ~4 months ago in May 2023
        - I wanted a better way to provision workstations vs. Ansible
        - Nix `dev-shell` was my gateway drug
    ''

    ''
      ## Ansible has its place
      - I have immense repsect for ansible
      - But it has shown its flaws
        - State of hosts is hard to determine
        - Doing sophisticated computation involves brittle text-based templating
        - Narrative of reusing playbooks and roles is dicey
      - Nix's notion of "building a system" is what I wanted all along
    ''

    ''
      ## Nix was pretty pleasant
        - Writing the nixconfigs for multiple hosts was quick
        - I've had experience with other functional languages, learning nixlang was low friction
        - Learning to _use_ Nix, the package manager took some time
    ''
    ''
      ## Multi-language support was a struggle
      - Khmer and Korean took a bit to figure out
      - I didn't have Japanese (mozc) working until 2 weeks ago
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
      - Written just to make these slides
      - "Component-based" html writing
      - elmlang inspired
      - If you're familiar with React, Preact, Flutter or Reason this should be familiar
    ''

    ''
      ## Inspiration
      - It came to me in a dream
      - @html_org, my favorite twitter account
      - What if nix, but beyond config?
        - Wanted to learn _nixlang_ without going into packaging things
      - I got tired of working on the SoCal Nix User Group site
    ''

    ''
      ## How it works
      - Each component returns an `attrset` with the form
         ```
          {
            attributes = {}; children = []; name = "tag-name";
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
      Another example of render
      ```
      render :: Component -> String
      render (div {
        children = [
          (text "this is a test")
        ];
      })`

      # => <div>this is a test</div>
      ```

    ''

    ''
      ## This approach can be used for other document types

      nix2pdf
      nix2psd
      nix2svg
      nix2openscad
      nix2guix
    ''

    ''
      ## Next steps

      - Burn this &#128293;
      - Add HTMX support
      - Add support to evaluate nix on backend
        - Take inspiration from React Server Components
        - and the thing Matt demoed yesteday
        - and WASM???
    ''

    ''
      ### Questions?

      `nix-build https://github.com/davidnuon/nix-camp-2023`
    ''
  ];
}
