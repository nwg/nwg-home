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
        nodejs_latest
        ripgrep
        github-cli
        jq
        yarn
        yarn2nix
      ];

      nodejs = final.nodejs_latest;
      nodejs-slim = final.nodejs-slim_latest;
      nodePackages = final.nodePackages_latest;

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
