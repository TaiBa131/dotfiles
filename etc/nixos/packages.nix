{ config, lib, pkgs, ... }:

let

  #My Nix User Repository/Channel
  NurRepo = import <nur> { inherit pkgs; };

  #In case of debugging my nix channel
  #NurRepo = import /home/iheb/.local/repos/nur-packages { inherit pkgs; };
  #NurRepo = import ( builtins.fetchTarball "https://github.com/ihebchagra/nur-packages/archive/master.tar.gz" ) { inherit pkgs; };

in

{

  #edits to packages + my nix packages
  nixpkgs.config = {
    allowUnfree = true;
    ncmpcpp.visualizerSupport = true;
    packageOverrides = pkgs: {
      unstable = import <unstable> {};
      nur = NurRepo;
      neomutt = NurRepo.neomutt;
      notmuch = NurRepo.notmuch;
      vimCustom = NurRepo.vimCustom;
      zathura-poppler-only = NurRepo.zathura-poppler-only;
    };
  };

  #Use my binary cache for packages
  nix = {
    binaryCaches = [ "https://chagra.cachix.org/" ];
    trustedBinaryCaches = [ "https://chagra.cachix.org/" ];
    binaryCachePublicKeys = [ "chagra.cachix.org-1:Km6wWFDVC2KxXQSZ2bsnk+tnrQ/ONQqea4jFSAr88Pk=" ];
    requireSignedBinaryCaches = true;
  };

  services.xserver = {
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [
        bemenu
        i3blocks
        i3lock
        dunst
        maim
        redshift
        xidlehook
        xdotool
        xclip
        arandr
        nur.compton-tryone
      ];
    };
    displayManager.startx.enable = true;
    enable = true;
  };

  #kde file picker and gui stuff
  imports =
    [
      NurRepo.modules.kdefilepicker
    ];

  #Search engine hosted locally
  services.searx.enable = true;
  services.searx.configFile = /home/iheb/.config/searx/settings.yml;

  #bash options and bash_profile
  programs.bash.enableCompletion = true;
  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.autosuggestions.enable = true;

  #GnuPG
  programs.gnupg.agent = {
   enable = true;
  };

  #brightness control
  services.illum.enable = true;

  environment = {
  systemPackages = with pkgs; [
    ####vim
    vimCustom
    ####sysutil
    networkmanagerapplet
    htop
    libnotify
    pciutils
    killall
    usbutils
    acpi
    inotify-tools
    xdg_utils
    ####dev
    git
    gawk
    jq
    unstable.websocat
    ####audio
    pavucontrol
    pulsemixer
    audacity
    mpd
    mpdris2
    mpc_cli
    ncmpcpp
    ####video
    mpv
    kdenlive
    ####img
    sxiv
    imagemagick
    krita
    gmic_krita_qt
    ####documents
    zathura
    zathura-poppler-only
    libreoffice
    ####shell
    libqalculate
    kitty
    ####files
    ranger
    syncthing
    jmtpfs
    keepassxc
    unrar
    zip
    unzip
    fzf
    ripgrep
    ffmpeg
    pandoc
    ####Ranger utils
    atool
    libarchive
    mupdf
    ffmpegthumbnailer
    exiftool
    file
    poppler_utils
    ####web
    qutebrowser
    youtube-dl
    wget
    lynx
    ####torrent
    deluge
    ####mail
    neomutt
    isync
    msmtp
    pass
    gnupg
    notmuch
    ####latex
    texlive.combined.scheme-full
    ####gaymen
    wine
    nur.nudoku
    nur.ripcord
    ####misc
    tty-clock
    calcurse
    newsboat
    pywal
    nix-prefetch-scripts
    nix-prefetch-github
    ];
  };

}
