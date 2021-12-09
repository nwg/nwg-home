{
  description = "A very basic flake";

  inputs.flake-utils.url = github:nwg/flake-utils;

  outputs = { self, nixpkgs, flake-utils }:
    with flake-utils.lib;
    with nixpkgs.lib;
    let
      util = flake-utils.lib.flake-utils;
      myHome = import ./myhome.nix;
      overlays = [ myHome.overlay ];
      getPkgs = system: import nixpkgs { inherit overlays system; };
      systems = builtins.trace (builtins.toString util.defaultSystems) util.defaultSystems;
      forSystems = genAttrs systems;
    in {
      pkgs = genAttrs systems getPkgs;

      packages = forSystems (system: {
        nwgHome = self.pkgs."${system}".nwgHome;
      });

      defaultPackage = forSystems (system: self.packages."${system}".nwgHome);
    };

}
