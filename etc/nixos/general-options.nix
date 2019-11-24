{ config, lib, pkgs, ... }:

{
  #grub
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  #Networking
  networking.hostName = "hera"; #hostname.
  networking.networkmanager.enable = true; #networking via networkmanager

  #internationalisation
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "fr";
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
  services.cron.systemCronJobs = [ "0 22 * * * root updatedb" "*/15 * * * * iheb newsboat -x reload" "*/6 * * * * root /home/iheb/.local/bin/checklowbattery.sh" "*/10 * * * * iheb /home/iheb/.local/bin/mailsync" ];


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.iheb = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  ##Block ad and malware hosts
  #networking.extraHosts = builtins.readFile (builtins.fetchurl {
    #name = "blocked_hosts.txt";
    #url =
    #"https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
  #});


  #sudoers file
  security.sudo.extraConfig = "%wheel ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/shutdown,/run/current-system/sw/bin/reboot,/run/current-system/sw/bin/mount,/run/current-system/sw/bin/umount,/run/current-system/sw/bin/jmtpfs,/run/current-system/sw/bin/light,/run/current-system/sw/bin/loadkeys,/run/current-system/sw/bin/ydotool,/run/current-system/sw/bin/ydotoold,/run/current-system/sw/bin/systemctl stop bluetooth.service,/run/current-system/sw/bin/systemctl start bluetooth.service\n";

}
