{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/42cdbf35-3300-450f-bb0f-d941906cd77e";
      fsType = "ext4";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/796a75e3-4533-4d06-9303-0a20ddd8e66b"; }
    ];

  #kernel
  boot.kernelParams = [ "pci=noaer" ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  hardware.enableAllFirmware = true;
  boot.kernel.sysctl = {"vm.swappiness" = 10;};

  # Enable sound.
  sound.enable = true;

  hardware = {
    #Bluetooth
    bluetooth.enable = true;
    bluetooth.powerOnBoot = false;
    ##for bluetooth headset support
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.enable = true;

    #graphics
    opengl = {
      driSupport32Bit = true;
      enable = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver # LIBVA_DRIVER_NAME=iHD to use this
      ];
    };
  };

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  #Graphics drivers and screen tear fix
  services.xserver = {
    enable=true;
    videoDrivers = [ "intel" ];
    deviceSection = ''
      Option "DRI" "2"
      Option "TearFree" "true"
      '';
    libinput = {
      enable = true;
      middleEmulation = true;
    };
  };

  nix.maxJobs = lib.mkDefault 4;
  powerManagement = {
    cpuFreqGovernor = lib.mkDefault "powersave";
    powertop.enable = true;
  };
}
