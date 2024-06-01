{config, ...}: {
  programs.qutebrowser = {
    enable = true;
    greasemonkey = [];
    searchEngines = {
      DEFAULT = "https://searx.jaimo.fun/search?q={}";
      w = "https://en.wikipedia.org/wiki/Special:Search?search={}&go=Go&ns0=1";
      nw = "https://wiki.nixos.org/index.php?search={}";
      n = "https://search.nixos.org/packages?channel=unstable&type=packages&query={}";
    };
    settings = with config.colorScheme.palette; {
      colors = {
        ## Background color of the completion widget category headers.
        ## Type: QssColor
        completion.category.bg = "#${base00}";

        ## Bottom border color of the completion widget category headers.
        ## Type: QssColor
        completion.category.border.bottom = "#${base00}";

        ## Top border color of the completion widget category headers.
        ## Type: QssColor
        completion.category.border.top = "#${base00}";

        ## Foreground color of completion widget category headers.
        ## Type: QtColor
        completion.category.fg = "#${base05}";

        ## Background color of the completion widget for even rows.
        ## Type: QssColor
        completion.even.bg = "#${base00}";

        ## Background color of the completion widget for odd rows.
        ## Type: QssColor
        completion.odd.bg = "#${base00}";

        ## Text color of the completion widget.
        ## Type: QtColor
        completion.fg = "#${base04}";

        ## Background color of the selected completion item.
        ## Type: QssColor
        completion.item.selected.bg = "#${base03}";

        ## Bottom border color of the selected completion item.
        ## Type: QssColor
        completion.item.selected.border.bottom = "#${base03}";

        ## Top border color of the completion widget category headers.
        ## Type: QssColor
        completion.item.selected.border.top = "#${base03}";

        ## Foreground color of the selected completion item.
        ## Type: QtColor
        completion.item.selected.fg = "#${base06}";

        ## Foreground color of the matched text in the completion.
        ## Type: QssColor
        completion.match.fg = "#${base0A}";

        ## Color of the scrollbar in completion view
        ## Type: QssColor
        completion.scrollbar.bg = "#${base00}";

        ## Color of the scrollbar handle in completion view.
        ## Type: QssColor
        completion.scrollbar.fg = "#${base05}";

        ## Background color for the download bar.
        ## Type: QssColor
        downloads.bar.bg = "#${base00}";

        ## Background color for downloads with errors.
        ## Type: QtColor
        downloads.error.bg = "#${base08}";

        ## Foreground color for downloads with errors.
        ## Type: QtColor
        downloads.error.fg = "#${base05}";

        ## Color gradient stop for download backgrounds.
        ## Type: QtColor
        downloads.stop.bg = "#${base0E}";

        ## Color gradient interpolation system for download backgrounds.
        ## Type: ColorSystem
        ## Valid values:
        ##   - rgb: Interpolate in the RGB color system.
        ##   - hsv: Interpolate in the HSV color system.
        ##   - hsl: Interpolate in the HSL color system.
        ##   - none: Don't show a gradient.
        downloads.system.bg = "none";

        ## Background color for hints. Note that you can use a `rgba(...)` value
        ## for transparency.
        ## Type: QssColor
        hints.bg = "#${base0A}";

        ## Font color for hints.
        ## Type: QssColor
        hints.fg = "#${base00}";

        ## Font color for the matched part of hints.
        ## Type: QssColor
        hints.match.fg = "#${base0F}";

        ## Background color of the keyhint widget.
        ## Type: QssColor
        keyhint.bg = "#${base00}";

        ## Text color for the keyhint widget.
        ## Type: QssColor
        keyhint.fg = "#${base05}";

        ## Highlight color for keys to complete the current keychain.
        ## Type: QssColor
        keyhint.suffix.fg = "#${base0A}";

        ## Background color of an error message.
        ## Type: QssColor
        messages.error.bg = "#${base08}";

        ## Border color of an error message.
        ## Type: QssColor
        messages.error.border = "#${base08}";

        ## Foreground color of an error message.
        ## Type: QssColor
        messages.error.fg = "#${base05}";

        ## Background color of an info message.
        ## Type: QssColor
        messages.info.bg = "#${base0C}";

        ## Border color of an info message.
        ## Type: QssColor
        messages.info.border = "#${base0C}";

        ## Foreground color an info message.
        ## Type: QssColor
        messages.info.fg = "#${base05}";

        ## Background color of a warning message.
        ## Type: QssColor
        messages.warning.bg = "#${base09}";

        ## Border color of a warning message.
        ## Type: QssColor
        messages.warning.border = "#${base09}";

        ## Foreground color a warning message.
        ## Type: QssColor
        messages.warning.fg = "#${base05}";

        ## Background color for prompts.
        ## Type: QssColor
        prompts.bg = "#${base02}";

        # ## Border used around UI elements in prompts.
        # ## Type: String
        c.colors.prompts.border = "1px solid #${base00}";

        ## Foreground color for prompts.
        ## Type: QssColor
        prompts.fg = "#${base05}";

        ## Background color for the selected item in filename prompts.
        ## Type: QssColor
        prompts.selected.bg = "#${base03}";

        ## Background color of the statusbar in caret mode.
        ## Type: QssColor
        statusbar.caret.bg = "#${base0E}";

        ## Foreground color of the statusbar in caret mode.
        ## Type: QssColor
        statusbar.caret.fg = "#${base05}";

        ## Background color of the statusbar in caret mode with a selection.
        ## Type: QssColor
        statusbar.caret.selection.bg = "#${base0E}";

        ## Foreground color of the statusbar in caret mode with a selection.
        ## Type: QssColor
        statusbar.caret.selection.fg = "#${base05}";

        ## Background color of the statusbar in command mode.
        ## Type: QssColor
        statusbar.command.bg = "#${base02}";

        ## Foreground color of the statusbar in command mode.
        ## Type: QssColor
        statusbar.command.fg = "#${base05}";

        ## Background color of the statusbar in private browsing + command mode.
        ## Type: QssColor
        statusbar.command.private.bg = "#${base02}";

        ## Foreground color of the statusbar in private browsing + command mode.
        ## Type: QssColor
        statusbar.command.private.fg = "#${base05}";

        ## Background color of the statusbar in insert mode.
        ## Type: QssColor
        statusbar.insert.bg = "#${base0B}";

        ## Foreground color of the statusbar in insert mode.
        ## Type: QssColor
        statusbar.insert.fg = "#${base00}";

        ## Background color of the statusbar.
        ## Type: QssColor
        statusbar.normal.bg = "#${base00}";

        ## Foreground color of the statusbar.
        ## Type: QssColor
        statusbar.normal.fg = "#${base05}";

        ## Background color of the statusbar in passthrough mode.
        ## Type: QssColor
        statusbar.passthrough.bg = "#${base0F}";

        ## Foreground color of the statusbar in passthrough mode.
        ## Type: QssColor
        statusbar.passthrough.fg = "#${base05}";

        ## Background color of the statusbar in private browsing mode.
        ## Type: QssColor
        statusbar.private.bg = "#${base03}";

        ## Foreground color of the statusbar in private browsing mode.
        ## Type: QssColor
        statusbar.private.fg = "#${base05}";

        ## Background color of the progress bar.
        ## Type: QssColor
        statusbar.progress.bg = "#${base05}";

        ## Foreground color of the URL in the statusbar on error.
        ## Type: QssColor
        statusbar.url.error.fg = "#${base08}";

        ## Default foreground color of the URL in the statusbar.
        ## Type: QssColor
        statusbar.url.fg = "#${base05}";

        ## Foreground color of the URL in the statusbar for hovered links.
        ## Type: QssColor
        statusbar.url.hover.fg = "#${base0C}";

        ## Foreground color of the URL in the statusbar on successful load
        ## (http).
        ## Type: QssColor
        statusbar.url.success.http.fg = "#${base05}";

        ## Foreground color of the URL in the statusbar on successful load
        ## (https).
        ## Type: QssColor
        statusbar.url.success.https.fg = "#${base0B}";

        ## Foreground color of the URL in the statusbar when there's a warning.
        ## Type: QssColor
        statusbar.url.warn.fg = "#${base09}";

        ## Background color of the tab bar.
        ## Type: QtColor
        tabs.bar.bg = "#${base03}";

        ## Background color of unselected even tabs.
        ## Type: QtColor
        tabs.even.bg = "#${base03}";

        ## Foreground color of unselected even tabs.
        ## Type: QtColor
        tabs.even.fg = "#${base05}";

        ## Color for the tab indicator on errors.
        ## Type: QtColor
        tabs.indicator.error = "#${base08}";

        ## Color gradient start for the tab indicator.
        ## Type: QtColor
        # c.colors.tabs.indicator.start = nord['violet']

        ## Color gradient end for the tab indicator.
        ## Type: QtColor
        # c.colors.tabs.indicator.stop = nord['orange']

        ## Color gradient interpolation system for the tab indicator.
        ## Type: ColorSystem
        ## Valid values:
        ##   - rgb: Interpolate in the RGB color system.
        ##   - hsv: Interpolate in the HSV color system.
        ##   - hsl: Interpolate in the HSL color system.
        ##   - none: Don't show a gradient.
        ctabs.indicator.system = "none";

        ## Background color of unselected odd tabs.
        ## Type: QtColor
        tabs.odd.bg = "#${base03}";

        ## Foreground color of unselected odd tabs.
        ## Type: QtColor
        tabs.odd.fg = "#${base05}";

        # ## Background color of selected even tabs.
        # ## Type: QtColor
        tabs.selected.even.bg = "#${base00}";

        # ## Foreground color of selected even tabs.
        # ## Type: QtColor
        tabs.selected.even.fg = "#${base05}";

        # ## Background color of selected odd tabs.
        # ## Type: QtColor
        tabs.selected.odd.bg = "#${base00}";

        # ## Foreground color of selected odd tabs.
        # ## Type: QtColor
        tabs.selected.odd.fg = "#${base05}";
      };
    };

    ## Background color for webpages if unset (or empty to use the theme's
    ## color)
    ## Type: QtColor
    # c.colors.webpage.bg = 'white' };
  };
}
