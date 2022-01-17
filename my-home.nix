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
        gnumake
        nmap
      ];

      nodejs = final.nodejs-14_x;
      nodejs-slim = final.nodejs-slim-14_x;

      myHome = pkgs.symlinkJoin {
        name = "myhome";
        paths = final.profilePackages;
      };
    };
}
