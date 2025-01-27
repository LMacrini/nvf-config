{
  description = "My neovim config using nvf";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nvf.url = "github:notashelf/nvf";
    systems.url = "github:nix-systems/default";
  };

  outputs = { self, nixpkgs, nvf, systems }: let
    eachSystem = nixpkgs.lib.genAttrs (import systems);
  in {
    packages = eachSystem (system: {
      default =
        (nvf.lib.neovimConfiguration {
          pkgs = import nixpkgs { inherit system; };
          modules = [ ./nvf-configuration.nix ];
        }
        ).neovim;
    });
  };
}
