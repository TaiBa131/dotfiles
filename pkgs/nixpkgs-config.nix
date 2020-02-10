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


    mutt-wizard = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/mutt-wizard") { };
    personalblocks = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/personalblocks") { };
    ueberzug = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/ueberzug") { };
    nudoku = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/nudoku") { };
    ripcord = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/ripcord") { };
    compton-tryone = pkgs.callPackage (builtins.toPath "${nixosConfigDir}/pkgs/compton-tryone") { };

    ncmpcpp = pkgs.ncmpcpp.override { visualizerSupport = true; };
    autorandr = pkgs.autorandr.overrideAttrs (attrs: {
      patches = [ (pkgs.writeText "autorandr.patch" ''
                      diff --git a/autorandr.py b/autorandr.py
                      --- a/autorandr.py
                      +++ b/autorandr.py
                      @@ -317,7 +317,7 @@ class XrandrOutput(object):
                               else:
                                   edid = "%s-%s" % (XrandrOutput.EDID_UNAVAILABLE, match["output"])

                      -        if not match["connected"] or not match["width"]:
                      +        if not match["width"]:
                                   options["off"] = None
                               else:
                                   if match["mode_name"]:
                '')
        ];
    });
  };
}
