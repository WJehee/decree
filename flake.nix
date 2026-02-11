{
    description = "Personal website";
    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    };
    outputs = { self, nixpkgs }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    #     website = with pkgs; stdenv.mkDerivation {
    #         pname = "Zola blog: wouterjehee.com";
    #         version = "1.0.0";
    #         src = ./.;
    #         buildInputs = [ 
    #             zola
    #             tailwindcss
    #         ];
    #         buildPhase = ''
    #             tailwindcss -i styles/styles.css -o static/css/styles.css --minify
    #             zola build
    #         '';
    #         installPhase = ''
    #             cp -r public $out
    #         '';
    #     };
    in
    {
        devShells.${system}.default = with pkgs; mkShell {
            buildInputs = [ 
                hugo
                tailwindcss_4
                asciidoctor
            ];
        };
        # packages.${system}.default = website;
    };
}
