{ pkgs, lib, ... }:
{
    nixpkgs.overlays = [
        (final: prev: {
         todo = pkgs.buildGoModule rec {
         pname = "todo_go";
         version = "1.4.1";

         src = pkgs.fetchFromGitHub {
         owner = "CodyBense";
         repo = "todo_go";
         rev = "v${version}";
         hash = "00e1d5d6a64572d150d3804a54718163fff1151c";
         };

         vendorHash = null;

         meta = {
         description = "Simple todo list tracker";
         homepage = "github.com/CodyBense/todo_go";
         license = lib.license.mit;
         maintainers = with lib.maintainers; [ CodyBense ];
         };

         };
        })
    ];
}
