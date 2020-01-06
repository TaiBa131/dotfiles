{ config, lib, pkgs, ... }:

let

  #In case of debugging my nur repo
  #NurRepo = import /home/iheb/.local/repos/nur-packages { inherit pkgs; };
  NurRepo = import ( builtins.fetchTarball "https://github.com/ihebchagra/nur-packages/archive/master.tar.gz" ) { inherit pkgs; };
  UnstableRepo = import ( builtins.fetchTarball "https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz" )  { };

in

{

  #edits to packages + my nix packages
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      unstable = UnstableRepo;
      nur = NurRepo;
      vimCustom = NurRepo.vimCustom;
      zathura-poppler-only = NurRepo.zathura-poppler-only;

      ncmpcpp = pkgs.ncmpcpp.override { visualizerSupport = true; };
      neomutt = pkgs.neomutt.overrideAttrs ( oldAttrs: {
        buildInputs = with pkgs; [
          cyrus_sasl gss gpgme kerberos libidn ncurses
          openssl perl lmdb
          mailcap
        ];
        configureFlags = [
          "--gpgme"
          "--gss"
          "--lmdb"
          "--ssl"
          "--sasl"
          "--with-homespool=mailbox"
          "--with-mailpath="
          # Look in $PATH at runtime, instead of hardcoding /usr/bin/sendmail
          "ac_cv_path_SENDMAIL=sendmail"
        ];
      });
      notmuch = pkgs.notmuch.overrideAttrs ( oldAttrs: {
        buildInputs = with pkgs; [
          gnupg
          xapian gmime3 talloc zlib
          perl
          pythonPackages.python
        ];
        postPatch = ''
          patchShebangs configure
          patchShebangs test/

          substituteInPlace lib/Makefile.local \
            --replace '-install_name $(libdir)' "-install_name $out/lib"
        '';
        doCheck = false;
      });

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
        alttab
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

  #weechat IRC client
  services.weechat.enable = true;
  programs.screen.screenrc = ''
    multiuser on
    acladd iheb
    term screen-256color
  '';

  environment = {
  systemPackages = with pkgs; [
    ####vim
    vimCustom
    ####sysutil
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
    ####audio
    pavucontrol
    pulsemixer
    audacity
    mpd
    mpdris2
    mpc_cli
    ncmpcpp
    easytag
    ####video
    mpv
    kdenlive
    ####img
    sxiv
    imagemagick
    krita
    gmic_krita_qt
    kolourpaint
    nur.ueberzug
    ####documents
    zathura
    zathura-poppler-only
    libreoffice
    pandoc
    texlive.combined.scheme-full
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
    appimage-run
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
    ####Torrenting Linux ISOs
    deluge
    ####mail
    neomutt
    isync
    msmtp
    pass
    gnupg
    notmuch
    ####gaymen
    wineWowPackages.staging
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
