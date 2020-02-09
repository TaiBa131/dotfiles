{ buildGoModule, fetchFromGitHub }:

buildGoModule {
  name = "personalblocks";
  src = fetchFromGitHub {
    owner = "ihebchagra";
    repo = "personalblocks";
    rev = "0a1ad7d5b9222d90a82791a08dad3a24ed95c882";
    sha256 = "0xr7nb9csnlwicsqmg01lf0xbg3mhms7wsmiy1zmfjcffn7jcmgr";
  };
  modSha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";
  subPackages = [ "." ];
}
