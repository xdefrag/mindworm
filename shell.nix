{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = with pkgs; [ aseprite-unfree blender godot sfxr ];
}
