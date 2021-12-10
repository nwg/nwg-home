{
  overlay = final: prev: let
    pkgs = final.pkgs;
  in {
    homedirPackages = with final; [ hugo emacs sieve-connect gnupg nodejs_latest ripgrep github-cli jq yarn yarn2nix ];
    nodejs = final.nodejs_latest;
    nodejs-slim = final.nodejs-slim_latest;
    nodePackages = final.nodePackages_latest;

    nwgHome = pkgs.symlinkJoin {
      name = "nwg-home";
      paths = final.homedirPackages;
    };
  };

}
