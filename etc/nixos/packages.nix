{ config, lib, pkgs, ... }:


let
  #this is for the wayland overlay by colemickens
  wayurl = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball wayurl));
in
{

  #ancient technology
  #services.xserver.windowManager.i3.enable = true;
  #services.xserver.displayManager.startx.enable = true;
  services.xserver.enable = false;

  #edits to packages
  nixpkgs.overlays = [ waylandOverlay ]; #overlay for wayland packages
  nixpkgs.config = {
  		packageOverrides = pkgs: {
			#nix user repository
  			nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      				inherit pkgs;
    				};
			stable = import <stable> {};
			ncmpcpp = pkgs.ncmpcpp.override { visualizerSupport = true; }; #enable visualiser support
			wine = pkgs.wine.override { wineBuild = "wineWow"; }; #enable both 32bit and 64bit support
		};
		allowUnfree = true;
  };


  environment = {
	systemPackages = with pkgs; [
    ####vim
    neovim
    ####sysutil
    stable.networkmanagerapplet
    #python37Packages.glances
    stable.htop
    libnotify
    stable.pciutils
    stable.killall
    stable.xdg_utils
    stable.usbutils
    stable.acpi
    stable.inotify-tools
    ####dev
    stable.git
    stable.gawk
    stable.jq
    websocat
    ####audio
    pavucontrol
    stable.pulsemixer
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
    imv
    imagemagick
    stable.w3m
    krita
    gmic_krita_qt
    ####documents
    zathura
    libreoffice
    ####shell
    stable.libqalculate
    kitty
    ####files
    ranger
    syncthing
    stable.jmtpfs
    keepassxc
    unrar
    stable.zip
    stable.unzip
    stable.p7zip
    stable.dex
    stable.fzf
    stable.ripgrep
    stable.perl528Packages.FileMimeInfo
    ffmpeg
    stable.pandoc
    ####Ranger utils
    stable.atool
    stable.libarchive
    stable.mupdf
    stable.ffmpegthumbnailer
    stable.exiftool
    stable.file
    stable.poppler_utils
    ####web
    qutebrowser
    youtube-dl
    stable.wget
    stable.lynx
    ####torrent
    deluge
    ####mail
    neomutt
    isync
    msmtp
    pass
    gnupg
    urlscan
    notmuch
    ####latex
    stable.texlive.combined.scheme-full
    ####gaymen
    wine
    nur.repos.chagra.nudoku
    nur.repos.chagra.ripcord
    ####misc
    stable.tty-clock
    calcurse
    stable.newsboat
    ####nix stuff
    nix-prefetch-scripts
    nix-prefetch-github
    ####Sway improvements
    stable.pango
    light
    nur.repos.chagra.bemenu
    i3blocks
    neofetch
    pywal
    ydotool
  	];
  };

  qt5.platformTheme = "kde";
  services.xserver.desktopManager.plasma5.enable = true;

  #sway window manager
  programs.sway.enable = true;
  programs.sway.extraPackages = with pkgs; [
	xwayland
	swaybg
	swayidle
	swaylock
	grim
	slurp
	mako
	redshift-wayland
	wf-recorder
	wl-clipboard
	];

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

}
