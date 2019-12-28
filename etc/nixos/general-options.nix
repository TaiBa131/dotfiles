{ config, lib, pkgs, ... }:

{
  #grub
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.splashImage = ./splashscreen.png;

  #Networking
  networking.hostName = "hera"; #hostname.
  networking.networkmanager.enable = true; #networking via networkmanager

  #internationalisation
  services.xserver = {
    layout = "fr";
    xkbOptions = "caps:swapescape";
  };

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleUseXkbConfig = true;
    defaultLocale = "en_US.UTF-8";
  };

  #time zone.
  time.timeZone = "Africa/Tunis";

  #Login prompt
  services.mingetty.helpLine = "If you're not Iheb, Please leave this computer alone";
  documentation.doc.enable = false;

  # Maybe this one day will be useful
  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [ gutenprint ];

  #for scripts running in the background
  services.cron.enable = true;
  services.cron.systemCronJobs = [ "0 22 * * * root updatedb" "*/15 * * * * iheb newsboat -x reload" "*/6 * * * * root /home/iheb/.local/bin/checklowbattery.sh" "*/10 * * * * iheb /home/iheb/.local/bin/mailsync" "*/7 * * * * iheb i3-msg -s $(cat $HOME/.i3_socket) -- exec webdiff" ];

  #lockscreen on sleep
  systemd.services.i3suspend = {
    enable = true;
    before = [ "sleep.target" "suspend.target" ];
    description = "lockscreen on lid close";
    serviceConfig = {
      Type = "oneshot";
      User = "iheb";
      ExecStart = pkgs.writeScript "laptopsleepmode.sh" ''
        #! /bin/sh
        ${pkgs.i3}/bin/i3-msg -s $(cat /home/iheb/.i3_socket) -- exec suspend.sh
        sleep 2
        '';
      };
    wantedBy = [ "sleep.target" "suspend.target" ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.iheb = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "input" "video" ];
    shell = pkgs.zsh;
  };


  #sudoers file
  security.sudo.extraConfig = "%wheel ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/shutdown,/run/current-system/sw/bin/reboot,/run/current-system/sw/bin/mount,/run/current-system/sw/bin/umount,/run/current-system/sw/bin/jmtpfs,/run/current-system/sw/bin/light,/run/current-system/sw/bin/systemctl stop bluetooth.service,/run/current-system/sw/bin/systemctl start bluetooth.service\n";

}
