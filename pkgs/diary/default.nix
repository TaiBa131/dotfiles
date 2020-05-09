{ buildGoModule, fetchFromGitHub }:

buildGoModule {
  name = "diary";
  src = fetchFromGitHub {
    owner = "ihebchagra";
    repo = "diary";
    rev = "70f7f64da417ec82f736444aa497d8527e8e60cf";
    sha256 = "04zb5z7v21hqyvaj94ygpbymi59pmy33zsbmwbdmbrd7sc01mm5f";
  };
  modSha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";
  subPackages = [ "." ];
}
