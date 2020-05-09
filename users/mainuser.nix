{ pkgs, ... }:

let
  inherit (import ../variables.nix) nixosConfigDir mainUser;
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

  xdg.userDirs = {
    download = "\$HOME/downloads";
    desktop = "\$HOME";
    documents = "\$HOME/dox";
    music = "\$HOME/music";
    pictures = "\$HOME/pix";
    templates = "\$HOME";
    videos = "\$HOME/videos";
  };

  xdg.configFile = {
    "compton/compton.conf".source= ./configs/compton.conf;
    "css-collection/markdown.css".source= ./configs/cssmarkdown;
    "deluge/blocklist.conf".source= ./configs/delugeblocklist;
    "deluge/plugins/Pieces-0.5-py2.7.egg".source= ./configs/delugepieces.egg;
    "deluge/plugins/SequentialDownload-1.0-py2.7.egg".source= ./configs/delugesequential.egg;
    "dunst/dunstrc".source= ./configs/dunstrc;
    "homepage/index.html".text= builtins.replaceStrings ["mainUser"] ["${mainUser}"] (builtins.readFile ./configs/homepage.html);
    "homepage/style.css".text= builtins.replaceStrings ["mainUser"] ["${mainUser}"] (builtins.readFile ./configs/homepage.css);
    "i3/config".source = ./configs/i3config;
    "i3blocks/config".source = ./configs/i3blocksconfig;
    "kitty/kitty.conf".source = ./configs/kitty.conf;
    "mutt/mutt-wizard.muttrc".source = (builtins.toPath "${pkgs.mutt-wizard}/share/mutt-wizard.muttrc");
    "mpd/mpd.conf".source = ./configs/mpd.conf;
    "mpv/mpv.conf".source = ./configs/mpv.conf;
    "mpv/input.conf".source = ./configs/mpvinput.conf;
    "mpv/scripts/webm.lua".source = builtins.fetchurl "https://raw.githubusercontent.com/ElegantMonkey/mpv-webm/master/build/webm.lua";
    "ncmpcpp/bindings".source = ./configs/ncmpcppbindings;
    "ncmpcpp/config".source = ./configs/ncmpcppconfig;
    "newsboat/config".source = ./configs/newsboatconfig;
    "nixpkgs/config.nix".source = ../pkgs/nixpkgs-config.nix;
    "qutebrowser/config.py".source= ./configs/qutebrowser.py;
    "qutebrowser/jblock".source = builtins.fetchTarball "https://gitlab.com/jgkamat/jblock/-/archive/master/jblock-master.tar.gz";
    "ranger/commands.py".source = ./configs/rangercommands.py;
    "ranger/rc.conf".source = ./configs/rangerrc.conf;
    "ranger/rifle.conf".source = ./configs/rangerrifle.conf;
    "ranger/scope.sh".source = ./configs/rangerscope.sh;
    "transliteration/transliteration.html".source = ./configs/transliteration.html;
    "zathura/zathurarc".source = ./configs/zathurarc;
    "wal/templates/colorskitty.conf".source = ./share/templates/pywalkittytemplate;
    "wal/templates/colorspython.py".source = ./share/templates/pywalpythontemplate.py;
    "wal/templates/zathuracolors".source = ./share/templates/pywalzathuratemplate;
    "aliasrc".source = ./configs/aliasrc;
    "emoji".source = ./configs/emoji;
    "fontawesome".source = ./configs/fontawesome;
    "inputrc".source = ./configs/inputrc;
    "mimeapps.list".source = ./configs/mimeapps.list;
  };

  xdg.dataFile = {
    "applications".source = ./share/applications;
    "qutebrowser/greasemonkey/4chanx.user.js".source = builtins.fetchurl "https://www.4chan-x.net/builds/4chan-X.user.js";
    "qutebrowser/greasemonkey/ffz.user.js".source = builtins.fetchurl "https://cdn.frankerfacez.com/static/ffz_injector.user.js";
    "qutebrowser/greasemonkey/4chancss.user.js".source = ./share/userscripts/4chancssuserscript;
    "qutebrowser/userscripts/changetogoogle".source = ./share/userscripts/changetogoogle;
    "qutebrowser/userscripts/configwithhostblocking".source = ./share/userscripts/configwithhostblocking;
    "qutebrowser/userscripts/configwithoutjblock".source = ./share/userscripts/configwithoutjblock;
    "qutebrowser/userscripts/follow4chan".source = ./share/userscripts/follow4chan;
    "qutebrowser/userscripts/updatecolors".source = ./share/userscripts/updatecolors;
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
    go
    gcc
    ####audio
    pavucontrol
    pulsemixer
    audacity
    mpd
    mpdris2
    mpc_cli
    ncmpcpp
    easytag
    spotify
    ####video
    mpv
    kdenlive
    ####img
    sxiv
    imagemagick
    feh
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
    screen
    ####files
    ranger
    syncthing
    jmtpfs
    unrar
    zip
    unzip
    fzf
    ffmpeg
    appimage-run
    ark
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
    weechat
    keepassxc
    ####Torrenting Linux ISOs
    deluge
    ####neomutt extras
    mutt-wizard
    neomutt
    isync
    msmtp
    pass
    gnupg
    notmuch
    lynx
    ####gaymen
    nudoku
    openjdk
    ####misc
    diary
    tty-clock
    calcurse
    newsboat
    pywal
    nix-prefetch-scripts
    nix-prefetch-github
    ##i3
    bemenu
    i3blocks
    personalblocks
    i3lock-fancy
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
