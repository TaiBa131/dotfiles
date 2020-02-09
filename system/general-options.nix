{ config, lib, pkgs, ... }:

let
  inherit (import ../variables.nix) nixosConfigDir mainUser;
in
{
  #grub
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.splashImage = ./splashscreen.png;

  #Networking
  networking.hostName = "hera"; #hostname.
  networking.networkmanager.enable = true; #networking via networkmanager

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
  };

  #time zone.
  time.timeZone = "Africa/Tunis";

  documentation.doc.enable = false;

  #sudoers file
  security.sudo.extraConfig = ''
      %wheel ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/shutdown,/run/current-system/sw/bin/reboot,/run/current-system/sw/bin/mount,/run/current-system/sw/bin/umount,${pkgs.jmtpfs}/bin/jmtpfs
  '';
}
