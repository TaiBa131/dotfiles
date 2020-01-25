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
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "pci=noaer" "mitigations=off" ];
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.extraModprobeConfig = ''
    options rtl8723be swenc=1
  '';

  # Enable sound.
  sound.enable = true;

  hardware = {
    #Bluetooth
    bluetooth.enable = true;
    bluetooth.powerOnBoot = false;
    ##for bluetooth headset support
    pulseaudio.package = pkgs.pulseaudioFull;
    pulseaudio.enable = true;

    #Intel
    cpu.intel.updateMicrocode = true;

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
    #bumblebee = {
    #  enable = true;
    #  driver = "nvidia";
    #};
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
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  #services.tlp.enable = true;
  #services.tlp.extraConfig = ''
  #  TLP_DEFAULT_MODE=BAT
  #  TLP_PERSISTENT_DEFAULT=0
  #  CPU_SCALING_GOVERNOR_ON_AC=powersave
  #  CPU_SCALING_GOVERNOR_ON_BAT=powersave
  #  CPU_SCALING_MIN_FREQ_ON_BAT=400000
  #  CPU_SCALING_MIN_FREQ_ON_AC=400000
  #  CPU_SCALING_MAX_FREQ_ON_BAT=2700000
  #  CPU_SCALING_MAX_FREQ_ON_AC=3500000
  #  ENERGY_PERF_POLICY_ON_AC=power
  #  ENERGY_PERF_POLICY_ON_BAT=power
  #  CPU_HWP_ON_AC=power
  #  CPU_HWP_ON_BAT=power
  #  CPU_BOOST_ON_AC=1
  #  CPU_BOOST_ON_BAT=0
  #  SCHED_POWERSAVE_ON_AC=1
  #  SCHED_POWERSAVE_ON_BAT=1
  #'';

}
