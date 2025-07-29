{
    description = "";
    inputs = {
        nixpkgs = {
            url = "github:nixos/nixpkgs";
        };

        flake-utils = {
            url = "github:numtide/flake-utils";
        };
    };
    outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = (pkgs.buildFHSUserEnv {
          name = "python-uv-env";
          targetPkgs = pkgs: with pkgs; [
            python3
            uv
            gcc
            glibc
            zlib
            libffi
            openssl
            git
            curl
          ];
          profile = ''
            export SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt
            export REQUESTS_CA_BUNDLE=$SSL_CERT_FILE
            export CURL_CA_BUNDLE=$SSL_CERT_FILE
          '';
          runScript = "bash";
        }).env;
      });
}