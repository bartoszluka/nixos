# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  pkgs,
  inputs,
  lib,
  ...
}: let
  hyprland = inputs.hyprland.packages."${pkgs.system}".hyprland;
  firefox-nightly = inputs.firefox-nightly.packages."${pkgs.system}".firefox-nightly-bin;
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./kanata.nix
    ./stylix.nix
  ];
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://cache.garnix.io"
      "https://cache.iog.io"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];
  };
  programs.dconf.enable = true; # fix for home manager error with gtk apps
  services.greetd = rec {
    enable = true;
    package = pkgs.greetd.tuigreet;
    settings = {
      default_session = {
        command = "${lib.getExe package} --remember --time --asterisks --cmd ${lib.getExe hyprland}";
      };
    };
  };
  security.polkit.enable = true;
  # services.fprintd = {
  #   enable = true;
  #   tod = {
  #     enable = true;
  #     driver = pkgs.libfprint-2-tod1-vfs0090;
  #   };
  # };

  hardware.keyboard.qmk.enable = true;

  # nixpkgs.config.allowUnfree = true;

  programs.nh = {
    enable = true;
    clean = {
      dates = "weekly";
      enable = true;
    };
    flake = "${./.}";
  };
  # Use the GRUB 2 boot loader.
  # boot.loader.grub.enable = true;
  boot.loader.systemd-boot.enable = true;
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.efiInstallAsRemovable = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";
  # Define on which hard drive you want to install Grub.
  # boot.loader.grub.device = "/dev/sda"; # or "nodev" for efi only

  networking.hostName = "thinkpad"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  fonts.packages = with pkgs; [
    # (pkgs.nerdfonts.override {fonts = ["JetBrainsMono" "Iosevka" "FiraCode" "0xProto"];})
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts._0xproto
    pkgs.nerd-fonts.iosevka
    pkgs.nerd-fonts.fira-code
    cm_unicode
    rubik
    lato
    font-awesome
    # corefonts
  ];

  fonts.enableDefaultPackages = true;
  fonts.fontconfig = {
    defaultFonts = {
      monospace = ["JetBrainsMono Nerd Font Mono"];
      sansSerif = ["Lato" "JetBrainsMono Nerd Font"];
      serif = ["Lato" "JetBrainsMono Nerd Font"];
    };
  };

  # battery
  services.upower.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };
  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  powerManagement.powertop.enable = true;
  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  programs.noisetorch.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Experimental = true;
    };
  };
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  xdg.portal.configPackages = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.enable = true;

  hardware.brillo.enable = true;

  services.logind.lidSwitchDocked = "ignore";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # nixpkgs.overlays = [inputs.nvim-nix.overlays.default];
  programs.firefox.package = firefox-nightly;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bartek = {
    isNormalUser = true;
    extraGroups = ["networkmanager" "wheel" "input" "video"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # nvim-pkg # my custom neovim flake
    ];
    shell = pkgs.fish;
  };

  environment.systemPackages = with pkgs; [
    # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    # unstable.neovim
    fd
    rm-improved
    ripgrep
    sd
    xh
    alejandra
    stylua
    bat
    kitty
    foot
    vivaldi # this is from unfree
    git
    du-dust
    imagemagick
    killall
    libnotify # for notify-send
    tre-command
    kdePackages.polkit-qt-1
    yazi
    zip
    unzip
    gzip
    # image viewers
    sxiv
    vimiv-qt
    swayimg
    imv
    inputs.feedback.packages.${system}.default
    inputs.nvim-nix.packages.${system}.default
    qmk
  ];
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      # Add additional package names here
      "vivaldi"
      # "discord"
    ];

  programs.fish.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.postgresql = {
    enable = false;
    enableTCPIP = true;
    ensureDatabases = ["spliit"];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust

      #type database  DBuser  origin-address  auth-method
      host  all       all     localhost       trust
    '';
    identMap = ''
      # ArbitraryMapName    systemUser   DBUser
      superuser_map         root         postgres
      superuser_map         bartek       postgres

      # Let other names login as themselves
      superuser_map         /^(.*)$      \1
    '';
    ensureUsers = [
      {
        name = "spliit";
        ensureDBOwnership = true;
      }
    ];
    settings.port = 5432;
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?
}
