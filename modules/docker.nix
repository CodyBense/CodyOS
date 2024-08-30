{ ... }:
{
    virtualisation.docker.enable = true;
    users.users.codybense.extraGroups = [ "docker" ];

    virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
    };
}
