{
  description = "Development environment for Forkd project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = [
              pkgs.nodejs_22 # Explicitily request Node.js 22
              pkgs.pnpm        # Latest PNPM
              pkgs.go          # Latest Go
              pkgs.go-task     # Latest Task
              pkgs.golangci-lint
            ];

            shellHook = ''
              echo "Welcome to the Forkd development environment!"
              echo "Node.js: $(node -v)"
              echo "PNPM: $(pnpm --version)"
              echo "Go: $(go version)"
              echo "Task: $(task --version)"
              echo "golangci-lint: $(golangci-lint --version)"
            '';
          };
        };
      }
    );
}
