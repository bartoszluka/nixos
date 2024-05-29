{
  pkgs,
  inputs,
  config,
  ...
}: {
  programs.rbw = {
    enable = true;
    settings = {
      email = "bartoszluka1@gmail.com";
      # lock_timeout = 300;
      pinentry = pkgs.pinentry-curses;
    };
  };
}
