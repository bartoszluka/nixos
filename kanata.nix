{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.bartek.extraGroups = ["uinput"]; # for kanata to work

  services.kanata = {
    enable = true;
    keyboards.main = {
      config = ''
        (defsrc
          grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab  q    w    e    r    t    y    u    i    o    p    [    ]    \
          caps a    s    d    f    g    h    j    k    l    ;    '    ret
          lsft z    x    c    v    b    n    m    ,    .    /    rsft
          lctl lmet lalt           spc            ralt prnt rctl
        )

        ;; left half
        (defalias
          s-v (tap-hold-release 30 200 v lsft) ;; shift/v
          c-c (tap-hold-release 30 200 c lctl) ;; ctrl/c
          w-s (tap-hold-release 30 200 s lmet) ;; sin/s
          a-a (tap-hold-release 30 200 a lalt) ;; alt/a
        )

        ;; right half
        (defalias
          ;; s-j (tap-hold-hold-release 30 500 400 j rsft) ;; shift/j
          s-m (tap-hold-release 30 200 m rsft) ;; shift/m
          c-, (tap-hold-release 30 200 , rctl) ;; ctrl/,
          w-l (tap-hold-release 30 200 l rmet) ;; win/l
          a-; (tap-hold-release 30 200 ; lalt) ;; alt/;
        )

        (defalias a-bsp (tap-hold-release 30 200 bspc lalt))

        (deflayer qwerty
          grv   1    2    3    4    5    6    7    8    9    0    -    =    bspc
          tab   q    w    e    r    t    y    u    i    o    p    [    ]    \
          esc   @a-a @w-s d    f    g    h    j    k    @w-l @a-; '    ret
          lsft z    x    @c-c @s-v b    n    @s-m @c-, .    /    rsft
          lctl  lmet @a-bsp         spc            ralt prnt rctl
        )

        (deflayer alt-gr
          _   _   _   _    _    _    _     _    _    _    _    _    _    _
          _   _   _   _    _    _    _     _    _    _    _    _    _    _
          _   a   s   _    _    _    _     _    _    l    _   _    _
          _   _   _   c    _    _    _     _    _    _    _    _
          _   _   _             _               _    _    _
        )
      '';
      devices = ["/dev/input/by-path/platform-i8042-serio-0-event-kbd"];
    };
  };
}
