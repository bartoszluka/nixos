{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./hyprland.nix
    ./waybar
    ./foot.nix
    ./firefox.nix
    ./wofi
    ./rnnoise.nix
    ./bitwarden.nix
    ./mako.nix
    ./bottom.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "bartek";
  home.homeDirectory = "/home/bartek";
  colorScheme = inputs.nix-colors.colorSchemes.nord;

  qt.enable = true;
  qt.platformTheme = "gtk";
  qt.style.name = "adwaita-dark";

  programs.git = {
    enable = true;
    userEmail = "bartoszluka1@gmail.com";
    userName = "bartek";
    delta.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  services.udiskie.enable = true;

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "adwaita-dark";
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    wl-clipboard
    eww
    swww
    networkmanagerapplet
    wofi
    zoxide
    grc
    eza
    bottom
    fzy
    pamixer
    pavucontrol
    signal-desktop
    armcord
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      # binds control+y to accept current suggestion
      bind -M insert \cy forward-char
      zoxide init fish | source

      # match colors of the terminal in fish
      set -U fish_color_autosuggestion brblack
      set -U fish_color_cancel -r
      set -U fish_color_command brgreen
      set -U fish_color_comment brmagenta
      set -U fish_color_cwd green
      set -U fish_color_cwd_root red
      set -U fish_color_end brmagenta
      set -U fish_color_error brred
      set -U fish_color_escape brcyan
      set -U fish_color_history_current --bold
      set -U fish_color_host normal
      set -U fish_color_match --background=brblue
      set -U fish_color_normal normal
      set -U fish_color_operator cyan
      set -U fish_color_param brblue
      set -U fish_color_quote yellow
      set -U fish_color_redirection bryellow
      set -U fish_color_search_match bryellow '--background=brblack'
      set -U fish_color_selection white --bold '--background=brblack'
      set -U fish_color_status red
      set -U fish_color_user brgreen
      set -U fish_color_valid_path --underline
      set -U fish_pager_color_completion normal
      set -U fish_pager_color_description yellow
      set -U fish_pager_color_prefix white --bold --underline
      set -U fish_pager_color_progress brwhite '--background=cyan'

      set --export fish_key_bindings fish_vi_key_bindings

      # ctrl+o goes back a directory in normal and insert mode
      for mode in default insert
          bind -M $mode \co 'prevd; commandline -f repaint'
      end
      # binds control+f and control+y to accept current suggestion
      bind -M insert \cf forward-char
      bind -M insert \cy forward-char
    '';
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
    ];
    shellAliases = {
      ls = "eza";
    };

    shellAbbrs = {
      q = "exit";
      bh = {
        position = "anywhere";
        expansion = "--help | bat --language help";
      };
      chx = "chmod +x";
    };
  };

  programs.bat = {
    enable = true;
    config = {
      map-syntax = [
        "flake.lock:JSON"
        ".ignore:Git Ignore"
      ];
      pager = "less -FR";
      theme = "Nord";
    };
  };
  programs.tealdeer = {
    enable = true;

    settings = {
      display = {
        compact = false;
        use_pager = true;
      };
      updates = {
        auto_update = true;
        auto_update_interval_hours = 24;
      };
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/bartek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
