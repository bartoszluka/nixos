{pkgs, ...}: {
  programs.bottom = {
    enable = true;
    settings = {
      flags = {};
      row = [
        {
          ratio = 30;
          child = [
            {
              ratio = 3;
              type = "cpu";
            }
            {
              ratio = 1;
              type = "disk";
            }
          ];
        }
        {
          ratio = 30;
          child = [
            {
              ratio = 4;
              type = "mem";
            }
            {
              ratio = 3;
              type = "battery";
            }
          ];
        }

        {
          ratio = 40;
          child = [
            {
              type = "proc";
              default = true;
            }
          ];
        }
      ];
    };
  };
}
