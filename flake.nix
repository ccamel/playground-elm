{
  description = "Elm Playground development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs =
    { nixpkgs, ... }:
    let
      supportedSystems = [
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
        "aarch64-linux"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor =
        system:
        import nixpkgs {
          inherit system;
          config.allowDeprecatedx86_64Darwin = true;
        };
    in
    {
      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgsFor system;
          patchedPnpm = pkgs.pnpm.overrideAttrs (_: {
            version = "11.8.0";
            src = pkgs.fetchurl {
              url = "https://registry.npmjs.org/pnpm/-/pnpm-11.8.0.tgz";
              hash = "sha512-wfXnxMskHI8XS3Q4UdgvQrgCMkr8iw8Ra5atsVqgZmSUjd42lgo7oQebpbSyndAUATW5S1tfUmNZIknWjlVfJg==";
            };
          });
        in
        {
          default = pkgs.mkShell {
            packages = [
              pkgs.codespell
              pkgs.git
              pkgs.nodejs_22
              patchedPnpm
              pkgs.rtk
              pkgs.elmPackages.elm
              pkgs.elmPackages.elm-format
              pkgs.elmPackages.elm-review
              pkgs.elmPackages.elm-json
              pkgs.elmPackages.elm-language-server
              pkgs.typescript-language-server
              pkgs.eslint
              pkgs.vscode-langservers-extracted
              pkgs.statix
              pkgs.deadnix
              pkgs.nixfmt
            ];
            shellHook = ''
              echo "Elm Playground development environment loaded"
            '';
          };
        }
      );
    };
}
