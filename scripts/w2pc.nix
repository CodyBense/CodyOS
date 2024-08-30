{ pkgs, ... }:

pkgs.writeShellScriptBin "w2pc" ''
#!/usr/bin/env bash

wakeonlan 00:E0:4C:68:09:56
''
