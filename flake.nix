{
  description = "Repomix - A tool for managing repositories";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        # Let's debug what we're getting from default.nix
        repomixPackage = import ./default.nix { inherit pkgs system; };
      in
      {
        # We'll try outputting whatever default.nix provides directly
        packages.default = repomixPackage.nodeDependencies // {
          meta = repomixPackage.nodeDependencies.meta // { mainProgram = "repomix"; };
          pname = "repomix";
        };
      });
}
