{ pkgs, ... }:


let
  nixosConfigDir = "/etc/nixos";
in

{
  imports = [
    ./private/secrets.nix
  ];

  nixpkgs.config = import ../pkgs/nixpkgs-config.nix;

  programs.zsh.profileExtra = ''
    source ${nixosConfigDir}/users/configs/profile
  '';

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableAutosuggestions = true;
  programs.zsh.initExtra = ''
    source ${nixosConfigDir}/users/configs/zshrc
  '';

  xdg.userDirs.download = "\$HOME/downloads";

  xdg.configFile = {
    "compton/compton.conf".source= ./configs/compton.conf;
    "deluge/blocklist.conf".source= ./configs/delugeblocklist;
    "deluge/plugins/Pieces-0.5-py2.7.egg".source= ./configs/delugepieces.egg;
    "deluge/plugins/SequentialDownload-1.0-py2.7.egg".source= ./configs/delugesequential.egg;
    "dunst/dunstrc".source= ./configs/dunstrc;
    "homepage/index.html".source= ./configs/homepage.html;
    "homepage/style.css".source= ./configs/homepage.css;
    "i3/config".source = ./configs/i3config;
    "i3blocks/config".source = ./configs/i3blocksconfig;
    "kitty/kitty.conf".source = ./configs/kitty.conf;
    "mpd/mpd.conf".source = ./configs/mpd.conf;
    "mpv/mpv.conf".source = ./configs/mpv.conf;
    "mpv/input.conf".source = ./configs/mpvinput.conf;
    "mpv/scripts/reload.lua".source = ./configs/mpvreload.lua;
    "mpv/scripts/webm.lua".source = ./configs/mpvwebm.lua;
    "ncmpcpp/bindings".source = ./configs/ncmpcppbindings;
    "ncmpcpp/config".source = ./configs/ncmpcppconfig;
    "newsboat/config".source = ./configs/newsboatconfig;
    "nixpkgs/config.nix".source = ../pkgs/nixpkgs-config.nix;
    "qutebrowser/config.py".source= ./configs/qutebrowser.py;
    "qutebrowser/jblock".source = (builtins.fetchTarball "https://gitlab.com/jgkamat/jblock/-/archive/master/jblock-master.tar.gz");
    "ranger/commands.py".source = ./configs/rangercommands.py;
    "ranger/rc.conf".source = ./configs/rangerrc.conf;
    "ranger/rifle.conf".source = ./configs/rangerrifle.conf;
    "ranger/scope.sh".source = ./configs/rangerscope.sh;
    "zathura/zathurarc".source = ./configs/zathurarc;
    "aliasrc".source = ./configs/aliasrc;
    "emoji".source = ./configs/emoji;
    "fontawesome".source = ./configs/fontawesome;
    "inputrc".source = ./configs/inputrc;
    "mimeapps.list".source = ./configs/mimeapps.list;
  };

  xdg.dataFile = {
    "applications".source = ./share/applications;
    "mutt-wizard".source = ./share/mutt-wizard;
    "qutebrowser/greasemonkey".source = ./share/greasemonkey;
    "qutebrowser/userscripts".source = ./share/userscripts;
  };

  home.file = {
    ".local/bin".source = ./bin;
    "dox/latex/templates/article.tex".source = ./share/templates/article.tex;
    "dox/latex/templates/presentation.tex".source = ./share/templates/presentation.tex;
    ".xinitrc".source = ./configs/xinitrc;
    ".calcurse/conf".source= ./configs/calcurseconf;
  };



  home.packages = with pkgs; [
    ####vim
    vimCustom
    ####sysutil
    htop
    libnotify
    acpi
    inotify-tools
    xdg_utils
    ####dev
    git
    ksshaskpass
    gawk
    jq
    python3
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
    ueberzug
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
    nudoku
    ripcord
    ####misc
    tty-clock
    calcurse
    newsboat
    pywal
    nix-prefetch-scripts
    nix-prefetch-github
    ##i3
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
    compton-tryone
    numlockx
    ##kde gui
    plasma-integration
    libsForQt5.kio
    breeze-qt5
    breeze-icons
    kdeApplications.kio-extras
    ffmpegthumbs
    kdeApplications.kdegraphics-thumbnailers
  ];
}
