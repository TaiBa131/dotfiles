{ config, lib, pkgs, ... }:

{
  imports = [
      #system
      ./system/hardware.nix
      ./system/general-options.nix
      ./system/packages.nix
      ./system/services.nix
      ./system/fonts.nix

      #users + home-manager
      ./users/users.nix
    ];


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09";
  # system.autoUpgrade.enable = true; #autoupdate
  nix.gc.automatic = true; #garbage collection
  nix.gc.dates = "18:00"; #gc time of day
}
