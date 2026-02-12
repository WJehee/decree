{
    description = "Personal website";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        website = with pkgs; stdenv.mkDerivation {
            pname = "wouterjehee.com";
            version = "1.0.0";
            src = ./.;
            nativeBuildInputs = [
                hugo
                tailwindcss_4
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
                tailwindcss_4
                asciidoctor-quiet
            ];
        };
        packages.${system}.default = website;
    };
}
