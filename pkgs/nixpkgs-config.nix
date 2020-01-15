{ pkgs, ... }:

let
  UnstableRepo = import ( builtins.fetchTarball "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz" )  { };
  NurRepo = import ( builtins.fetchTarball "https://github.com/ihebchagra/nur-packages/archive/master.tar.gz" ) { inherit pkgs; };
  nixosConfigDir = "/etc/nixos";
in

{
  allowUnfree = true;
  packageOverrides = pkgs: {
    unstable = UnstableRepo;
    nur = NurRepo;

    vimCustom = pkgs.callPackage (builtins.toPath ''${nixosConfigDir}/pkgs/overrides/vim.nix'') { };
    zathura-poppler-only = pkgs.callPackage (builtins.toPath ''${nixosConfigDir}/pkgs/overrides/zathurapoppler.nix'') { };

    ueberzug = pkgs.callPackage (builtins.toPath ''${nixosConfigDir}/pkgs/ueberzug'') { };
    nudoku = pkgs.callPackage (builtins.toPath ''${nixosConfigDir}/pkgs/nudoku'') { };
    ripcord = pkgs.callPackage (builtins.toPath ''${nixosConfigDir}/pkgs/ripcord'') { };
    compton-tryone = pkgs.callPackage (builtins.toPath ''${nixosConfigDir}/pkgs/compton-tryone'') { };

    ncmpcpp = pkgs.ncmpcpp.override { visualizerSupport = true; };
    neomutt = pkgs.neomutt.overrideAttrs ( oldAttrs: {
      buildInputs = with pkgs; [
        cyrus_sasl gss gpgme kerberos libidn ncurses
        openssl perl lmdb
        mailcap
      ];
      configureFlags = [
        "--gpgme"
        "--gss"
        "--lmdb"
        "--ssl"
        "--sasl"
        "--with-homespool=mailbox"
        "--with-mailpath="
        # Look in $PATH at runtime, instead of hardcoding /usr/bin/sendmail
        "ac_cv_path_SENDMAIL=sendmail"
      ];
    });
    notmuch = pkgs.notmuch.overrideAttrs ( oldAttrs: {
      buildInputs = with pkgs; [
        gnupg
        xapian gmime3 talloc zlib
        perl
        pythonPackages.python
      ];
      postPatch = ''
        patchShebangs configure
        patchShebangs test/

        substituteInPlace lib/Makefile.local \
          --replace '-install_name $(libdir)' "-install_name $out/lib"
      '';
      doCheck = false;
    });

  };
}
