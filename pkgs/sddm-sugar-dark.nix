{ stdenv, fetchFromGitHub, fetchurl }:

let
imgLink = "https://raw.githubusercontent.com/Goxore/dotfiles/50db864d56d49768f1d4d0a8c1bd7a5c74dd629e/home/Wallpapers/gruvbox-mountain-village.png";

image = fetchurl {
    url = imgLink;
    sha256 = "sha256-HrcYriKliK2QN02/2vFK/osFjTT1NamhGKik3tozGU0=";
};
in
{

    sddm-sugar-dark = stdenv.mkDerivation rec {
        pname = "sddm-sugar-dark-theme";
        version = "1.2";
        dontBuild = true;
        installPhase = ''
            mkdir -p $out/share/sddm/themes
            cp -aR $src $out/share/sddm/themes/sugar-dark
        '';
        src = fetchFromGitHub {
            owner = "MarianArlt";
            repo = "sddm-sugar-dark";
            rev = "v${version}";
            sha256 = "0gx0am7vq1ywaw2rm1p015x90b75ccqxnb1sz3wy8yjl27v82yhb";
        };
    };
}
