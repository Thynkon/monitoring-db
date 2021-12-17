{ pkgs ? import <nixpkgs> {} }:

let
  ruby = pkgs.ruby_3_0;
  libpcap = pkgs.libpcap;
in
    pkgs.mkShell {
        buildInputs = [
          ruby
          libpcap
        ];
    }
