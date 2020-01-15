{ config, lib, pkgs, ... }:

let
    home-manager = import ( builtins.fetchTarball "https://github.com/rycee/home-manager/archive/release-19.09.tar.gz" )  { };
in

{
  imports = [ home-manager.nixos ];

  # Define a user account. Don't forget to set a password with ‘passwd’.

  #Iheb
  users.users.iheb = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "video" ];
    shell = pkgs.zsh;
  };
  home-manager.users.iheb = import ./iheb.nix;
}
