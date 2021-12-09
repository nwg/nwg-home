{
  overlay = final: prev: let
    pkgs = final.pkgs;
  in {
    homedirPackages = with final; [ hugo emacs sieve-connect gnupg nodejs ripgrep github-cli ];
    nodejs = final.nodejs-16_x;

    nwgHome = final.pkgs.symlinkJoin {
      name = "nwg-home";
      paths = final.homedirPackages;
    };
  };

}
