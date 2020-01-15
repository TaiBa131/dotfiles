{ config, lib, pkgs, ... }:

{

  #edits to packages + my nix packages
  nixpkgs.config = import ../pkgs/nixpkgs-config.nix;

  #Use my binary cache for packages
  nix = {
    binaryCaches = [ "https://chagra.cachix.org/" ];
    trustedBinaryCaches = [ "https://chagra.cachix.org/" ];
    binaryCachePublicKeys = [ "chagra.cachix.org-1:Km6wWFDVC2KxXQSZ2bsnk+tnrQ/ONQqea4jFSAr88Pk=" ];
    requireSignedBinaryCaches = true;
  };

  environment.pathsToLink = [
    "/share"
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-kde ];

  services.xserver = {
    displayManager.startx.enable = true;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  #bash options and bash_profile
  programs.bash.enableCompletion = true;

  programs.ssh.askPassword = "${pkgs.ksshaskpass}/bin/ksshaskpass";

  #GnuPG
  programs.gnupg.agent = {
   enable = true;
  };

  #brightness control
  services.illum.enable = true;

  #weechat IRC client
  services.weechat.enable = true;
  programs.screen.screenrc = ''
    multiuser on
    acladd iheb
    term screen-256color
  '';

  environment = {
  systemPackages = with pkgs; [
    vimCustom
    xclip
    ];
  };

}
