{ pkgs, rust-bindgen, rust-bindgen-unwrapped, fetchFromGitHub, clang_13, ... }:
let
  rust-bindgen-kernel-unwrapped =
    (rust-bindgen-unwrapped.override {
      clang = clang_13;
    }).overrideAttrs (old: rec {
      version = "0.56.0";

      src = fetchFromGitHub {
        owner = "rust-lang";
        repo = "rust-bindgen";
        rev = "v${version}";
        sha256 = "bqAQrECDz8WMM5wAsAcmZlbeGZ8ngpakvpC1W/AKfCU=";
      };

      cargoDeps = old.cargoDeps.overrideAttrs (_: {
        inherit src;

        name = "${old.pname}-${version}-vendor.tar.gz";
        outputHash = "17hxpakwpxp2nva0bk621h7bn9zjlr5jx3d3m82ncgai44hg77cp";
      });
    });

in
rust-bindgen.override {
  rust-bindgen-unwrapped = rust-bindgen-kernel-unwrapped;
}


