{ buildGoModule, fetchFromGitHub }:

buildGoModule {
  name = "personalblocks";
  src = fetchFromGitHub {
    owner = "ihebchagra";
    repo = "personalblocks";
    rev = "9a72df8e5e50f847ca9f379fd878ee1c81db22d2";
    sha256 = "1vzqcp5j2n89ipgg7rvx939v73z4smphlcp3drw0sgxq9fyhkhyw";
  };
  modSha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";
  subPackages = [ "." ];
}
