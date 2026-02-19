{
    description = "Personal website";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        # Hugo >= 0.161 only accepts tailwindcss as a Node.js script and runs
        # it via node itself, so the native nixpkgs binary needs a Node shim
        tailwindcss-shim = pkgs.writeTextFile {
            name = "tailwindcss-node-shim";
            destination = "/bin/tailwindcss";
            executable = true;
            text = ''
                #!${pkgs.nodejs}/bin/node
                const { spawnSync } = require("node:child_process");
                const result = spawnSync(
                    "${pkgs.tailwindcss_4}/bin/tailwindcss",
                    process.argv.slice(2),
                    { stdio: "inherit" },
                );
                process.exit(result.status === null ? 1 : result.status);
            '';
        };
        website = with pkgs; stdenv.mkDerivation {
            pname = "wouterjehee.com";
            version = "1.0.0";
            src = ./.;
            nativeBuildInputs = [
                hugo
                tailwindcss-shim
                nodejs
                asciidoctor-quiet
                git
            ];
            buildPhase = ''
                hugo --minify
            '';
            installPhase = ''
                cp -r public $out
            '';
        };
        asciidoctor-quiet = pkgs.writeShellScriptBin "asciidoctor" ''
            ${pkgs.asciidoctor}/bin/asciidoctor "$@" 2> >(${pkgs.gnugrep}/bin/grep -v "is ignoring.*because it is missing extensions" >&2)
        '';
    in
    {
        devShells.${system}.default = with pkgs; mkShell {
            buildInputs = [
                hugo
                tailwindcss-shim
                nodejs
                asciidoctor-quiet
            ];
        };
        packages.${system}.default = website;
    };
}
