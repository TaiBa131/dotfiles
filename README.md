# dotfiles
The entire system, including home directory dotfiles are declaratively managed with nix only using NixOS and home-manager.
This means that if you have nixos just git clone this into /etc/nixos and then type nixos-rebuild switch my entire configuration should be recreated.

I save my secrets in the users/private directory with a file called secrets.nix (not in this repo for obvious reasons). This file is then imported into my user file which is iheb.nix.

I use the nixos stable channel

![screenshot](rice.png)
