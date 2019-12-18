{
  packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/ihebchagra/nur-packages/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
  allowUnfree = true;
}
