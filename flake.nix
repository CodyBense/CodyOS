{
  description = "CodyOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = { self, nixpkgs, home-manager, spicetify-nix, ... }@inputs:
  let
    system = "x86_64-linux";
    host = "laptop";
    username = "codybense";
  in
  {
      nixosConfigurations = {
          ${host} = nixpkgs.lib.nixosSystem {
              specialArgs = {
                  inherit system;
                  inherit inputs;
                  inherit username;
                  inherit host;
              };
              modules = [
                ./hosts/${host}/configuration.nix
                inputs.stylix.nixosModules.stylix
                home-manager.nixosModules.home-manager
                {
                    home-manager.extraSpecialArgs = {
                        inherit username;
                        inherit inputs;
                        inherit host;
                        inherit spicetify-nix;
                    };
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = "backup";
                    home-manager.users.${username} = import ./hosts/${host}/home.nix;
                }
              ];
          };
      };
  };
}
