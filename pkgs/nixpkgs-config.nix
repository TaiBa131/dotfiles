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

    vimCustom = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/overrides/vim.nix") { };
    zathura-poppler-only = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/overrides/zathurapoppler.nix") { };

    ueberzug = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/ueberzug") { };
    nudoku = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/nudoku") { };
    ripcord = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/ripcord") { };
    compton-tryone = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/compton-tryone") { };

    ncmpcpp = pkgs.ncmpcpp.override { visualizerSupport = true; };
  };
}
