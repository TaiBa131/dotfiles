{ config, lib, pkgs, ... }:

{
  fonts = {

	enableFontDir = true;
	enableGhostscriptFonts = true;
	fonts = with pkgs; [
		inconsolata
		font-awesome_4
    freefont_ttf
		terminus_font
		corefonts
		dejavu_fonts
		noto-fonts
		noto-fonts-extra
		noto-fonts-cjk
		noto-fonts-emoji
		source-code-pro
		libertinus
		libertine
		profont
		liberation_ttf
	];

  enableDefaultFonts = true;
  fontconfig = {
    penultimate.enable = false;
    defaultFonts = {
      serif = [ "Linux Libertine" ];
      sansSerif = [ "DejaVu Sans" ];
      monospace = [ "Inconsolata" "FontAwesome" ];
    };
  };

  };

}
