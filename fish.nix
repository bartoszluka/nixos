{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit =
      ''
        set fish_greeting # Disable greeting
        # binds control+y to accept current suggestion
        bind -M insert \cy forward-char
        zoxide init fish | source

        # match colors of the terminal in fish
        # set -U fish_color_autosuggestion brblack
        # set -U fish_color_cancel -r
        # set -U fish_color_command brgreen
        # set -U fish_color_comment brmagenta
        # set -U fish_color_cwd green
        # set -U fish_color_cwd_root red
        # set -U fish_color_end brmagenta
        # set -U fish_color_error brred
        # set -U fish_color_escape brcyan
        # set -U fish_color_history_current --bold
        # set -U fish_color_host normal
        # set -U fish_color_match --background=brblue
        # set -U fish_color_normal normal
        # set -U fish_color_operator cyan
        # set -U fish_color_param brblue
        # set -U fish_color_quote yellow
        # set -U fish_color_redirection bryellow
        # set -U fish_color_search_match bryellow '--background=brblack'
        # set -U fish_color_selection white --bold '--background=brblack'
        # set -U fish_color_status red
        # set -U fish_color_user brgreen
        # set -U fish_color_valid_path --underline
        # set -U fish_pager_color_completion normal
        # set -U fish_pager_color_description yellow
        # set -U fish_pager_color_prefix white --bold --underline
        # set -U fish_pager_color_progress brwhite '--background=cyan'

        set --export fish_key_bindings fish_vi_key_bindings

        # ctrl+o goes back a directory in normal and insert mode
        for mode in default insert
            bind -M $mode \co 'prevd; commandline -f repaint'
        end
        # binds control+f and control+y to accept current suggestion
        bind -M insert \cf forward-char
        bind -M insert \cy forward-char
      '';
    plugins = with pkgs.fishPlugins;
      map (pkg: {
        name = pkg.pname;
        src = pkg.src;
      })
      [
        grc
        hydro
        puffer
        plugin-git
        done
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
      kl = "killall";
      lg = "lazygit";
      chx = "chmod +x";
      r = "nh os switch";
    };
  };
}
