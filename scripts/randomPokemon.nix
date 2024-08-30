{ pkgs, ... }:

pkgs.writeShellScriptBin "randomPokemon" ''
pokemon=("gengar" "latios" "charizard" "typhlosion" "emboar" "hydreigon" "garchomp" "infernape" "salamence" "flygon" "mudkip" "scizor" "dragonite" "snorlax")

size=''${#pokemon[@]}
index=''$((''$RANDOM % ''$size))

shiny=''$((''$RANDOM%2))

if [ ''$shiny -eq 0 ]
then
    pokeget --hide-name ''${pokemon[$index]}
else
    pokeget --hide-name ''${pokemon[$index]} -s
fi
''
