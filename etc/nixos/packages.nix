{ config, lib, pkgs, ... }:


let
  #this is for the wayland overlay by colemickens
  wayurl = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball wayurl));
in
{

  #Nix Flakes
  #nix.package = pkgs.nixFlakes;

  #ancient technology
  #services.xserver.windowManager.i3.enable = true;
  #services.xserver.displayManager.startx.enable = true;
  services.xserver.enable = false;
  #services.compton.enable = true;

  #edits to packages
  nixpkgs.overlays = [ waylandOverlay ]; #overlay for wayland packages
  nixpkgs.config = {
  		packageOverrides = pkgs: {
			  #my nix user repository
  		  nur = import (builtins.fetchTarball "https://github.com/ihebchagra/nur-packages/archive/master.tar.gz") {
        				inherit pkgs;
    	  };
			  unstable = import <unstable> {};
			  ncmpcpp = pkgs.ncmpcpp.override { visualizerSupport = true; }; #enable visualiser support
			  wine = pkgs.wine.override { wineBuild = "wineWow"; }; #enable both 32bit and 64bit support
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
		allowUnfree = true;
  };


  environment = {
	systemPackages = with pkgs; [
		####vim
		neovim
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
    imv
		imagemagick
		krita
		gmic_krita_qt
		####documents
		zathura
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
		####nix stuff
		nix-prefetch-scripts
		nix-prefetch-github
		####Sway improvements
		pango
		light
    nur.bemenu
		i3blocks
		pywal
    nur.ydotool
  	];
  };

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
    wdisplays
    gebaar-libinput
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

}
