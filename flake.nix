{
  description = "Reproducing testcase for renovate#25514";

  inputs = {
    # Actual versions are pinned in lockfile
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, flake-utils, nixpkgs }:
    # TODO: Figure out the whole nix-systems/linux thing
    flake-utils.lib.eachSystem [ "aarch64-linux" "x86_64-linux" ] (system:
      with import nixpkgs { inherit system; }; {
        packages.default = writers.writeBash "hello" ''
          echo hello ''${USER:-world}!
        '';

        devShells.default = mkShell {};
      });
}
