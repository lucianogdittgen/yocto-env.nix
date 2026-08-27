# herdr built straight from the upstream tree's own `nix/package.nix`, so a
# release bump is the two-line version/hash change below rather than a
# hand-maintained copy of Herdr's zig + rust packaging (libghostty-vt's
# `build.zig.zon.nix` vendor derivation, the fileset `src`, the build-time
# `LIBGHOSTTY_VT_*` env).
#
# Upstream's flake feeds that file a rust-overlay toolchain pinned by
# `rust-toolchain.toml` (stable 1.96.1). We let `callPackage` supply nixpkgs'
# own `rustPlatform` instead — it is stable 1.97, new enough for the pin — which
# keeps the rust-overlay flake input out of this repo.
{ pkgs, ... }:

let
  version = "0.8.2";

  src = pkgs.fetchFromGitHub {
    owner = "herdrdev";
    repo = "herdr";
    tag = "v${version}";
    hash = "sha256-sEGIN3dLZasaHob3EHscWBCIQHflMQVchYmzgsETDk4=";
  };
in
pkgs.callPackage "${src}/nix/package.nix" { }
