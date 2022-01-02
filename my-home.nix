{ nixpkgs }:
{
  overlay = final: prev:
    let
      lib = final.lib;
      pkgs = final.pkgs;

    in {

      profilePackages = with final; [
        hugo
        emacs
        sieve-connect
        gnupg
        nodejs
        ripgrep
        github-cli
        jq
        yarn
        yarn2nix
      ];

      /*
      vlc = let
        withDarwin = self: with self; {
          stdenv = prev.stdenv // {
            mkDerivation = args: prev.stdenv.mkDerivation (args // {
              meta.platforms = args.meta.platforms ++ final.lib.platforms.darwin;
            });
          };
        };

        darwinScope = pkgs.lib.makeScope prev.libsForQt5.newScope withDarwin;
      in
        darwinScope.callPackage "${nixpkgs}/pkgs/applications/video/vlc" {};
        */
      /*
      vlc = prev.vlc.overrideAttrs (oldAttrs: {
        meta.platforms = oldAttrs.meta.platforms ++ lib.platforms.darwin;
      });
      */

      myHome = pkgs.symlinkJoin {
        name = "myhome";
        paths = final.profilePackages;
      };
    };
}
