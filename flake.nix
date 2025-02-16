{
  description = "Nixos config flake";

  inputs = {
    nixpkgs-24-05.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware/master";
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # plusultra = {
    #   url = "github:jakehamilton/config";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.unstable.follows = "unstable";
    # };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Run unpatched dynamically compiled binaries
    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim
    nvim-nix = {
      # url = "path:${/home/bartek/nvim.nix}";
      url = "github:bartoszluka/nvim.nix/switch-to-nixcats";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
    # neovim-nightly.url = "github:nix-community/neovim-nightly-overlay?ref=master";

    bibata-cursors = {
      url = "github:suchipi/Bibata_Cursor";
      flake = false;
    };
    nix-colors.url = "github:misterio77/nix-colors";

    # sops-nix = {
    #   url = "github:Mic92/sops-nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # prism = {
    #   url = "github:IogaMaster/prism";
    #   inputs.nixpkgs.follows = "nixpkgs";
    #   inputs.home-manager.follows = "home-manager";
    # };

    # hyprland-plugins = {
    #   url = "github:/hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    hyprfocus = {
      url = "github:pyt0xic/hyprfocus";
      inputs.hyprland.follows = "hyprland";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
    feedback.url = "github:NorfairKing/feedback";
    stylix.url = "github:danth/stylix";
    firefox-nightly.url = "github:nix-community/flake-firefox-nightly";
    # nixcord.url = "github:kaylorben/nixcord";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    stable-24-05 = import inputs.stable-24-05 {system = system;};
  in {
    nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit system;
        inherit inputs;
      };
      modules = [
        nixos-hardware.nixosModules.lenovo-thinkpad-t470s
        ./configuration.nix
        inputs.nix-ld.nixosModules.nix-ld
        inputs.home-manager.nixosModules.default

        # make home-manager as a module of nixos
        # so that home-manager configuration will be deployed automatically when executing `nixos-rebuild switch`
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = {inherit inputs;};
            useGlobalPkgs = true;
            useUserPackages = true;
            sharedModules = [
              # inputs.nixcord.homeManagerModules.nixcord
            ];
            users."bartek" = import ./home.nix;
          };
        }
        inputs.stylix.nixosModules.stylix
        {nixpkgs.overlays = [inputs.hyprpanel.overlay];}
      ];
    };
  };
}
