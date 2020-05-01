{ config, lib, pkgs, ... }:

let
  inherit (import ../variables.nix) mainUser;
  home-manager = import ( builtins.fetchTarball "https://github.com/rycee/home-manager/archive/release-20.03.tar.gz" )  { };
in

{
  imports = [ home-manager.nixos ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  #Iheb
  users.users.${mainUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "video" ];
    shell = pkgs.zsh;
  };
  home-manager.users.${mainUser} = import ./mainuser.nix ;
}
