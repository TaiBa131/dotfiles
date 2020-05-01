{ config, lib, pkgs, ... }:

let
  inherit (import ../variables.nix) nixosConfigDir mainUser;
in
{
  services = {
    #Login prompt
    mingetty.helpLine = "If you're not Iheb, Please leave this computer alone";

    xserver = {
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
      };
      displayManager.startx.enable = true;
      layout = "fr";
      xkbOptions = "caps:swapescape";
    };

    #brightness control
    illum.enable = true;

    autorandr.enable = true;

    # Maybe this one day will be useful
    # Enable CUPS to print documents.
    printing.enable = true;
    printing.drivers = with pkgs; [ gutenprint ];

    #for scripts running in the background
    cron.enable = true;
    cron.systemCronJobs = [
      "0 22 * * * root updatedb"
      "*/6 * * * * ${mainUser} i3-msg -s $(cat $HOME/.i3_socket) -- exec checklowbattery.sh"
      "*/15 * * * * ${mainUser} i3-msg -s $(cat $HOME/.i3_socket) -- exec newsboat -x reload"
      "*/10 * * * * ${mainUser} i3-msg -s $(cat $HOME/.i3_socket) -- exec mailsync" ];
  };

  #lockscreen on sleep
  systemd.services.i3suspend = {
    enable = true;
    before = [ "sleep.target" "suspend.target" ];
    description = "lockscreen on lid close";
    serviceConfig = {
      Type = "oneshot";
      User = "${mainUser}";
      ExecStart = pkgs.writeScript "laptopsleepmode.sh" ''
        #!${pkgs.stdenv.shell}
        ${pkgs.i3-gaps}/bin/i3-msg -s $(cat /home/${mainUser}/.i3_socket) -- exec suspend.sh
        sleep 5
        '';
      };
    wantedBy = [ "sleep.target" "suspend.target" ];
  };

}
