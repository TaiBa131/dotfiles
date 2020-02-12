{ buildGoModule, fetchFromGitHub }:

buildGoModule {
  name = "diary";
  src = fetchFromGitHub {
    owner = "ihebchagra";
    repo = "diary";
    rev = "e3434baca8ba3ccd2b494908bad11acfbf1277f0";
    sha256 = "0iin9vg1dj8fq95xll2hnna2a75nas77jw384syawa9bqxqlcvx9";
  };
  modSha256 = "0sjjj9z1dhilhpc8pq4154czrb79z9cm044jvn75kxcjv6v5l2m5";
  subPackages = [ "." ];
}
