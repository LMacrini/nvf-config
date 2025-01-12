{
  description = "My neovim config using nvf";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, nvf, systems }: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    packages = eachSystem (system: let
      pkgs = import nixpkgs {system = system;};
    in {
      default =
        (nvf.lib.neovimConfiguration {
          pkgs = pkgs;
          modules = [ ./nvf-configuration.nix ];
        }
    });
  };
}
