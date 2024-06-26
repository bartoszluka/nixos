{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware/master";
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
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
    nix-ld.inputs.nixpkgs.follows = "unstable";

    # Neovim
    nvim-nix.url = "path:/home/bartek/nvim.nix";
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
    # hyprfocus = {
    #   url = "github:pyt0xic/hyprfocus";
    #   inputs.hyprland.follows = "hyprland";
    # };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
    ags.url = "github:Aylur/ags";
    feedback.url = "github:NorfairKing/feedback";
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    unstable = import inputs.unstable {system = system;};
  in {
    nixosConfigurations.thinkpad = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs unstable;};
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

            users."bartek" = import ./home.nix;
          };
        }
        inputs.stylix.nixosModules.stylix
      ];
    };
  };
}
