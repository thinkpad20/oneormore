{ mkDerivation, base, stdenv }:
mkDerivation {
  pname = "oneormore";
  version = "0.1.0.4";
  src = ./.;
  buildDepends = [ base ];
  homepage = "https://github.com/thinkpad20/oneormore";
  description = "A never-empty list type";
  license = stdenv.lib.licenses.mit;
}
