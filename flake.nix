{
  description = "A very basic flake";

  inputs.flake-utils.url = github:nwg/flake-utils;

  outputs = { self, nixpkgs, flake-utils }:
    with flake-utils.lib;
    with nixpkgs.lib;
    let
      util = flake-utils.lib;
      myHome = import ./myhome.nix;
      overlays = [ myHome.overlay ];
      getPkgs = system: import nixpkgs { inherit overlays system; };
      systems = util.supportedSystems;
    in {
      pkgs = genAttrs systems getPkgs;

      packages = forSystems systems (system: {
        nwgHome = self.pkgs."${system}".nwgHome;
      });

      defaultPackage = forSystems systems (system: self.packages."${system}".nwgHome);
    };

}
